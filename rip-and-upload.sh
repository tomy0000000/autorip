#!/usr/bin/env bash
set -eu -o pipefail

TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
LOCAL_DIR="${HOME}/Music/autorip"
OUTPUTDIR="${TIMESTAMP}"
DROPBOX_BASE_DIR='Requested/Music'

echo "==========${TIMESTAMP}=========="

# Enter work directory
cd "${LOCAL_DIR}"

# Rip CD into flac
OUTPUTDIR="${OUTPUTDIR}" abcde -N -x -P -o flac

# Upload to Dropbox file by file
for file in "${OUTPUTDIR}"/*; do
    # Check if the item is a file
    echo "Uploading ${file}"
    if [ -f "${file}" ]; then
        dbxcli put "${file}" "${DROPBOX_BASE_DIR}/${file}"
        echo "Done: ${file}"
    fi
done

echo "==========${TIMESTAMP}=========="
