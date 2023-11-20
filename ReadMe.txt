# wf-4-tf-cf-storage
Github action pipeline which uses terraform to deploy:
- Cloud storage buckets:
    -cf_code_bucket1: For storing the code for the cloud function.
    -terraform_state_m1: For storing the TF state file
    -trigger_file_bucket1: For storing the test files 'test.json' which will be consumed by cloud function
- Cloud function 'my_funct_1'
  Cloud function which picks the file named 'test.json', rename it to test_completed.json and prints a message 'Task Completed'