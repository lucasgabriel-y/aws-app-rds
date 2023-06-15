resource "aws_wafv2_ip_set" "ip_set" {
  name        = "ip-set-example"
  description = "IP Set example"
  scope = "REGIONAL"
  ip_address_version = "IPV4"
  
  addresses = [
    "192.0.2.0/24",
    "203.0.113.0/24"
  ]
}


resource "aws_wafv2_web_acl" "tf_waf" {
  name        = "waf-acl-example"
  description = "WAF ACL example"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "ip-rule-example"
    priority = 1

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics"
      sampled_requests_enabled   = true
    }
}
  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "metric"
    sampled_requests_enabled   = false
  }

}


resource "aws_wafv2_web_acl_association" "waf_alb" {
  resource_arn = aws_lb.tf_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.tf_waf.arn
}
