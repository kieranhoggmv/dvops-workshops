# Workshop 8: Zero Downtime Deployments

## Scenario

As a DevOps engineer at PF Metrics, a financial technology company processing thousands of active transactions a minute, you are directly responsible for the reliability of the core application's CI/CD pipeline.  
The development team has just handed over a critical Python update that introduces a highly anticipated reporting feature.

However, the team is nervous. During the last major release, the automated deployment script included a destructive database command that locked the live transactions table.  
This resulted in a 15-minute outage, causing widespread customer frustration and failed payments.  
In response, the business has mandated that all future deployments must guarantee absolute zero downtime for database changes.

Your objective is to fix the broken migration script and demonstrate that zero downtime can be achieved with correctly implemented scripting.  
Furthermore, you will be forcing the pipeline to only execute on correctly tagged version change events (i.e. a new release of `v1.1.0`).

## Task 1: Review the deployment files

This is a slightly more complex application to challenge you at the end of this module, so it's key that you are able to understand the various files:

* `.github/workflows/ci.yml`: The GitHub Actions pipeline file.
* `app.py`: A basic Python app with a /health path to validate database status.
* `compose.yml`: A Docker Compose configuration. This will handle the release component of the pipeline by building the application Docker file, and running both that and the database.
* `db-init.sh`: This script initialises a basic database table to work against.
* `db-migrate.sh`: This script handles DB changes during migration.
* `event.json`: This contains a mocked version reference for act to use as a trigger.
* `monitor.sh`: This script is a status monitor for the running application.

_Note: The only files you will need to modify during this task are `ci.yml`, `db-migrate.sh` and `event.json`, the rest are already fully complete._

## Task 2: Run the `monitor.sh` script

Before making any changes, open a terminal window and run `./monitor.sh`.  

This will run continually until you manually cancel the script, and we'll be using it verify our deployment and zero-downtime capability.  

**Leave this script running throughout your work.**

## Task 3: Correct the workflow

One of the requirements is that the pipeline should trigger only on newly pushed tags.  

Therefore you need to modify the trigger event in ci.yml to detect tag changes:

```yaml
on:
  push:
    tags: ["v*.*.*"]
```

## Task 4: Start the initial application stack

In this task, we are triggering act with a simulated event, as defined in `event.json`.  
Right now this has the initial application tag set to `v1.0.0`.  

Run `act -e event.json -j init` to run just the init job in the pipeline.  
This should complete successfully, building and deploying `v1.0.0` of the application, as well as initialising the database via `db-init.sh`.  

Review the pipeline output. You should see that after the `db-init.sh` script ran, it output the state of the created table via the `SELECT` statement therein.  

Also review the output of your `monitor.sh` script.  
This should now be reporting as **healthy**, with `v1.0.0` clearly visible.  

_Note: This step is unusual for regular pipelines but we're making use of it here to simplify initial application launch._

## Task 5: Correct the migration script

The current `db-migrate.sh` script is destructive and needs to be changed.  
If you look again at `app.py`, you can note that to be "healthy", it performs a `SELECT` against the `status` column of the `transactions` table.  

However, this current migration script will remove that and therefore cause the healthcheck to fail!  
What we need to do is simulate a non-destructive additional change.  

To do this, change the `ALTER TABLE` command to:  
`ALTER TABLE transactions ADD COLUMN IF NOT EXISTS new_feature_data VARCHAR(255);`  

This command will now **add** a column rather than remove an existing.  
Furthermore, it importantly uses `IF NOT EXISTS`. This addition allows the command to rerun multiple times without fail, as it will simply skip if the column has already been created.

## Task 6: Trigger the migration to `v1.1.0`

Time to release this new change!  

Ensure you can still see the output of you `monitor.sh` script, as you will need to keep an eye on this to determine the zero-downtime capability.  

Amend the version in `event.json` to `v1.1.0` and trigger the pipeline with:  
`act -e event.json -j migrate`  

This will do the following:
1. It will build the new version of the app container.
1. It will automatically redeploy the app. As this occurs, you should see a brief drop in your monitor.sh output as the app itself is unavailable, before returning and display `v1.1.0` in it's healthy output.
1. It will run `db-migrate.sh`. As this runs, you should see no impact on the application health via the monitor.sh output, meeting the zero-downtime requirement.
This will also perform a `SELECT` against the table to demonstrate in the pipeline output that the change is in place.

## Task 7: Make an additional DB change

This time we'll perform an additional `ALTER TABLE` via `db-migrate.sh`.  
To do so, copy the existing `psql` statement to directly below, and simply change the column name to `new_feature_data_2`.  

As we want to prove zero-downtime, this time you will **not** change `event.json` to avoid the re-release of the application and the brief downtime that causes.  
Instead, just re-run `act -e event.json -j migrate` and observe the output of the pipeline and `monitor.sh`.  

Via the pipeline output, the `SELECT` post-migration should clearly show **both** the old and new columns.  
It will also show the the first `ALTER` command is skipped as the column already exists.  

Via `monitor.sh`, you should continue to see `v1.1.0` in the output and a continuous **healthy** result.  

**Congratulations** - you've completed a fully zero-downtime database update!
