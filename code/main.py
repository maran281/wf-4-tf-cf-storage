import os
from google.cloud import storage

def hello_world(request):

    bucket_name = "source_bucket_for_cf_1"
    file_name = "test.json"

    storage_client = storage.Client()

    source_bucket = storage_client.get_bucket(bucket_name)
    source_blob = source_bucket.blob(file_name)

    json_data = source_blob.download_as_text()

    # Copy the source blob to the destination with a new name
    destination_bucket = storage_client.get_bucket(bucket_name)
    destination_blob = source_bucket.copy_blob(source_blob, destination_bucket, "new_test.json")

    # Delete the original source blob (optional)
    source_blob.delete()

    return json_data