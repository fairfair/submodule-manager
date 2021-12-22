#!/bin/bash

SCRIPT_PATH="${BASE_DIR}${TARGET}/install.sh"


if [ -f "$SCRIPT_PATH" ]; then
    if [ "$SCRIPT_EXECUTION" == 'manual' ]; then
        source "$BASE_DIR/.submodule/logger/warn.sh" "Do you want execute pre-script of $REPOSITORY [Y/n]"
        read -r RESPONSE

        if [ "$RESPONSE" == "Y" ] || [ "$RESPONSE" == "y" ]; then
            source "$SCRIPT_PATH" "${BASE_DIR}${TARGET}"
        fi
    fi

    if [ "$SCRIPT_EXECUTION" == 'auto' ]; then
        source "$SCRIPT_PATH" "${BASE_DIR}${TARGET}"
    fi

    rm "$SCRIPT_PATH"

fi