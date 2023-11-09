provider "google" {
  project = "manojproject1-396309"
  region = "us-east1"
}

terraform {
  backend "gcs" {
    bucket = "terraform_state_m1"   
    prefix = "terraform_state_m1"
  }
}
 
#This bucket will contain the file, which will be picked by cloud function
resource "google_storage_bucket" "source_bucket_4_cf1" {
  name = "trigger_file_bucket1"
  location = "us-east1"
}

#This bucket will be delete, we are using it for testing purpose
resource "google_storage_bucket" "source_bucket_4_cf2" {
  name = "trigger_file_bucket10"
  location = "us-east1"
  #force_destroy = true
}

#This bucket will contain the code file which will be used as cloud function code
resource "google_storage_bucket" "tf_storage_bucket" {
  name = "cf_code_bucket1"
  location = "us-east1"
}

resource "google_storage_bucket_object" "tf_bucket_object" {
  name = "main.zip"
  bucket = google_storage_bucket.tf_storage_bucket.name
  source = "../code/main.zip"
}

resource "google_cloudfunctions_function" "tf_cloud_funct" {
    name = "my_funct_1"
    runtime = "python310"
    source_archive_bucket = google_storage_bucket.tf_storage_bucket.name
    source_archive_object = google_storage_bucket_object.tf_bucket_object.name
    
    trigger_http = true
    timeout = 60
    entry_point = "hello_world"

    /* depends_on = [ google_storage_bucket_object.tf_bucket_object ] */
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  cloud_function = google_cloudfunctions_function.tf_cloud_funct.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

#comment