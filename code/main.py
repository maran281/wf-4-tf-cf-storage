import functions_framework
from google.cloud import storage

@functions_framework.http

def hello_world(request):
    # Initialize a Cloud Storage client
    storage_client = storage.Client()

    # Get a reference to the source blob (file) you want to rename
    source_bucket = storage_client.get_bucket('source_file_bucket_m1')
    source_blob = source_bucket.blob('test.json')

    # Copy the source blob to the destination with a new name
    destination_bucket = storage_client.get_bucket(source_bucket)
    destination_blob = source_bucket.copy_blob(source_blob, destination_bucket, 'test_completed.json')

    # Delete the original source blob (optional)
    source_blob.delete()

    print(f"File has been renamed .")

    #test
    return 'Task completed'