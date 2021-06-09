#!/bin/bash

printf "Oppdater pathene til mappestuktur og chrome før bruk"
exit 1

MY_PATH="$( cd "$(dirname "$0")" && pwd )"
PREFAB="${MY_PATH}"'/prefab.md'
TASK_DIR="${MY_PATH}"'Plasserinen til saksmappen'$1
TASK_FILE="${TASK_DIR}"'Plasserinen til saksmappen/JIRA prefix-'$1'.md'

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

function createDir() {
  if [ ! -d "${TASK_DIR}" ]; then
    mkdir "${TASK_DIR}"
  fi
}

function createMarkDown() {
  if [ ! -f "${TASK_FILE}" ]; then
    cp "${PREFAB}" "${TASK_FILE}"
  fi
}

function replaceVariabels() {
  sed -i 's/<TASK_ID>/'"$1"'/g' "$TASK_FILE"
}

validateInput "$@"
createDir
createMarkDown
replaceVariabels "$@"

subl "${TASK_FILE}"
chrome ""$1
