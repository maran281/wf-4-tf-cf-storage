This repository is created to deploy a github action pipeline which includes a terraform to deploy various resources:
- Deploys multiple cloud storage buckets:
    *terraform_state_m1: For storing the TF state file
    *trigger_file_bucket1: For storing the test files 'test.json' which will be consumed by cloud function
    *cf_code_bucket1: For storing the code for the cloud function.
- Cloud function 'my_funct_1'
  This cloud function picks the file named 'test.json', rename it to test_completed.json and prints a message 'Task Completed'

