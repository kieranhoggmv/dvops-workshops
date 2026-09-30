# Workshop 7: Deploying To Multiple Environments

## Scenario

EP Dynamics, a rapidly growing financial services provider, is experiencing severe deployment anxiety following a string of botched software releases.  
Their core Python transaction API consistently passes all automated quality gates in the staging environment but frequently crashes upon reaching live users.  

After investigating their current CI/CD setup, you discover two critical flaws in their continuous delivery pipeline:  

* **Artifact Rebuilding:** The pipeline is incorrectly configured to run a second Docker build command during the production deployment stage. In the window between the staging and production deployments, unpinned dependencies are being pulled into the live build, completely invalidating the staging tests (not present in the lab!).
* **Configuration Drift:** Developers have been hardcoding staging API URLs directly into the `deploy.sh` Bash scripts to speed up their local testing. This has caused terrifying near-misses where the production deployment attempted to route live customer transactions back to an insecure testing database.

The engineering director has tasked you with redesigning this workflow to enforce strict multi-environment consistency.  
You must decouple the configuration from the codebase, replacing the hardcoded strings with dynamic environment variables injected safely at runtime.  
Furthermore, you must restructure the pipeline to promote a single, immutable Docker artifact across both environments, adhering strictly to the "Build Once, Deploy Everywhere" principle.

## Task 1: Review the existing files

Review the existing deployment and application files:

* `.github/workflows/ci.yml`
* `app.py`
* `deploy.sh`

Can you spot any immediate issues?

_Note: app.py contains zero errors._


## Task 2: Test the pipeline

Run `act push` to see what the pipeline currently does.  
Take particular notice of concurrency issues and the end result of the two separate jobs.


## Task 3: Restructure the Pipeline

Time to fix the pipeline and adhere to multi-env best practices!  

1. Create a new, single build job that both jobs require. [Hint](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#example-requiring-successful-dependent-jobs)
2. Remove the build steps from the existing jobs.
3. Version the build artifact using the current git commit SHA variable: `${{ github.sha }}`. *Hint: replace the "latest" tag, with the variable*
4. Ensure to save the docker image after building it. *Hint: check in the snippets below* 
5. Publish the built artifact to be reused later  *Hint: check in the snippets below*
6. Restore the built artifact for use where applicable. *Hint: check in the snippets below.*
7. Test your pipeline with the following command until it performs as expected: `act --artifact-server-path $PWD/.artifacts push`

Final hint: if your pipeline ran: build -> staging & production at the same time, consider the **needs:** sections.

(If your deploy.sh run step fails don't worry, we'll fix that next!)  

Below are some snippets you will need to complete some of the above steps.  
(**Note:** There are newer versions of both the `upload-artifact` and `download-artifact` but do not change from the versions shown below as these are for compatibility with `nektos/act`.)

---

**To save a built docker image as a local file to archive, run:**  
`docker save -o u7-api-image.tar u7-api:[TAG]`

**To load a built docker image, run:**
`docker load -i u7-api-image.tar`

---

**To archive a file within GitHub Actions, use actions/upload-artifact@v4:**  
```yaml
uses: actions/upload-artifact@v4
with:
  name: u7-api-artifact
  path: u7-api-image.tar
  retention-days: 1
```

---

**To restore an archived file, use actions/download-artifact@v4:**  
```yaml
uses: actions/download-artifact@v4
with:
  name: u7-api-artifact
```


## Task 4: Fix the `deploy.sh` script

Now your pipeline is configured correctly for multiple environments and build re-use, you need to fix the deployment script.  

Consider the following:
* Move the hardcoded `API_URL` string to a variable and set it per job in the workflow instead. Staging should use http://staging-api.internal and production should use http://prod-api.internal.
* Use the GitHub SHA image version (`${GITHUB_SHA}`).
* Amend the workflow if required.
* It might be worth checking the API_URL is set. [Hint](https://gist.github.com/kieranhoggmv/ae47cea0c62de44d6787f11b1e1f4a11)


## Task 5: Validate the workflow

Re-run the pipeline with `act --artifact-server-path $PWD/.artifacts push`.  

It should now complete successfully, with correct URLs for both staging and production, as well as follow a proper multi-env build and deploy pattern!