resource "google_storage_bucket" "export_cium2ttvga3084udv930" {
  force_destroy            = false
  location                 = "US"
  name                     = "export-cium2ttvga3084udv930"
  project                  = "healthy-saga-393600"
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
}
# terraform import google_storage_bucket.export_cium2ttvga3084udv930 export-cium2ttvga3084udv930
