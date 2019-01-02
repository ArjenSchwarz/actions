#!/bin/sh
set -e

if [ -z "$GITHUB_TOKEN" ]; then
	echo "As this action uses the GitHub API to find the latest version of Hugo, please add GITHUB_TOKEN to the secrets of your Workflow"
	exit 1
fi

LATEST_HUGO=$(curl -H "Authorization: token ${GITHUB_TOKEN}" -s https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r '.assets | map(select(.browser_download_url | contains ("extended") and contains ("Linux-64") and contains (".tar.gz")))[0].browser_download_url')
output="Downloading latest version of Hugo: ${LATEST_HUGO}"
curl -Ls "$LATEST_HUGO" -o /tmp/hugo_latest.tar.gz
mkdir -p /tmp/latest && tar xzf /tmp/hugo_latest.tar.gz --directory /tmp/latest
mv /tmp/latest/hugo /bin/hugo

output="$output\nHugo version output:"
output="$output\n$(hugo version)"
# Capture output
output="$output\nBuilding with command: hugo --source ${GITHUB_WORKSPACE} $*"
output="$output\n$( sh -c "hugo --source ${GITHUB_WORKSPACE} $*" )"

# Write output to STDOUT
echo "$output"
