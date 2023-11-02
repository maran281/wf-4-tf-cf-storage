provider "google" {
  project = "manojproject1-396309"
  region = "us-east1"
}

resource "google_storage_bucket" "tf_storage_bucket" {
  name = "my_bucket_4_cf_poc"
  location = "us-east1"
}

resource "google_storage_bucket_object" "tf_bucket_object" {
  name = "index.zip"
  bucket = google_storage_bucket.tf_storage_bucket.name
  source = "myapp.zip"
}

resource "google_cloudfunctions_function" "tf_cloud_funct" {
    name = "hello_world"
    runtime = "Python"
    source_archive_bucket = google_storage_bucket.tf_storage_bucket.name
    source_archive_object = google_storage_bucket_object.tf_bucket_object.name
}

#comment