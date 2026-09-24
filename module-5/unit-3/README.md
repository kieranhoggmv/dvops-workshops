# Unit 3 lab: Debugging CI Pipelines
___

## Scenario

A developer on your team has attempted to migrate a manual testing process into a declarative GitHub Actions workflow. However, the pipeline is failing. If you push a new commit every time you attempt a fix, you will trigger dozens of failed remote builds, wasting cloud computing resources and polluting the project's version control history.  

To solve this efficiently, you will use `act` to test and fix the workflow. This gives you a rapid feedback loop to fix structural and logical errors before pushing the final, working configuration to the shared repository.  

The final deployment is a run of the `app.py` application, which runs on port `8080`.

===

## Task 1: Run the current workflow and review

First we must understand what doesn't work!  

1. Run `act push` to test a local run of the workflow. Note any errors you encounter.
1. Review the workflow file at `.github/workflows/ci.yml`.
1. Make a note of any observations or potential changes you identify.

===

## Task 2: Fix the workflow error(s)

Domain-Specific Languages are incredibly strict about formatting.  
A single misplaced space or missing character will prevent the entire pipeline from compiling.  

When running locally, you will encounter an error similar to:  
`Error: workflow is not valid. 'ci.yml': yaml: line 29`  
This tells you where, and in what file, the error can be found.

1. Re-run `act push` and note the error output.
1. Fix the DSL error.
1. Repeat the above steps until the workflow file compiles and runs.

**Note: The pipeline will FAIL to succeed. The aim here is to get it to run!**

===

## Task 3: Correct the order and apply fixes

Now the pipeline compiles, you will have encountered errors in the output.  
Hopefully when you reviewed the `ci.yml` file you spotted that the steps were in the incorrect order!

1. Open `.github/workflows/ci.yml` and correct the step order using best practices.
1. Run `act push` once you're happy with the order and observe the output.
1. Continue to amend the order if you feel it needs it, but also be aware a number of code fixes are also required!
1. For each, apply the fix and rerun `act push` until you get a successful build.

_Hint: There is a missing `pytest==9.1.1` requirement and broken tests._

===

## Task 4: Add a new `deploy` job

Congratulations! At this stage the existing pipeline is now fixed.  
All that remains is to add the final `deploy` job to run the application.

1. Open the `.github/workflows/ci.yml` file once again.
1. Add a new `deploy` job, meeting the following requirements:
  1. `build` must first complete successfully.
  1. Step 1 should terminate any running application.
  1. Step 2 should run the application.
  1. Step 3 should perform a healthcheck - after a 5s `sleep` - using `curl` on port `8080`.

**Step 1: Termination Script**
```
docker stop hello-doe || true
```

**Step 2: Execution Script**
```
docker run --rm --detach \
  --name hello-doe \
  --publish 8080:8080 \
  hello-doe:latest
```
