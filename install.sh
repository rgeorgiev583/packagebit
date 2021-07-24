#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]]; then
	echo "error: must be run as root" >&2
	exit 1
fi

install -D -m 755 pbcon.sh /usr/local/bin/pbcon
for backend in *.backend.sh; do
	install -D -m 644 "$backend" "/usr/local/share/PackageBit/$backend"
done
