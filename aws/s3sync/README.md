# S3Sync GitHub Action

Syncs files to an AWS S3 bucket using the [S3 Tools](https://s3tools.org/s3cmd) sync command. This allows extra functionalitys

## Usage

You can provide any flags that [work with s3cmd sync](https://s3tools.org/usage) as args.

An example usage is as the below.

```hcl
workflow "Sync To S3" {
  on = "push"
  resolves = ["Sync"]
}

action "Sync" {
  uses = "ArjenSchwarz/actions/aws/s3sync@master"
  args = "--cf-invalidate --default-mime-type=application/json"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  env = {
      S3_BUCKET_URL = "s3://mybucket"
      SOURCE_DIR = "public"
      ONLY_IN_BRANCH = "master"
  }
}
```

### Secrets

- `AWS_ACCESS_KEY_ID` – **Required** The AWS access key part of your credentials ([more info](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys))
- `AWS_SECRET_ACCESS_KEY` – **Required** The AWS secret access key part of your credentials ([more info](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys))

### Environment variables

- `S3_BUCKET_URL` - **Required** The URL of your S3 bucket, in the form s3://YOUR_BUCKET_NAME. Technically you could store this as a secret, but the s3cmd output will display it anyway.
- `SOURCE_DIR` - **Optional** If SOURCE_DIR is not set, it will sync the root of your repo, otherwise it will use the subdirectory you specified.
- `ONLY_IN_BRANCH` - **Optional** Only run the action in the branch you specify
