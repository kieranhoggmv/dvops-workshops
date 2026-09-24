# Unit 2 lab: Creating a Zero Downtime Blue/Green Deployment

___

### Access and Credentials

| Item | Detail |
| :--- | :--- |
| User |+++@lab.VirtualMachine({VIRTUAL_MACHINE_NAME}).Username+++| 
| Password |+++@lab.VirtualMachine({VIRTUAL_MACHINE_NAME}).Password+++| 

___

## Scenario

You are a DevOps engineer for "RetailStream", a high-traffic online retailer. The development team has provided a new version of the inventory API, but recent manual releases have caused unacceptable downtime for customers, severely impacting sales. Management has requested a zero-downtime Blue/Green deployment strategy to mitigate this risk.  

Your task is to finalise a GitHub Actions workflow to automate the deployment, simulate a failure using a broken API update, and execute a rollback script to restore service without impacting the end user. Testing this delivery logic locally using act directly prepares you for your module project, where you will build robust, multi-environment deployment pipelines using immutable infrastructure principles.

===

## Task 1: Review the repository

Before building the automation, you must familiarise yourself with the tools at your disposal.

1. Open your local development terminal and navigate to the retailstream-api directory.
1. Review the application files. You will see a Python application file named `app.py` and a simulated load balancer in `set-live.sh` and `check-live.sh`.
1. Review the cleanup script: `cleanup.sh`.
1. Review the incomplete pipeline: `.github/workflows/deploy.yml`

Take a moment to read the Bash logic. Notice that complex deployments are often just well-orchestrated Bash commands.

===

## Task 2: Complete the workflow

Now that you understand the underlying Bash scripts, you need to configure the CI/CD orchestrator to run them.  
The pipeline definition is stored as code alongside the application, ensuring your delivery process is version-controlled and reproducible.

1. Open the workflow file with Vim: `vim .github/workflows/deploy.yml`.
1. Identify the sequence of execution.
1. Add the following scripts to configure the deployment and healthcheck:

**Deployment**
```
docker run --detach \
  --name retailstream-${{ env.BLUE_GREEN }} \
  --publish ${{ env.PORT }}:8080 \
  --env APP_VERSION="${{ env.APP_VERSION }}" \
  retailstream:${{ env.APP_VERSION }}
```
_This script uses Docker to run the application as specified by the environment variables in the workflow._

**Healthcheck**
```
sleep 5
curl --silent --fail localhost:${{ env.PORT }}
```
_This command polls the application endpoint on the configured port, to ensure it is running as expected._

===

## Task 3: Deploy the “Blue” application

With your pipeline configured, it is time to perform the initial deployment.  
Testing delivery logic locally is a powerful technique for DevOps engineers.  
It allows you to catch syntax errors and configuration bugs rapidly without consuming remote compute resources or waiting for a cloud provider to queue your job.

1. Run `act push` to trigger the deployment. This should now run successfully.
1. Once deployed, run `./set-live.sh blue` to set the newly deployed application live.
1. Verify this with `./check-live.sh`.

===

## Task 4: Intentionally break the application

A deployment pipeline is not complete unless it can safely handle failure.  
True zero-downtime deployments require infrastructure planning alongside robust pipeline configuration to ensure faulty code never reaches the end user.  
To verify our Blue/Green setup works, we are going to intentionally break the application and attempt to release it.

1. Open the `app.py` file.
1. Introduce a fatal Python syntax error by removing the trailing comma on line 13.

===

## Task 5: Deploy a “Green” application

Time to test a green deployment!

1. Run `act push --env PORT=8081 --env APP_VERSION=1.1.0 --env BLUE_GREEN=green` to trigger a Green deploy. Note this fails due to the application not running, following the bug you introduced.
1. Attempt to set Green live with `./set-live.sh green`. This will fail and notify you.

===

## Task 6: Cleanup the failed deployment

Your automated health check successfully protected the live environment from an outage.  
However, your infrastructure is now potentially left with a broken, idle "Green" container taking up resources.  
A deployment pipeline is not complete unless the team has a tested, automated mechanism for rolling back immediately when a post-deployment health check fails.

1. Run `./cleanup.sh green` to remove the broken deployment. Note this will only succeed in a stable blue version is found!

===

## Task 7: Fix and redeploy

Let's try Green again...

1. Revert your change to `app.py` to restore it's original state.
1. Re-run the Green deployment: `act push --env PORT=8081 --env APP_VERSION=1.1.0 --env BLUE_GREEN=green`. This time it should succeed!

===

## Task 8: Flip the load balancer

Now that we have both a stable Blue and Green deployment, it's time to flip to the new Green deployment and cleanup Blue.

1. Run `./check-live.sh` to ensure Blue is still active.
1. Run `./set-live.sh green` to set Green as active.
1. Run `./check-live.sh` which should now confirm that Green is live.
1. Run `./cleanup.sh blue` to remove the old Blue deployment.
