resource "google_compute_firewall" "gke_demo_1_8f9f08cb_all" {
  allow {
    protocol = "ah"
  }

  allow {
    protocol = "esp"
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "sctp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  direction     = "INGRESS"
  name          = "gke-demo-1-8f9f08cb-all"
  network       = "https://www.googleapis.com/compute/v1/projects/healthy-saga-393600/global/networks/default"
  priority      = 1000
  project       = "healthy-saga-393600"
  source_ranges = ["10.125.128.0/17"]
  target_tags   = ["gke-demo-1-8f9f08cb-node"]
}
# terraform import google_compute_firewall.gke_demo_1_8f9f08cb_all projects/healthy-saga-393600/global/firewalls/gke-demo-1-8f9f08cb-all
