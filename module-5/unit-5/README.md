
# Workshop 5: Deploying to AWS/Azure via CI/CD

___

Solution walkthrough: https://www.youtube.com/watch?v=cs7GK34ba4k

## Scenario

A local startup, CloudKart, is trying to automate the deployment of a required application file to AWS S3/Azure blob storage. However, their newly created GitHub Actions workflow is consistently failing, and the development team is blocked from releasing updates.  

They have asked you to debug the pipeline locally to avoid cluttering the repository history with failed commits, fix the workflow and ensure that the uploaded file is correct.

===

## Task 1: Review the workflow and deployment script

1. Locate the `.github/workflows/ci.yml` file and the associated `deploy.sh` shell script, and review them to understand the intended pipeline stages.
1. Attempt to run the current workflow as-is using `act push`.

Can you tell what's wrong with either file at this stage?

===

## Task 2: Fix the workflow

Systematically work through any syntax errors or run order issues until you have a successfully running pipeline.   
Do this iteratively, re-testing on each occasion with `act push`.  
Your aim is to get the workflow to compile and run, and the `deploy.sh` to execute without error.  

When working through the files, consider the following:

1. Ensure the DSL is valid and in the correct order.
1. Check the log output!

===

## Task 3: Add a `validate-checksum` step

In order to ensure the uploaded file is correct, you need to add the missing `validate-checksum` step to the workflow.  
After adding this, you will likely spot a failure...  

In order to progress, add the missing `CHECKSUM` environment variable to the workflow.  
Ensure that the pipeline succeeds with `act push`.

_Tip: Generate a SHA256 checksum for the upload file using `sha256sum [FILE]` and capture the hash output._

===

## Task 4: Modify the uploaded file

As would happen in a real deployment, make a change the the `unit5.txt` file which is being upload (simulating application changes).  

Re-run the pipeline with `act push` and you will see it fail.  

Correct the issue and ensure you have a successful run from `act push`.
