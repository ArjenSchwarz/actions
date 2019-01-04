# GitHub Release action

GitHub action that deploys files as a release.

This action uses [ghr](https://github.com/tcnksm/ghr).

## Usage

You provide a source directory from which all files need to be uploaded to your release, by default this is `output`.

```hcl
workflow "Deploy to GitHub Release" {
  on = "push"
  resolves = ["Deploy"]
}

action "Deploy" {
  uses = "ArjenSchwarz/actions/github/release@master"
  secrets = ["GITHUB_TOKEN"]
  args = "-delete"
  env = {
      ONLY_IN_BRANCH="master"
      SOURCE_PATH="dist"
      VERSION="latest"
  }
}
```

Arguments you provide will be parsed as options for ghr. Look at [the documentation](https://github.com/tcnksm/ghr#options) for their meaning.

### Secrets

- `GITHUB_TOKEN` – **Required** This grants access to your repo so you can deploy.

### Environment variables

- `SOURCE_PATH` - **Optional** The path you wish to deploy. Defaults to `output`.
- `VERSION` - **Optional** The version you wish to deploy to. Defaults to `pre-release`.
- `ONLY_IN_BRANCH` - **Optional** Only run the action in the branch you specify.
