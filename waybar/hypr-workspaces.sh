#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

make -f $SCRIPT_DIR/Makefile > /dev/null

$SCRIPT_DIR/hypr_workspaces
