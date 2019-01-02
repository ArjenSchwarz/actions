# GitHub Actions for AWS

**This is a copy of the CLI action in the [actions/aws](https://github.com/actions/aws) repository by GitHub.**

The only difference is the addition of the `ONLY_IN_BRANCH` environment variable.

This Action for [AWS](https://aws.amazon.com/) enables arbitrary actions for interacting with AWS services via [the `aws` command-line client](https://docs.aws.amazon.com/cli/index.html).

## Usage

An example workflow for creating and publishing to Simple Notification Service ([SNS](https://aws.amazon.com/sns/)) topic follows.

The example illustrates a pattern for consuming a previous action's output using [`jq`](https://stedolan.github.io/jq/), made possible since each `aws` Action's output is captured by default as JSON in `$GITHUB_HOME/$GITHUB_ACTION.json`:

```hcl
workflow "Publish to SNS topic" {
  on = "push"
  resolves = ["Publish"]
}

action "Topic" {
  uses = "ArjenSchwarz/actions-aws/cli@master"
  args = "sns create-topic --name my-topic"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}

action "Publish" {
  needs = ["Topic"]
  uses = "ArjenSchwarz/actions-aws/cli@master"
  args = "sns publish --topic-arn `jq .TopicArn /github/home/Topic.json --raw-output` --subject \"[$GITHUB_REPOSITORY] Code was pushed to $GITHUB_REF\" --message file://$GITHUB_EVENT_PATH"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  env = {
    ONLY_IN_BRANCH = "master"
  }
}
```

### Secrets

- `AWS_ACCESS_KEY_ID` – **Required** The AWS access key part of your credentials ([more info](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys))
- `AWS_SECRET_ACCESS_KEY` – **Required** The AWS secret access key part of your credentials ([more info](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys))

### Environment variables

All environment variables listed in [the official documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-environment.html) are supported.

We provide defaults for the following, these may also be overridden:

- `AWS_DEFAULT_REGION`- **Optional** The AWS region name, defaults to `us-east-1` ([more info](https://docs.aws.amazon.com/general/latest/gr/rande.html))
- `AWS_DEFAULT_OUTPUT`- **Optional** The CLI's output output format, defaults to `json` ([more info](https://docs.aws.amazon.com/cli/latest/userguide/cli-environment.html))

In addition there is the following:

- `ONLY_IN_BRANCH`- **Optional** The name of the branch you want to limit this action running to. Especially useful when dealing with deployment actions such as CloudFormation deploy actions

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
