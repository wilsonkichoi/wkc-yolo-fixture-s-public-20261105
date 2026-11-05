#!/bin/sh
set -eu
action=$1
name=$2
root=/Users/wchoi/tmp/pr100-handoff/evidence/S/gate-state
mkdir -p "$root"
if [ "$action" = cleanup ]; then rm -f "$root/$name.deployed"; exit 0; fi
printf '%s %s\n' "$action" "$name" >> "$root/$name.attempts"
case $action in
 local) echo "local gate passed" ;;
 qa) [ -f "$root/$name.up" ] || { echo "connection refused: fixture QA endpoint unavailable" >&2; exit 7; }; echo "qa deploy passed" ;;
 staging|preview|sandbox) date +%s > "$root/$name.deployed"; echo "deployed $name" ;;
 production) date +%s > "$root/$name.production"; echo "production marker written" ;;
 intermittent) [ "$(wc -l < "$root/$name.attempts" | tr -d ' ')" -gt 1 ] || { echo "intermittent smoke failure" >&2; exit 1; }; echo "smoke passed" ;;
 code) [ "$(cat VERSION)" = '0.0.2' ] || { echo "code result VERSION must be 0.0.2, actual $(cat VERSION)" >&2; exit 1; }; echo "version gate passed" ;;
 *) echo "unknown gate" >&2; exit 2 ;;
esac
