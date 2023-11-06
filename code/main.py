import functions_framework
from google.cloud import storage

@functions_framework.http

def hello_world(request):
    # Initialize a Cloud Storage client
    storage_client = storage.Client()

    # Get a reference to the source blob (file) you want to rename
    source_bucket = storage_client.get_bucket('source_file_bucket_m')
    source_blob = source_bucket.blob('test.json')

    # Copy the source blob to the destination with a new name
    destination_bucket = storage_client.get_bucket(source_bucket)
    destination_blob = source_bucket.copy_blob(source_blob, destination_bucket, 'test_completed.json')

    # Delete the original source blob (optional)
    source_blob.delete()

    print(f"File '{test.json}' has been renamed to '{test_completed.json}' in bucket '{source_file_bucket_m}'.")


    return 'Task completed'