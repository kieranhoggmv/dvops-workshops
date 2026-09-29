# Workshop 6: Troubleshooting Deployment Checkpoints

## Scenario

IO Dynamics is migrating their CI/CD pipelines to GitHub Actions. They have implemented a new automated deployment checkpoint to protect their staging environment. However, the workflow keeps failing at the smoke test stage, halting the release of a critical payment API. The deeper integration test suite also never even runs.  

As the lead DevOps engineer, you need to use `nektos/act` to locally debug the workflow, find out why the application is unreachable during the smoke test, and fix the configuration so the pipeline can safely progress to the integration tests.

## Task 1: Review the deployment files

Open and review the various application and deployment files for this task:

* `.github/workflows/ci.yml`
* `app.py`
* `deploy.sh`
* `test_api.py`

As you work through this task, make a note of the various errors you detect from observing the output.  

_Note: `app.py` contains zero errors._

## Task 2: Test the workflow

Run `act push` to run the workflow.  

Review the output logs and diagnose why the Smoke Test stage failed.

## Task 3: Fix the Smoke Test

Apply the fix(es) required in order to allow the Smoke Test step to pass.  
Verify this with `act push` until the step succeeds.  

_Note: Once the Smoke Test passes, the Integration step will fail here._

## Task 4: Fix the Integration Tests

Review the latest pipeline run output to determine why it failed.  
Apply the fix(es) required to allow the Integration Tests to succeed.  
Verify this with `act push` until the entire pipeline succeeds.
