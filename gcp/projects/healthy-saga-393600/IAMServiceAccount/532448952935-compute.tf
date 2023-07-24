resource "google_service_account" "532448952935_compute" {
  account_id   = "532448952935-compute"
  display_name = "Compute Engine default service account"
  project      = "healthy-saga-393600"
}
# terraform import google_service_account.532448952935_compute projects/healthy-saga-393600/serviceAccounts/532448952935-compute@healthy-saga-393600.iam.gserviceaccount.com
