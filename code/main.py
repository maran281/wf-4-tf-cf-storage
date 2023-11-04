import os
from google.cloud import storage

def hello_world(request):
    bucket_name = "source_bucket_for_cf_1"
    file_name = "test.json"

    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)

    blob = bucket.blob(file_name)

    json_data = blob.download_as_text()

    return json_data