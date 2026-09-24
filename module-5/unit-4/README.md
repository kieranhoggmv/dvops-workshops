# Unit 4 lab: Collaboratively Fixing a CI/CD Deployment

## Scenario

Your engineering team is preparing to build a new deployment pipeline which requires a secret API token to be provided for their application.  
As a member of their DevOps engineering team, you are tasked with creating the initial continuous integration workflow.  
However, to avoid cluttering the remote repository's commit history with failed build attempts, you have decided to build and test the pipeline entirely on your local machine using `act`.

You will also work on this task collaboratively with another DevOps engineer to ensure it is done effectively.  
The aim is to ensure the baseline workflow functions correctly and handles secrets securely in a local environment, which will also ensure subsequent team programming sessions are significantly more efficient.


## Task 1: Review the initial workflow

1. Locate the `.github/workflows/ci.yml` file and the associated `deploy.sh` shell script, and review them to understand the intended pipeline stages.
1. Attempt to run the current workflow as-is using `act push`.

Can you tell what's wrong with either file at this stage?

## Task 2: Fix the workflow and deployment scripts

Work through both the workflow and deployment script, fixing errors as you go.  
Do this iteratively, re-testing on each occasion with `act push`.  
Your aim is to get the workflow to compile and run, and the `deploy.sh` to execute without error.  

**Reminder: even with a fully fixed workflow and deployment script, the ultimately result will be a fail due to the missing `API_TOKEN`!**

When working through the files, consider the following:

1. Ensure the DSL is valid (reminder: you'll be making use of a _secret_ value in this workflow).
1. Ensure the deployment script contains valid bash and all intended logic is correct.
1. Check the log output! There may be a runtime error that doesn't cause the pipeline to fail.

## Task 3: Add the `API_TOKEN` secret

`act` emulates GitHub Actions secrets by using a `.secrets` file.  
(Ref: https://nektosact.com/usage/#envsecrets-files-structure)

1. Create the `.secrets` file with the `API_TOKEN` value set to `mock_token_123`.
1. Run `act push` to verify all is working.

At this stage, the pipeline and deployment script should function correctly.  
If you find this to not be the case, revist Task 2 to fix any new issues you have discovered!
