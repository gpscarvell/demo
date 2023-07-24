resource "google_storage_bucket" "healthy_saga_393600" {
  force_destroy               = false
  location                    = "US"
  name                        = "healthy-saga-393600"
  project                     = "healthy-saga-393600"
  public_access_prevention    = "enforced"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.healthy_saga_393600 healthy-saga-393600
