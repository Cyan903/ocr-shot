#!/usr/bin/env bash

# Client for ocr-shot
#   Copy response from ocr-shot to clipboard

source "$(dirname "$(realpath "$0")")/../.env"

if ! curl "$PROTOCOL://$HOST:$PORT/" > /dev/null; then
    notify-send "ocr-shot" "Server is not live!"
    exit 1
fi

res=$(
    maim --select | curl --request POST \
        --url "$PROTOCOL://$HOST:$PORT/" \
        --header "Content-Type: multipart/form-data" \
        --form "file=@-"
)

if [[ "$(echo "$res" | jq .status)" -ne 200 ]]; then
    notify-send "ocr-shot" "Server error - $(echo "$res" | jq .message)"
    exit 1
fi

if ! echo "$res" | jq -r .message | xclip -selection c; then
    notify-send "ocr-shot" "Failed to copy message"
    exit 1
fi

