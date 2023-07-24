resource "google_container_cluster" "demo_1" {
  addons_config {
    dns_cache_config {
      enabled = true
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }

    gcp_filestore_csi_driver_config {
      enabled = true
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }

    network_policy_config {
      disabled = true
    }
  }

  binary_authorization {
    evaluation_mode = "DISABLED"
  }

  cluster_autoscaling {
    auto_provisioning_defaults {
      image_type      = "COS_CONTAINERD"
      oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
      service_account = "default"
    }

    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    enabled             = true

    resource_limits {
      maximum       = 1000000000
      resource_type = "cpu"
    }

    resource_limits {
      maximum       = 1000000000
      resource_type = "memory"
    }

    resource_limits {
      maximum       = 1000000000
      resource_type = "nvidia-tesla-t4"
    }

    resource_limits {
      maximum       = 1000000000
      resource_type = "nvidia-tesla-a100"
    }
  }

  cluster_ipv4_cidr = "10.125.128.0/17"

  cluster_telemetry {
    type = "ENABLED"
  }

  database_encryption {
    state = "DECRYPTED"
  }

  datapath_provider         = "ADVANCED_DATAPATH"
  default_max_pods_per_node = 110

  default_snat_status {
    disabled = false
  }

  enable_autopilot            = true
  enable_intranode_visibility = true
  enable_shielded_nodes       = true

  ip_allocation_policy {
    cluster_ipv4_cidr_block       = "10.125.128.0/17"
    cluster_secondary_range_name  = "gke-demo-1-pods-8f9f08cb"
    services_ipv4_cidr_block      = "10.126.0.0/22"
    services_secondary_range_name = "gke-demo-1-services-8f9f08cb"
  }

  location = "us-central1"

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]

    managed_prometheus {
      enabled = true
    }
  }

  name    = "demo-1"
  network = "projects/healthy-saga-393600/global/networks/default"

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  networking_mode = "VPC_NATIVE"

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-medium"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = true
    }

    workload_metadata_config {
      mode          = "GKE_METADATA"
      node_metadata = "GKE_METADATA_SERVER"
    }
  }

  node_locations = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]
  node_version   = "1.26.5-gke.1200"

  notification_config {
    pubsub {
      enabled = false
    }
  }

  pod_security_policy_config {
    enabled = false
  }

  private_cluster_config {
    enable_private_endpoint = false

    master_global_access_config {
      enabled = false
    }
  }

  project = "healthy-saga-393600"

  release_channel {
    channel = "REGULAR"
  }

  subnetwork = "projects/healthy-saga-393600/regions/us-central1/subnetworks/default"

  vertical_pod_autoscaling {
    enabled = true
  }

  workload_identity_config {
    workload_pool = "healthy-saga-393600.svc.id.goog"
  }
}
# terraform import google_container_cluster.demo_1 healthy-saga-393600/us-central1/demo-1
