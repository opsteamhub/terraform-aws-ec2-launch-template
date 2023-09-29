variable "launch_template_config" {
  description = "AWS EC2 Launch Template configs."
  type = map(
    object(
      {
        block_device_mappings = optional(
          set(
            object(
              {
                device_name = optional(string)
                ebs = optional(
                  object(
                    {
                      delete_on_termination = optional(bool, true)
                      encrypted             = optional(bool, true)
                      iops                  = optional(string, 3000)
                      kms_key_id            = optional(string)
                      snapshot_id           = optional(string)
                      throughput            = optional(string, 125)
                      volume_size           = optional(string, 20)
                      volume_type           = optional(string, "gp3")
                    }
                  ),
                  {}
                )
                no_device    = optional(string)
                virtual_name = optional(string)
              }
            ) #, { }
          ), []
        )
        capacity_reservation_specification = optional(
          object(
            {
              capacity_reservation_preference = optional(string, "none")
              capacity_reservation_target = optional(
                object(
                  {
                    capacity_reservation_id                 = optional(string)
                    capacity_reservation_resource_group_arn = optional(string)
                  }
                )
              )
            }
          ), {}
        )
        cpu_options = optional(
          object(
            {
              amd_sev_snp      = optional(string, "enabled")
              core_count       = optional(string, 4)
              threads_per_core = optional(string, 2)
            }
          )
        )
        credit_specification = optional(
          object(
            {
              cpu_credits = optional(string, "unlimited")
            }
          ),
          {}
        )
        default_version                    = optional(string)
        description                        = optional(string)
        disable_api_stop_compatible        = optional(bool, true)
        disable_api_stop                   = optional(bool, true)
        disable_api_termination_compatible = optional(bool, true)
        disable_api_termination            = optional(bool, true)
        ebs_optimized                      = optional(bool, true)
        elastic_gpu_specifications = optional(
          object(
            {
              type = optional(string, "eg1.medium")
            }
          )
        )
        elastic_inference_accelerator = optional(
          object(
            {
              type = optional(string)
            }
          )
        )
        enclave_options = optional(
          object(
            {
              enabled = optional(bool, false)
            }
          ), {}
        )
        hibernation_options = optional(
          object(
            {
              configured = optional(bool, false)
            }
          ), {}
        )
        iam_instance_profile = optional(
          object(
            {
              arn  = optional(string)
              name = optional(string)
            }
          )
        )
        ami = optional(
          object(
            {
              ami_filters = optional(
                list(
                  object(
                    {
                      name   = optional(string)
                      values = optional(list(string))
                    }
                  )
                )
              )
              executable_users   = optional(set(string))
              image_id           = optional(string)
              include_deprecated = optional(bool, false)
              most_recent        = optional(bool, true)
              name_regex         = optional(string)
              owners             = optional(set(string), ["self"])
            }
          )
        )
        instance_initiated_shutdown_behavior_compatible = optional(bool, true)
        instance_initiated_shutdown_behavior            = optional(string, "stop")
        instance_market_options = optional(
          object(
            {
              market_type = optional(string)
              spot_options = optional(
                object(
                  {
                    block_duration_minutes         = optional(string)
                    instance_interruption_behavior = optional(string, "terminate")
                    max_price                      = optional(string)
                    spot_instance_type             = optional(string)
                    valid_until                    = optional(string)
                  }
                )
              )
            }
          )
        )
        instance_requirements = optional(
          object(
            {
              accelerator_count = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              accelerator_manufacturers = optional(set(string))
              accelerator_names         = optional(set(string))
              accelerator_total_memory_mib = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              accelerator_types      = optional(set(string))
              allowed_instance_types = optional(set(string))
              bare_metal             = optional(string, "excluded")
              baseline_ebs_bandwidth_mbps = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              burstable_performance   = optional(string, "excluded")
              cpu_manufacturers       = optional(set(string))
              excluded_instance_types = optional(set(string))
              instance_generations    = optional(set(string))
              local_storage           = optional(string, "included")
              local_storage_types     = optional(set(string), ["ssd"])
              memory_gib_per_vcpu = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              memory_mib = optional(
                object(
                  {
                    min = optional(string, 4)
                    max = optional(string)
                  }
                ), {}
              )
              network_bandwidth_gbps = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              network_interface_count = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              on_demand_max_price_percentage_over_lowest_price = optional(string, "20")
              require_hibernate_support                        = optional(bool, false)
              spot_max_price_percentage_over_lowest_price      = optional(string, "100")
              total_local_storage_gb = optional(
                object(
                  {
                    min = optional(string)
                    max = optional(string)
                  }
                )
              )
              vcpu_count = optional(
                object(
                  {
                    min = optional(string, 2)
                    max = optional(string)
                  }
                ), {}
              )
            }
          ) # , {} 
        )
        instance_type = optional(string)
        kernel_id     = optional(string)
        key_name      = optional(string)
        license_specification = optional(
          object(
            {
              license_configuration_arn = optional(string)
            }
          )
        )
        maintenance_options = optional(
          object(
            {
              auto_recovery = optional(string, "default")
            }
          ),
          {}
        )
        metadata_options = optional(
          object(
            {
              http_endpoint               = optional(string, "enabled")
              http_tokens                 = optional(string, "required")
              http_put_response_hop_limit = optional(string, "1")
              http_protocol_ipv6          = optional(string, "disabled")
              instance_metadata_tags      = optional(string, "enabled")
            }
          ),
          {}
        )
        monitoring = optional(
          object(
            {
              enabled = optional(bool, true)
            }
          ),
          {}
        )
        name        = optional(string)
        name_prefix = optional(string)
        network_interfaces = optional(
          object(
            {
              associate_carrier_ip_address = optional(bool)
              associate_public_ip_address  = optional(bool, false)
              delete_on_termination        = optional(bool, true)
              description                  = optional(string)
              device_index                 = optional(string, 0)
              interface_type               = optional(string)
              ipv4_prefix_count            = optional(string)
              ipv4_prefixes                = optional(set(string))
              ipv6_addresses               = optional(set(string))
              ipv6_address_count           = optional(string)
              ipv6_prefix_count            = optional(string)
              ipv6_prefixes                = optional(set(string))
              network_interface_id         = optional(string)
              network_card_index           = optional(string, 0)
              private_ip_address           = optional(string)
              ipv4_address_count           = optional(string)
              ipv4_addresses               = optional(set(string))
              security_groups              = optional(set(string))
              subnet_id                    = optional(string)
            }
          )
        )
        placement = optional(
          object(
            {
              affinity                = optional(string)
              availability_zone       = optional(string)
              group_name              = optional(string)
              host_id                 = optional(string)
              host_resource_group_arn = optional(string)
              spread_domain           = optional(string)
              tenancy                 = optional(string, "default")
              partition_number        = optional(string)
            }
          ), {}
        )
        private_dns_name_options = optional(
          object(
            {
              enable_resource_name_dns_aaaa_record = optional(bool, false)
              enable_resource_name_dns_a_record    = optional(bool, true)
              hostname_type                        = optional(string, "ip-name")
            }
          ), {}
        )
        ram_disk_id          = optional(string)
        security_group_names = optional(set(string))
        tag_specifications = optional(
          set(
            object(
              {
                resource_type = optional(string, "instance")
                tags          = optional(map(string))
              }
            )
          )
        )
        tags                   = optional(map(string))
        update_default_version = optional(string)
        user_data              = optional(any)
        vpc_security_group_ids = optional(set(string))
      }
    )
  )
}