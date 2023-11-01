provider "google" {
  project = "ManojProject1"
  region = "us-east1"
}

resource "google_storage_bucket" "tf_storage_bucket" {
  name = "my_bucket1"
  location = "use-east1"
}

resource "google_storage_bucket_object" "tf_bucket_object" {
  name = "index.zip"
  bucket = google_storage_bucket.tf_storage_bucket.name
  source = "mycode.zip"
}

resource "google_cloudfunctions_function" "tf_cloud_unct" {
    name = "my_first_cf"
    runtime = "Python"
    source_archive_bucket = google_storage_bucket.tf_storage_bucket.name
    source_archive_object = google_storage_bucket_object.tf_bucket_object.name
}