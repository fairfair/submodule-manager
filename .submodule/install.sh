#!/bin/bash

BASE_DIR="$PWD"
CONFIG=$(cat "$BASE_DIR/submodule.json")
LOCK=$(cat "$BASE_DIR/submodule.lock")

for ((i = 0; i < $(jq '. | length' <<<$CONFIG); i++)); do
    NAME="$(jq -r .[$i].name <<<$CONFIG)"
    TARGET="$(jq -r .[$i].target <<<$CONFIG)"
    REPOSITORY="$(jq -r .[$i].repository <<<$CONFIG)"
    TAG="$(jq -r .[$i].tag <<<$CONFIG)"
    SCRIPT_EXECUTION="$(jq -r .[$i].scriptExecution <<<$CONFIG)"

    if [ -d "${BASE_DIR}${TARGET}" ]; then
        source "$BASE_DIR/.submodule/logger/warn.sh" "Directory $TARGET already exists, Overwrite ? [Y/n] "
        read -r RESPONSE

        if [ "$RESPONSE" == "N" ] || [ "$RESPONSE" == "n" ]; then
            source "$PWD/.submodule/logger/warn.sh" "Skipping dependency $REPOSITORY"
            continue
        fi

        source "$BASE_DIR/.submodule/logger/info.sh" "Removing of $TARGET ..."
        rm -Rf "${BASE_DIR}${TARGET}"
    fi

    git clone "$REPOSITORY" "${BASE_DIR}${TARGET}"

    if [ "$?" != "0" ]; then
        source "$BASE_DIR/.submodule/logger/error.sh" "This repository doesn't seem to exist"
        source "$BASE_DIR/.submodule/logger/error.sh" "Skipping..."
        continue
    fi

    cd "${BASE_DIR}${TARGET}"
    git fetch --all
    git -c advice.detachedHead=false checkout "tags/$TAG"

    if [ "$?" != "0" ]; then
        source "$BASE_DIR/.submodule/logger/error.sh" "Tag doesn't seem to exist"
        source "$BASE_DIR/.submodule/logger/error.sh" "Skipping..."
        continue
    fi

    cd "$BASE_DIR"

    source "${BASE_DIR}/.submodule/install/script.sh"

    rm -Rf "${BASE_DIR}${TARGET}/.git"

    if [ "$(jq .$NAME <<<$LOCK)" != "null" ]; then
        LOCK=$(jq "del(.$NAME)" <<<$LOCK)
    fi

    LOCK=$(jq ".$NAME += {\"tag\": \"$TAG\"}" <<<$LOCK)

    source "${BASE_DIR}/.submodule/dependency.sh" "${BASE_DIR}${TARGET}"

    source "$BASE_DIR/.submodule/logger/success.sh" "The repository has been successfully installed"
done

echo "$LOCK" > "$PWD/submodule.lock"
