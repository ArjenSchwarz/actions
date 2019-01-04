#!/usr/bin/env bats

function setup() {
    # Override PATH to mock out the aws cli
    export PATH="$BATS_TEST_DIRNAME/bin:$PATH"
    # Ensure GITHUB_WORKSPACE and other required values are set
    export GITHUB_WORKSPACE='.'
    export GITHUB_TOKEN="key"
    export GITHUB_REPOSITORY="ArjenSchwarz/actions"
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

@test "entrypoint fails without GITHUB_TOKEN" {
    unset GITHUB_TOKEN
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 1 ]
    [ "$output" == "As this action uses the GitHub API to find the latest version of Hugo, please add GITHUB_TOKEN to the secrets of your Workflow" ]
}

@test "Downloads file from URL returned by jq" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[0]}" == "Downloading latest version of ghr: fakeurl" ]
}

@test "Runs version command" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[1]}" == "ghr version output: version" ]
}

@test "Runs ghr command" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[2]}" == "Building with command: ghr -t key -u ArjenSchwarz -r actions --debug  pre-release output" ]
    [ "${lines[3]}" == "-t key -u ArjenSchwarz -r actions --debug  pre-release output" ]
}

@test "Arguments are taken as options" {
    run $GITHUB_WORKSPACE/entrypoint.sh -l fake
    [ "${lines[2]}" == "Building with command: ghr -t key -u ArjenSchwarz -r actions --debug -l fake pre-release output" ]
    [ "${lines[3]}" == "-t key -u ArjenSchwarz -r actions --debug -l fake pre-release output" ]
}

@test "Default VERSION is set to pre-release" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[2]}" == "Building with command: ghr -t key -u ArjenSchwarz -r actions --debug  pre-release output" ]
    [ "${lines[3]}" == "-t key -u ArjenSchwarz -r actions --debug  pre-release output" ]
}

@test "Default VERSION can be overridden" {
    export VERSION="latest"
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[2]}" == "Building with command: ghr -t key -u ArjenSchwarz -r actions --debug  latest output" ]
    [ "${lines[3]}" == "-t key -u ArjenSchwarz -r actions --debug  latest output" ]
}

@test "Default SOURCE_PATH is set to output" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[2]}" == "Building with command: ghr -t key -u ArjenSchwarz -r actions --debug  pre-release output" ]
    [ "${lines[3]}" == "-t key -u ArjenSchwarz -r actions --debug  pre-release output" ]
}

@test "Default SOURCE_PATH can be overridden" {
    export SOURCE_PATH="pkg"
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "${lines[2]}" == "Building with command: ghr -t key -u ArjenSchwarz -r actions --debug  pre-release pkg" ]
    [ "${lines[3]}" == "-t key -u ArjenSchwarz -r actions --debug  pre-release pkg" ]
}