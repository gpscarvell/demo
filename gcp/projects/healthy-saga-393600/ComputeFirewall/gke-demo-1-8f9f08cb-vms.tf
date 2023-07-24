resource "google_compute_firewall" "gke_demo_1_8f9f08cb_vms" {
  allow {
    ports    = ["1-65535"]
    protocol = "tcp"
  }

  allow {
    ports    = ["1-65535"]
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  direction     = "INGRESS"
  name          = "gke-demo-1-8f9f08cb-vms"
  network       = "https://www.googleapis.com/compute/v1/projects/healthy-saga-393600/global/networks/default"
  priority      = 1000
  project       = "healthy-saga-393600"
  source_ranges = ["10.128.0.0/9"]
  target_tags   = ["gke-demo-1-8f9f08cb-node"]
}
# terraform import google_compute_firewall.gke_demo_1_8f9f08cb_vms projects/healthy-saga-393600/global/firewalls/gke-demo-1-8f9f08cb-vms
