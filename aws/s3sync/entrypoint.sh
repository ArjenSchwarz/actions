#!/bin/sh

set -e

if [ -n "$ONLY_IN_BRANCH" ] && [ "$GITHUB_REF" != "refs/heads/${ONLY_IN_BRANCH}" ]; then
	echo "$GITHUB_REF was not ${ONLY_IN_BRANCH}, exiting..."
	exit 0
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo 'Please set your AWS_ACCESS_KEY_ID'
    exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo 'Please set your AWS_SECRET_ACCESS_KEY'
    exit 1
fi

if [ -z "$S3_BUCKET_URL" ]; then
    echo 'Please set your S3_BUCKET_URL'
    exit 1
fi

s3cnf="$HOME/.s3cfg"

echo '[default]' > "$s3cnf"
echo "access_key=$AWS_ACCESS_KEY_ID" >> "$s3cnf"
echo "secret_key=$AWS_SECRET_ACCESS_KEY" >> "$s3cnf"

full_path="$GITHUB_WORKSPACE/$SOURCE_DIR"
if cd "$full_path";
then
    output="Changed to directory $full_path, content is: $(ls -l)"
else
    echo "Unable to change to directory $full_path, please verify this is correct"
    exit 1
fi

# Capture output
output="$output\nRunning: s3cmd sync --verbose $* ./ $S3_BUCKET_URL"

output="$output\n$( sh -c "s3cmd sync --verbose $* ./ $S3_BUCKET_URL" )"

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.log"

# Write output to STDOUT
echo "$output"
