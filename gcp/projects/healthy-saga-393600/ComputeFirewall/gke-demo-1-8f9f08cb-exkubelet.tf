resource "google_compute_firewall" "gke_demo_1_8f9f08cb_exkubelet" {
  deny {
    ports    = ["10255"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "gke-demo-1-8f9f08cb-exkubelet"
  network       = "https://www.googleapis.com/compute/v1/projects/healthy-saga-393600/global/networks/default"
  priority      = 1000
  project       = "healthy-saga-393600"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke-demo-1-8f9f08cb-node"]
}
# terraform import google_compute_firewall.gke_demo_1_8f9f08cb_exkubelet projects/healthy-saga-393600/global/firewalls/gke-demo-1-8f9f08cb-exkubelet
