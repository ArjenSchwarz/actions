#!/usr/bin/env bats

function setup() {
  # Override PATH to mock out the aws cli
  export PATH="$BATS_TEST_DIRNAME/bin:$PATH"
  # Ensure GITHUB_WORKSPACE and other required values are set
  export GITHUB_WORKSPACE='.'
  export AWS_ACCESS_KEY_ID="key"
  export AWS_SECRET_ACCESS_KEY="secret"
  export S3_BUCKET_URL="s3://test"
  # Set HOME to tmpdir to store the .s3cfg file
  export HOME="$BATS_TMPDIR"
  export GITHUB_ACTION="github_action"
}

function teardown() {
  rm -f "${BATS_TMPDIR}/.s3cfg" "${BATS_TMPDIR}/${GITHUB_ACTION}.log"
}

@test "entrypoint runs successfully when required values are set" {
  run $GITHUB_WORKSPACE/entrypoint.sh
  [ "$status" -eq 0 ]
}

@test "entrypoint returns without doing anything when ONLY_IN_BRANCH is mismatched" {
    export ONLY_IN_BRANCH="master"
    export GITHUB_REF="refs/heads/fakebranch"
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 0 ]
    [ "$output" = "$GITHUB_REF was not ${ONLY_IN_BRANCH}, exiting..." ]
}

@test "entrypoint returns regular output when ONLY_IN_BRANCH is matched" {
    export ONLY_IN_BRANCH="master"
    export GITHUB_REF="refs/heads/master"
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 0 ]
    [ "$output" != "$GITHUB_REF was not ${ONLY_IN_BRANCH}, exiting..." ]
}

@test "entrypoint creates .s3cfg correctly when required values are set" {
  run $GITHUB_WORKSPACE/entrypoint.sh
  [ "$status" -eq 0 ]
  [ -f "$HOME/.s3cfg" ]
  cfgfile=$(cat "$HOME/.s3cfg")
  cmpvalue="[default]
access_key=${AWS_ACCESS_KEY_ID}
secret_key=${AWS_SECRET_ACCESS_KEY}"
  [ "$cmpvalue" == "$cfgfile" ]
}

@test "entrypoint fails when required value AWS_ACCESS_KEY_ID is not set" {
  unset AWS_ACCESS_KEY_ID
  run $GITHUB_WORKSPACE/entrypoint.sh
  [ "$status" -eq 1 ]
  [ ! -f "$HOME/.s3cfg" ]
}

@test "entrypoint fails when required value AWS_SECRET_ACCESS_KEY is not set" {
  unset AWS_SECRET_ACCESS_KEY
  run $GITHUB_WORKSPACE/entrypoint.sh
  [ "$status" -eq 1 ]
  [ ! -f "$HOME/.s3cfg" ]
}

@test "entrypoint fails when required value S3_BUCKET_URL is not set" {
  unset S3_BUCKET_URL
  run $GITHUB_WORKSPACE/entrypoint.sh
  [ "$status" -eq 1 ]
  [ ! -f "$HOME/.s3cfg" ]
}

@test "output is preserved" {
  run $GITHUB_WORKSPACE/entrypoint.sh
  actual=$( cat "${HOME}/${GITHUB_ACTION}.log" )
  [ -f "${HOME}/${GITHUB_ACTION}.log" ]
  [ "$output" == "$actual" ]
}