import os
from google.cloud import storage
import functions_framework

@functions_framework.http

def hello_world(request):

    print("debug line 1")
    bucket_name = "source_bucket_for_cf_1"
    print("debug line 2")
    file_name = "test.json"
 
    print("debug line 3")
    
    storage_client = storage.Client()
    print("debug line 4")

    
    source_bucket = storage_client.get_bucket(bucket_name)
    print("debug line 5")
    
    source_blob = source_bucket.blob(file_name)
    print("debug line 6")

    
    json_data = source_blob.download_as_text()
    print("debug line 7")

    
    # Copy the source blob to the destination with a new name
    destination_bucket = storage_client.get_bucket(bucket_name)
    print("debug line 8")
    
    
    destination_blob = source_bucket.copy_blob(source_blob, destination_bucket, "new_test.json")
    print("debug line 9")

    
    # Delete the original source blob (optional)
    source_blob.delete()

    print("debug line 10")
    
    return json_data