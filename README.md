# terraform-aws-deployment
Terrafrom files to streamline AWS deployment of Docker containers.

# Setup
Your project is expected to feature three repos:
- An application repo featuring all application code, docker-compose and dockerfiles
- A terraform code repository featuring all terraform files (this repo)
- A root project repository where the application repo and the terraform repo are git submodules

Inside the root project repository:
```
git init
git submodule add <url-to-application-code-repo> <application-code-directory>
git submodule add git@github.com:yannmazita/terraform-aws-deployment terraform
git add *
git commit -m "Added submodules"
git remote add origin <url-to-root-repo>
git branch -M main
git push -u origin main
```

# Cloning root project (with submodules)
```
git clone --recurse-submodules <url-to-root-repo>
```

If you already cloned the repository without submodules, you can fetch them later:
```
git submodule update --init --recursive
```

# Managing and updating submodules

## Pull the latest changes for submodules
```
git submodule update --remote
```

## Commit the updated submodules
```
git add .
git commit -m "Updated submodules"
git push
```

# Push Docker images to ECR

## Login to ECR
```
aws ecr get-login-password --region <AWS-REGION> | docker login --username AWS --password-stdin <YOUR_AWS_ACCOUNT_ID>.dkr.ecr.<AWS-REGION>.amazonaws.com
```

## Build and tag the Docker image for backend
```
docker build -t backend-repo ./<application-code-directory>/<backend-directory>
docker tag backend-repo:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS-REGION>.amazonaws.com/backend-repo:latest
```

## Push the Docker image to ECR
```
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS-REGION>.amazonaws.com/backend-repo:latest
```

## Repeat for frontend
```
docker build -t frontend-repo ./<application-code-directory>/<frontend-directory>
docker tag frontend-repo:latest <AWS_ACCOUNT_ID>.dkr.ecr.<AWS-REGION>.amazonaws.com/frontend-repo:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<AWS-REGION>.amazonaws.com/frontend-repo:latest
```
