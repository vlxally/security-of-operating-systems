#!/bin/bash

LOG_FILE="/tmp/run.log"

touch "$LOG_FILE"

prev_runs=$(wc -l < "$LOG_FILE")

date >> "$LOG_FILE"

echo "Hello, world!"

echo "$prev_runs" >&2
