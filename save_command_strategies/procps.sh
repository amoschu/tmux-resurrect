#!/usr/bin/env bash
PANE_PID="$1"

exit_safely_if_empty_ppid() {
	if [ -z "$PANE_PID" ]; then
		exit 0
	fi
}

exit_if_command_not_installed() {
	local has_procps=$(which procps >/dev/null 2>&1; echo $?)
	if [[ "$has_procps" -ne 0 ]]; then
		exit 0
	fi
}

full_command() {
	procps --no-headers --ppid "${PANE_PID}" -o "ppid cmd" |
		sed "s/^ *//" |
		cut -d' ' -f2-
}

main() {
	exit_safely_if_empty_ppid
	exit_if_command_not_installed
	full_command
}
main

