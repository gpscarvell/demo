resource "google_compute_firewall" "gke_demo_1_8f9f08cb_inkubelet" {
  allow {
    ports    = ["10255"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "gke-demo-1-8f9f08cb-inkubelet"
  network       = "https://www.googleapis.com/compute/v1/projects/healthy-saga-393600/global/networks/default"
  priority      = 999
  project       = "healthy-saga-393600"
  source_ranges = ["10.125.128.0/17"]
  source_tags   = ["gke-demo-1-8f9f08cb-node"]
  target_tags   = ["gke-demo-1-8f9f08cb-node"]
}
# terraform import google_compute_firewall.gke_demo_1_8f9f08cb_inkubelet projects/healthy-saga-393600/global/firewalls/gke-demo-1-8f9f08cb-inkubelet
