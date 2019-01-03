#!/bin/sh

if [ -n "$ONLY_IN_BRANCH" ] && [ "$GITHUB_REF" != "refs/heads/${ONLY_IN_BRANCH}" ]; then
	echo "$GITHUB_REF was not ${ONLY_IN_BRANCH}, exiting..."
	exit 0
fi

if [ -z "$SOURCE_PATH" ]; then
    SOURCE_PATH=public
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Please add GITHUB_TOKEN to the secrets of your Workflow."
    exit 1
fi

if [ -n "${DOMAIN}" ]; then
    echo "${DOMAIN}" > "${GITHUB_WORKSPACE}/${SOURCE_PATH}/CNAME"
fi

output=$(gh-pages -d $SOURCE_PATH -b gh-pages -u "github-actions-bot <support+actions@github.com>")
retval=$?

if [ $retval -ne 0 ]; then
    echo "gh-pages failed: $retval"
    echo "$output"
    exit 1
fi

echo "$output"