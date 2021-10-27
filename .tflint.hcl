config {
  module = true
  force = false
}

plugin "aws" {
  enabled = true
  deep_check = false
}

rule "terraform_module_pinned_source" {
  enabled = false
}
