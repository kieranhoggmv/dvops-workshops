<style>
.box {
  display: Inline-block;  
  text-align: center;
  padding: 15px;
  background-color: #23EB9A;
  border-radius: 10px;
  align-items: Center;
  display: flex;
  justify-content: center;
  }
</style>

<svg width="100%" height="auto" viewBox="0 0 130 40" xmlns="http://www.w3.org/2000/svg"> <path d="M32.782 25.79c0 2.38-1.281 3.83-3.189 3.83-1.96 0-3.245-1.45-3.245-3.83v-8.043h-2.96v7.99c0 4.075 2.256 6.73 6.098 6.73 3.814 0 6.231-2.708 6.231-6.73v-7.99h-2.935zM41.546 12.031h-2.897v20.232h2.897zM57.64 17.763h-2.896v14.5h2.897zM70.247 17.763l-4.055 10.65-4.082-10.65h-3.09l5.682 14.5h2.953l5.681-14.5zM103.757 23.665l-1.711-.394c-1.048-.253-1.572-.815-1.572-1.574 0-1.04.965-1.685 2.261-1.657.8 0 1.601.253 2.372.647a8.7 8.7 0 0 1 2.097 1.406v-3.038c-.496-.365-2.289-1.602-4.607-1.602-3.199 0-5.13 2.137-5.13 4.496 0 2.22 1.572 3.316 3.642 3.822l1.654.393c1.463.337 2.18.872 2.18 1.884s-.856 1.967-2.428 1.967c-.993 0-1.987-.337-2.786-.788-.966-.506-1.683-1.124-1.876-1.32l-.055 3.091c.192.196 1.848 1.573 4.799 1.573 3.283 0 5.325-2.303 5.325-4.664.001-2.051-1.407-3.624-4.165-4.242M80.205 17.594c-3.916 0-6.869 3.316-6.869 7.418s3.2 7.417 7.53 7.417c3.311 0 5.13-1.602 5.13-1.602v-2.95s-2.013 1.826-4.91 1.826c-2.62 0-4.33-1.49-4.771-3.569H86.77c.028-.365.056-.759.056-1.124 0-4.1-2.815-7.416-6.621-7.416m-3.918 6.295c.359-2.08 1.739-3.597 3.917-3.597 2.151 0 3.447 1.518 3.78 3.597zM55.153 12l-1.04 1.834 1.04 1.835h2.078l1.04-1.835L57.231 12zM17.607 17.763v.003l-.004-.003-5.714 9.587-.028-9.587H8.584v.003l-.004-.003-5.692 9.552-.018-.56.028-8.992H0v14.5h2.897c.177-.31.621-1.066 1.191-2.037l4.932-8.277v10.314h2.87q0-.003.002-.005l.006.005 6.115-10.262v10.262h2.869v-14.5zM121.182 27.594l-.661.603a6.8 6.8 0 0 1-1.814 1.211c-.601.265-1.339.4-2.193.4a4.4 4.4 0 0 1-2.155-.552 4.2 4.2 0 0 1-1.607-1.563 4.26 4.26 0 0 1-.595-1.94q.934.292 1.774.492c.902.214 1.841.322 2.789.322.913 0 1.793-.153 2.613-.455.861-.316 1.574-.789 2.118-1.406.592-.67.892-1.49.892-2.43 0-.893-.26-1.71-.775-2.43-.495-.695-1.183-1.241-2.044-1.623a6.7 6.7 0 0 0-2.727-.554c-1.177 0-2.322.302-3.405.898-1.091.6-1.999 1.493-2.697 2.651-.703 1.165-1.058 2.566-1.058 4.162 0 1.431.342 2.693 1.018 3.75a6.56 6.56 0 0 0 2.64 2.388 7.5 7.5 0 0 0 3.374.79c1.105 0 2.109-.205 2.983-.61.839-.39 1.658-.94 2.434-1.637l.588-.528zm-8.709-4.253c.176-.515.428-.976.75-1.374a4.8 4.8 0 0 1 1.659-1.338 4.4 4.4 0 0 1 1.913-.454c.958 0 1.731.217 2.3.644.504.378.739.843.739 1.46 0 .354-.088.81-.771 1.209-.663.384-1.452.58-2.343.58-1.286-.002-2.711-.245-4.247-.727M49.412 13.633h-2.868v4.102h-3.652v2.557h3.652v11.942h2.868V20.292h3.67v-2.557h-3.67zM88.626 17.735h-.17v14.5h2.896V20.272h4.932v-2.557h-7.658z" fill="currentColor"/> </svg>

# Workshop 5: Deploying to Azure via CI/CD

___

### Access and Credentials

| Item | Detail |
| :--- | :--- |
| User |+++@lab.VirtualMachine({VIRTUAL_MACHINE_NAME}).Username+++| 
| Password |+++@lab.VirtualMachine({VIRTUAL_MACHINE_NAME}).Password+++| 

___

## Scenario

A local startup, CloudKart, is trying to automate the deployment of a required application file to Azure Blob. However, their newly created GitHub Actions workflow is consistently failing, and the development team is blocked from releasing updates.  

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
