# GitHub Actions

All of my GitHub Actions. To make it easier to find them all, I decided to keep them all together.

As with all GitHub Actions, feel free to mix and match. The below example is what I use to build and deploy my website using actions from this repository.

```hcl
workflow "Build and Deploy Hugo Site" {
  on = "push"
  resolves = ["Sync To S3"]
}

action "Build" {
  uses = "ArjenSchwarz/actions/hugo/build@master"
  secrets = ["GITHUB_TOKEN"]
}

action "Sync To S3" {
  needs = ["Build"]
  uses = "ArjenSchwarz/actions/aws/s3sync@master"
  args = "--cf-invalidate --default-mime-type=application/json"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  env = {
    S3_BUCKET_URL = "s3://ignoreme-site"
    SOURCE_DIR = "public"
    ONLY_IN_BRANCH = "master"
  }
}
```
