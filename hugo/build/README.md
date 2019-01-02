# Hugo Build GitHub Action

This GitHub Action builds your [Hugo website](https://gohugo.io).

## Usage

It automatically detects the latest released version of Hugo and installs this before running. Any additional flags you require can be provided as CMD values in your actions file.

As the Action uses the GitHub API to determine the latest version of Hugo, you need to provide the GITHUB_TOKEN secret to ensure you don't get API call errors. If you want to provide any additional arguments to your Hugo build, you can do so using args.

```hcl
workflow "Build Hugo Site" {
  on = "push"
  resolves = ["Build"]
}

action "Build" {
  uses = "ArjenSchwarz/actions/hugo/build@master"
  args = "--theme=mytheme"
  secrets = ["GITHUB_TOKEN"]
}
```