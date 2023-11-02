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
    name = "my_funct"
    runtime = "Python"
    source_archive_bucket = google_storage_bucket.tf_storage_bucket.name
    source_archive_object = google_storage_bucket_object.tf_bucket_object.name

    trigger_http = true
    timeout = 60
    entry_point = "hello_world"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  cloud_function = google_cloudfunctions_function.tf_cloud_funct.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

#comment