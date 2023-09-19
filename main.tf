resource "aws_launch_template" "lt" {
  for_each = var.launch_template_config
  
  name     = format("lt-%s", each.key)
  

  dynamic "block_device_mappings" {
    #for_each = each.value["block_device_mappings"] == null ? toset([]) : toset([each.value["block_device_mappings"]])
    for_each = each.value["block_device_mappings"] == null ? [] : each.value["block_device_mappings"]

    content {
      device_name = block_device_mappings.value["device_name"] 
      dynamic "ebs" {
        for_each = block_device_mappings.value["ebs"] == null ? toset([]) : toset([block_device_mappings.value["ebs"]])
        content {
          delete_on_termination = ebs.value["delete_on_termination"]
          encrypted             = ebs.value["encrypted"]
          iops                  = ebs.value["iops"]
          kms_key_id            = ebs.value["kms_key_id"]
          snapshot_id           = ebs.value["snapshot_id"]
          throughput            = ebs.value["throughput"]
          volume_size           = ebs.value["volume_size"]
          volume_type           = ebs.value["volume_type"]
        }
      } 
      no_device    = block_device_mappings.value["no_device"]
      virtual_name = block_device_mappings.value["virtual_name"]
    }
  }
          
  dynamic "capacity_reservation_specification" {
    for_each = each.value["capacity_reservation_specification"] == null ? toset([]) : toset([each.value["capacity_reservation_specification"]])
    content {
      capacity_reservation_preference = capacity_reservation_specification.value["capacity_reservation_preference"]
      dynamic "capacity_reservation_target" {
        for_each = coalesce(capacity_reservation_specification.value["capacity_reservation_target"], {})
        content {
          capacity_reservation_id                 = capacity_reservation_target.value["capacity_reservation_id"]
          capacity_reservation_resource_group_arn = capacity_reservation_target.value["capacity_reservation_resource_group_arn"]
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = each.value["cpu_options"] == null ? toset([]) : toset([each.value["cpu_options"]])
    content {
      #amd_sev_snp      = cpu_options.value["amd_sev_snp"]
      core_count       = cpu_options.value["core_count"]
      threads_per_core = cpu_options.value["threads_per_core"]
    }
  }

  dynamic "credit_specification" {
    for_each = each.value["credit_specification"] == null ? toset([]) : toset([each.value["credit_specification"]])
    content {
      cpu_credits = credit_specification.value["cpu_credits"]
    }
  }

  default_version          = each.value["default_version"]
  description              = each.value["description"]
  disable_api_stop         = each.value["disable_api_stop_compatible"] ? each.value["disable_api_stop"] : null
  disable_api_termination  = each.value["disable_api_termination_compatible"] ? each.value["disable_api_termination"] : null
  ebs_optimized            = each.value["ebs_optimized"]

  dynamic "elastic_gpu_specifications" {
    for_each = can(each.value["elastic_gpu_specifications"]) ? toset([]) : toset([each.value["elastic_gpu_specifications"]])
    content {
      type = elastic_gpu_specifications.value["type"]
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = each.value["elastic_inference_accelerator"] == null ? toset([]) : toset([each.value["elastic_inference_accelerator"]])
    content {
      type = elastic_inference_accelerator.value["type"]
    }
  }

  dynamic "enclave_options" {
    for_each = each.value["enclave_options"] == null ? toset([]) : toset([each.value["enclave_options"]])
    content {
      enabled = enclave_options.value["enabled"]
    }
  }
  
  dynamic "hibernation_options" {
    for_each = each.value["hibernation_options"] == null ? toset([]) : toset([each.value["hibernation_options"]])
    content {
      configured = hibernation_options.value["configured"]
    }
  }

  dynamic "iam_instance_profile" {
    for_each = each.value["iam_instance_profile"] == null ? toset([]) : toset([each.value["iam_instance_profile"]])
    content {
      arn    = iam_instance_profile.value["arn"]
      name   = iam_instance_profile.value["name"]
    }
  }

  image_id = try(
    coalesce(
      data.aws_ami.ami[each.key].id,
      each.value["ami"]["image_id"]
    ),
    null
  )

  instance_initiated_shutdown_behavior = each.value["instance_initiated_shutdown_behavior_compatible"] == true ? each.value["instance_initiated_shutdown_behavior"] : null

  dynamic "instance_market_options" {
    for_each = each.value["instance_market_options"] == null ? toset([]) : toset([each.value["instance_market_options"]])
    content {
      market_type  = instance_market_options.value["market_type"]
      dynamic "spot_options" {
        for_each = instance_market_options.value["spot_options"] == null ? toset([]) : toset([instance_market_options.value["spot_options"]])
        content {  
          block_duration_minutes         = spot_options.value["block_duration_minutes"]
          instance_interruption_behavior = spot_options.value["instance_interruption_behavior"]
          max_price                      = spot_options.value["max_price"]
          spot_instance_type             = spot_options.value["spot_instance_type"]
          valid_until                    = spot_options.value["valid_until"]
        }
      }
    }
  }

  dynamic "instance_requirements" {
    for_each = each.value["instance_requirements"] == null ? toset([]) : toset([each.value["instance_requirements"]])
    content {
        dynamic "accelerator_count" {
          for_each = instance_requirements.value["accelerator_count"] == null ? toset([]) : toset([instance_requirements.value["accelerator_count"]])
           content {
             min = accelerator_count.value["min"]
             max = accelerator_count.value["max"]
           }
        }
        accelerator_manufacturers = instance_requirements.value["accelerator_manufacturers"]
        accelerator_names         = instance_requirements.value["accelerator_names"]
        dynamic "accelerator_total_memory_mib" {
          for_each = instance_requirements.value["accelerator_total_memory_mib"] == null ? toset([]) : toset([instance_requirements.value["accelerator_total_memory_mib"]])
           content {
             min = accelerator_total_memory_mib.value["min"]
             max = accelerator_total_memory_mib.value["max"]
           }
        }
        accelerator_types      = instance_requirements.value["accelerator_types"]
        allowed_instance_types = instance_requirements.value["allowed_instance_types"]
        bare_metal             = instance_requirements.value["bare_metal"]
        dynamic "baseline_ebs_bandwidth_mbps" {
          for_each = instance_requirements.value["baseline_ebs_bandwidth_mbps"] == null ? toset([]) : toset([instance_requirements.value["baseline_ebs_bandwidth_mbps"]])
           content {
             min = baseline_ebs_bandwidth_mbps.value["min"]
             max = baseline_ebs_bandwidth_mbps.value["max"]
           }
        }
        burstable_performance   = instance_requirements.value["burstable_performance"]
        cpu_manufacturers       = instance_requirements.value["cpu_manufacturers"]
        excluded_instance_types = instance_requirements.value["excluded_instance_types"]
        instance_generations    = instance_requirements.value["instance_generations"]
        local_storage           = instance_requirements.value["local_storage"]
        local_storage_types     = instance_requirements.value["local_storage_types"]
        dynamic "memory_gib_per_vcpu" {
          for_each = instance_requirements.value["memory_gib_per_vcpu"] == null ? toset([]) : toset([instance_requirements.value["memory_gib_per_vcpu"]])
           content {
             min = memory_gib_per_vcpu.value["min"]
             max = memory_gib_per_vcpu.value["max"]
           }
        }
        dynamic "memory_mib" {
          for_each = instance_requirements.value["memory_mib"] == null ? toset([]) : toset([instance_requirements.value["memory_mib"]])
           content {
             min = memory_mib.value["min"]
             max = memory_mib.value["max"]
           }
        }
        dynamic "network_bandwidth_gbps" {
          for_each = instance_requirements.value["network_bandwidth_gbps"] == null ? toset([]) : toset([instance_requirements.value["network_bandwidth_gbps"]])
           content {
             min = network_interface_count.value["min"]
             max = network_interface_count.value["max"]
           }
        }
        dynamic "network_interface_count" {
          for_each = instance_requirements.value["network_interface_count"] == null ? toset([]) : toset([instance_requirements.value["network_interface_count"]])
           content {
             min = network_interface_count.value["min"]
             max = network_interface_count.value["max"]
           }
        }
        on_demand_max_price_percentage_over_lowest_price = instance_requirements.value["on_demand_max_price_percentage_over_lowest_price"]
        require_hibernate_support                        = instance_requirements.value["require_hibernate_support"]
        spot_max_price_percentage_over_lowest_price      = instance_requirements.value["spot_max_price_percentage_over_lowest_price"]
        dynamic "total_local_storage_gb" {
          for_each = instance_requirements.value["total_local_storage_gb"] == null ? toset([]) : toset([instance_requirements.value["total_local_storage_gb"]])
          content {
            min = total_local_storage_gb.value["min"]
            max = total_local_storage_gb.value["max"]
          }
        }
        dynamic "vcpu_count" {
          for_each = instance_requirements.value["vcpu_count"] == null ? toset([]) : toset([instance_requirements.value["vcpu_count"]])
           content {
             min = vcpu_count.value["min"]
             max = vcpu_count.value["max"]
           }
        }
    }
  }

  instance_type                        = each.value["instance_type"]
  kernel_id                            = each.value["kernel_id"]
  key_name                             = each.value["key_name"]

  dynamic "license_specification" {
    for_each = each.value["license_specification"] == null ? toset([]) : toset([each.value["license_specification"]])
    content {
      license_configuration_arn = license_specification.value["license_configuration_arn"]
    }
  }

  dynamic "maintenance_options" {
    for_each = each.value["maintenance_options"] == null ? toset([]) : toset([each.value["maintenance_options"]])
    content {
      auto_recovery = maintenance_options.value["auto_recovery"]
    }
  }

  dynamic "metadata_options" {
    for_each = each.value["metadata_options"] == null ? toset([]) : toset([each.value["metadata_options"]])
    content {
      http_endpoint               = metadata_options.value["http_endpoint"]
      http_tokens                 = metadata_options.value["http_tokens"]
      http_put_response_hop_limit = metadata_options.value["http_put_response_hop_limit"]
      http_protocol_ipv6          = metadata_options.value["http_protocol_ipv6"]
      instance_metadata_tags      = metadata_options.value["instance_metadata_tags"]
    }
  }

  dynamic "monitoring" {
    for_each = each.value["monitoring"] == null ? toset([]) : toset([each.value["monitoring"]])
    content {
      enabled = monitoring.value["enabled"]
    }
  }

  dynamic "placement" {
    for_each = each.value["placement"] == null ? toset([]) : toset([each.value["placement"]])
    content {
      affinity                = placement.value["affinity"]
      availability_zone       = placement.value["availability_zone"]
      group_name              = placement.value["group_name"]
      host_id                 = placement.value["host_id"]
      host_resource_group_arn = placement.value["host_resource_group_arn"]
      spread_domain           = placement.value["spread_domain"]
      tenancy                 = placement.value["tenancy"]
      partition_number        = placement.value["partition_number"]
    }
  }
  
  dynamic "private_dns_name_options" {
    for_each = each.value["private_dns_name_options"] == null ? toset([]) : toset([each.value["private_dns_name_options"]])
    content {
      enable_resource_name_dns_aaaa_record = private_dns_name_options.value["enable_resource_name_dns_aaaa_record"]
      enable_resource_name_dns_a_record    = private_dns_name_options.value["enable_resource_name_dns_a_record"]
      hostname_type                        = private_dns_name_options.value["hostname_type"]
    }
  }

  ram_disk_id              = each.value["ram_disk_id"]
  security_group_names     = each.value["security_group_names"]

  dynamic "tag_specifications" {
    for_each = each.value["tag_specifications"] == null ? toset([]) : each.value["tag_specifications"]
    content {
      resource_type = tag_specifications.value["resource_type"]
      tags          = tag_specifications.value["tags"]
    }
  }

  tags                     = each.value["tags"]
  update_default_version   = each.value["update_default_version"]
  user_data                = each.value["user_data"]
  vpc_security_group_ids   = each.value["vpc_security_group_ids"]

}