#!/bin/bash

function createMarkDown() {
  MY_PATH="$( cd "$(dirname "$0")" && pwd )"
  PREFAB="${MY_PATH}"'/prefab.md'
  TASK_FILE="${MY_PATH}"'/ITASADF/ITASADF-'$1'.md'

  if [ ! -f "${TASK_FILE}" ]; then
    cp "${PREFAB}" "${TASK_FILE}"
  fi
}

function validateInput() {
  if [ -z "$1" ]
  then
    printf "Argument missing: ID\n"
    exit 1
  else
    re='^[0-9]+$'
    if ! [[ "$1" =~ $re ]] ; then
       echo "Error: Not a number" >&2
       exit 1
    fi
  fi
}

validateInput "$@"
createMarkDown "$@"
subl "${TASK_FILE}"