# GitHub Pages action

GitHub action that deploys to GitHub pages.

This action is based on the one by [nchaulet](https://github.com/nchaulet/github-action-gh-pages).

## Usage

The directory to deploy defaults to `public`. This can be overridden with the PUBLIC_PATH environment variable. If you use a custom domain, you can add this so it automatically creates the CNAME file for you.

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
      DOMAIN="ig.nore.me"
  }
}
```

### Secrets

- `GITHUB_TOKEN` – **Required** This grants access to your repo so you can deploy.

### Environment variables

- `PUBLIC_PATH` - **Optional** The path you wish to deploy. Defaults to `public`.
- `DOMAIN` - **Optional** The URL of your custom domain name.
- `ONLY_IN_BRANCH` - **Optional** Only run the action in the branch you specify.
