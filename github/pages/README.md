# GitHub Pages action

GitHub action that deploys to GitHub pages.

This action is based on the one by [nchaulet](https://github.com/nchaulet/github-action-gh-pages).

## Usage

The directory to deploy defaults to `public`. This can be overridden with the PUBLIC_PATH environment variable.

```hcl
workflow "Deploy to GitHub Pages" {
  on = "push"
  resolves = ["Deploy"]
}

action "Deploy" {
  uses = "ArjenSchwarz/actions/github/pages@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
      ONLY_IN_BRANCH="master"
  }
}
```

### Secrets

- `GITHUB_TOKEN` – **Required** This grants access to your repo so you can deploy.

### Environment variables

- `PUBLIC_PATH` - **Optional** The path you wish to deploy. Defaults to `public`.
- `ONLY_IN_BRANCH` - **Optional** Only run the action in the branch you specify.
