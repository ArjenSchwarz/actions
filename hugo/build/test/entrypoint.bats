#!/usr/bin/env bats

function setup() {
    # Override PATH to mock out the aws cli
    export PATH="$BATS_TEST_DIRNAME/bin:$PATH"
    # Ensure GITHUB_WORKSPACE and other required values are set
    export GITHUB_WORKSPACE='.'
    export GITHUB_TOKEN="key"
}

@test "entrypoint runs successfully when required values are set" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 0 ]
}

@test "entrypoint fails without GITHUB_TOKEN" {
    unset GITHUB_TOKEN
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 1 ]
    [ "$output" == "As this action uses the GitHub API to find the latest version of Hugo, please add GITHUB_TOKEN to the secrets of your Workflow" ]
}

@test "Downloads file from URL returned by jq" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[0]}" == "Downloading latest version of Hugo: fakeurl" ]
}

@test "Runs version command" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[2]}" == "version" ]
}

@test "Runs hugo command" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    echo "$output"
    [ "${lines[3]}" == "Building with command: hugo --source . " ]
    [ "${lines[4]}" == "--source ." ]
}

