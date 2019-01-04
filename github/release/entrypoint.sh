#!/bin/bash
set -e

if [ -n "$ONLY_IN_BRANCH" ] && [ "$GITHUB_REF" != "refs/heads/${ONLY_IN_BRANCH}" ]; then
	echo "$GITHUB_REF was not ${ONLY_IN_BRANCH}, exiting..."
	exit 0
fi

if [ -z "$GITHUB_TOKEN" ]; then
	echo "As this action uses the GitHub API to find the latest version of Hugo, please add GITHUB_TOKEN to the secrets of your Workflow"
	exit 1
fi

[ -n "$SOURCE_PATH" ] || export SOURCE_PATH="output"
[ -n "$VERSION" ] || export VERSION="pre-release"

LATEST_GHR=$(curl -H "Authorization: token ${GITHUB_TOKEN}" -s https://api.github.com/repos/tcnksm/ghr/releases/latest | jq -r '.assets | map(select(.browser_download_url | contains ("linux_amd64")))[0].browser_download_url')
output="Downloading latest version of ghr: ${LATEST_GHR}"
curl -Ls "$LATEST_GHR" -o /tmp/ghr_latest.tar.gz
mkdir -p /tmp/latest && tar xzf /tmp/ghr_latest.tar.gz --directory /tmp/latest
mv /tmp/latest/*/ghr /bin/ghr

output="$output\nghr version output: $(ghr version)"

# Split GITHUB_REPOSITORY into user and repo
IFS='/' read -r -a REPO_ARRAY <<< "${GITHUB_REPOSITORY}"

output="$output\nBuilding with command: ghr -t ${GITHUB_TOKEN} -u ${REPO_ARRAY[0]} -r ${REPO_ARRAY[1]} --debug $* ${VERSION} ${SOURCE_PATH}"
output="$output\n$(ghr -t "${GITHUB_TOKEN}" -u "${REPO_ARRAY[0]}" -r "${REPO_ARRAY[1]}" --debug "$*" "${VERSION}" "${SOURCE_PATH}")"
# Capture output

# Write output to STDOUT
echo -e "$output"
