# 1. Locals definition mapping the 4 event types
locals {
  events = {
    spot_interruption = {
      source      = ["aws.ec2"]
      detail-type = ["EC2 Spot Instance Interruption Warning"]
    }
    rebalance = {
      source      = ["aws.ec2"]
      detail-type = ["EC2 Instance Rebalance Recommendation"]
    }
    instance_state_change = {
      source      = ["aws.ec2"]
      detail-type = ["EC2 Instance State-change Notification"]
    }
    scheduled_change = {
      source      = ["aws.health"]
      detail-type = ["AWS Health Event"]
    }
  }
}

# 2. CloudWatch / EventBridge Rules using for_each
resource "aws_cloudwatch_event_rule" "karpenter_interruption" {
  for_each = local.events

  name        = "karpenter-${each.key}-${var.cluster_name}"
  description = "Karpenter interruption rule for ${each.key}"

  event_pattern = jsonencode({
    source        = each.value.source
    "detail-type" = each.value.detail-type
  })

  tags = local.common_tags
}

# 3. EventBridge Targets pointing each rule to your spot_interruption_queue
resource "aws_cloudwatch_event_target" "karpenter_interruption_target" {
  for_each = local.events

  rule      = aws_cloudwatch_event_rule.karpenter_interruption[each.key].name
  target_id = "KarpenterInterruptionQueue"
  arn       = aws_sqs_queue.spot_interruption_queue.arn
}

# 4. SQS Queue Policy granting EventBridge permission to send messages to the queue
data "aws_iam_policy_document" "karpenter_sqs_policy" {
  statement {
    sid    = "AllowEventBridgeToSendMessage"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.spot_interruption_queue.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [for rule in aws_cloudwatch_event_rule.karpenter_interruption : rule.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "karpenter_interruption_policy" {
  queue_url = aws_sqs_queue.spot_interruption_queue.id
  policy    = data.aws_iam_policy_document.karpenter_sqs_policy.json
}

