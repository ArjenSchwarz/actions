# Hugo Build GitHub Action

This GitHub Action builds your Hugo website.

It automatically detects the latest version of Hugo and installs this before running. Any additional flags you require can be provided as CMD values in your actions file.

## Usage

As the Action uses the GitHub API to determine the latest version of Hugo, you need to provide the GITHUB_TOKEN secret.

```hcl
workflow "Build Hugo Site" {
  on = "push"
  resolves = ["Build"]
}

action "Build" {
  uses = "ArjenSchwarz/action-hugo-build@master"
  args = "--theme=mytheme"
  secrets = ["GITHUB_TOKEN"]
}
```