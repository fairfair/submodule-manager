#!/bin/bash

if [ ! -f "submodule.lock" ]; then
    echo "{}" > submodule.lock
fi

if [ "$1" == "--install" ]; then
    source ".submodule/update.sh"
fi

if [ "$1" == "--update" ]; then
    source ".submodule/update.sh"
fi

if [ "$1" == "--check-dependency" ]; then
    source ".submodule/analyze-dependency.sh"
fi