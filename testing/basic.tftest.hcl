mock_provider "aws" {}

run "secure_defaults" {
  command = plan

  variables {
    default_tags = {
      Environment = "test"
      Project     = "terraform-modules"
      Owner       = "platform"
    }

    launch_template_config = {
      workers = {}
    }
  }

  assert {
    condition     = aws_launch_template.lt["workers"].name == "lt-workers"
    error_message = "The legacy key-derived name must remain stable when no explicit name is set."
  }

  assert {
    condition     = aws_launch_template.lt["workers"].metadata_options[0].http_tokens == "required"
    error_message = "IMDSv2 must remain required by default."
  }

  assert {
    condition     = aws_launch_template.lt["workers"].tags["Owner"] == "platform"
    error_message = "Mandatory default tags must be applied to the launch template."
  }
}

run "supports_name_prefix" {
  command = plan

  variables {
    default_tags = {
      Environment = "test"
      Project     = "terraform-modules"
      Owner       = "platform"
    }

    launch_template_config = {
      workers = {
        name_prefix = "workers-"
      }
    }
  }

  assert {
    condition     = aws_launch_template.lt["workers"].name_prefix == "workers-"
    error_message = "Explicit name_prefix must be forwarded to AWS."
  }
}

run "renders_advanced_nested_blocks" {
  command = plan

  variables {
    default_tags = {
      Environment = "test"
      Project     = "terraform-modules"
      Owner       = "platform"
    }

    launch_template_config = {
      workers = {
        capacity_reservation_specification = {
          capacity_reservation_preference = "capacity-reservations-only"
          capacity_reservation_target = {
            capacity_reservation_id = "cr-0123456789abcdef0"
          }
        }
        instance_requirements = {
          network_bandwidth_gbps = {
            min = 10
            max = 25
          }
          network_interface_count = {
            min = 2
            max = 4
          }
        }
      }
    }
  }

  assert {
    condition     = aws_launch_template.lt["workers"].capacity_reservation_specification[0].capacity_reservation_target[0].capacity_reservation_id == "cr-0123456789abcdef0"
    error_message = "The capacity reservation target must render as one nested block."
  }

  assert {
    condition     = aws_launch_template.lt["workers"].instance_requirements[0].network_bandwidth_gbps[0].min == 10
    error_message = "Network bandwidth must use its own input instead of network interface count."
  }
}

run "rejects_removed_accelerators" {
  command = plan

  variables {
    default_tags = {
      Environment = "test"
      Project     = "terraform-modules"
      Owner       = "platform"
    }

    launch_template_config = {
      workers = {
        elastic_inference_accelerator = {
          type = "eia1.medium"
        }
      }
    }
  }

  expect_failures = [var.launch_template_config]
}

run "rejects_missing_mandatory_tags" {
  command = plan

  variables {
    launch_template_config = {
      workers = {}
    }
  }

  expect_failures = [var.launch_template_config]
}
