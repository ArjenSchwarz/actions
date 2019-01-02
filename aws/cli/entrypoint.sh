#!/bin/sh

set -e

if [ -n "$ONLY_IN_BRANCH" ] && [ "$GITHUB_REF" != "refs/heads/${ONLY_IN_BRANCH}" ]; then
	echo "$GITHUB_REF was not ${ONLY_IN_BRANCH}, exiting..."
	exit 0
fi

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

# Capture output
output=$( sh -c "aws $*" )

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
echo "$output"
