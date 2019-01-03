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

@test "Default directory is set to public" {
    run $GITHUB_WORKSPACE/entrypoint.sh
    echo "$output"
    [ "$status" -eq 0 ]
    [ "$output" = "Ran with directory public" ]
}

@test "Can override directory correctly" {
    export PUBLIC_PATH="OTHER-PATH"
    run $GITHUB_WORKSPACE/entrypoint.sh
    echo "$output"
    [ "$status" -eq 0 ]
    [ "$output" = "Ran with directory OTHER-PATH" ]
}

@test "entrypoint fails without GITHUB_TOKEN" {
    unset GITHUB_TOKEN
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 1 ]
    [ "$output" == "Please add GITHUB_TOKEN to the secrets of your Workflow." ]
}

@test "entrypoint fails if gh-pages fails" {
    export PUBLIC_PATH="FAIL"
    run $GITHUB_WORKSPACE/entrypoint.sh
    [ "$status" -eq 1 ]
    echo "$output"
    [ "$output" == "gh-pages failed: 1" ]
}

@test "Create CNAME file if DOMAIN is specified" {
    export DOMAIN="ig.nore.me"
    export PUBLIC_PATH="."
    export GITHUB_WORKSPACE=$BATS_TMPDIR
    run ./entrypoint.sh
    [ "$status" -eq 0 ]
    cnamefile=$(cat "$GITHUB_WORKSPACE/CNAME")
    [ "$cnamefile" == "$DOMAIN" ]
}