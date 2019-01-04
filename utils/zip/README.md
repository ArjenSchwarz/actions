# GitHub Release action

GitHub action that lets you zip things.

Yes really, that's all it's for. I needed one that had zip installed.

## Usage

You provide a source directory from which all files need to be uploaded to your release, by default this is `output`.

```hcl
workflow "Zip stuff" {
  on = "push"
  resolves = ["Zip"]
}

action "Zip" {
  uses = "ArjenSchwarz/actions/utils/zip@master"
  args = "-j dist/awstools_windows_386.zip pkg/windows_386/awstools.exe"
}
```

Arguments you provide will be parsed as options for zip.
