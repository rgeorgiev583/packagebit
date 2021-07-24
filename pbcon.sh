#!/usr/bin/env bash

PROGRAM_NAME=$(basename "$0")

set -e

function usage {
	echo "\
usage: $PROGRAM_NAME [OPTIONS] ACTION [ARGS]

CLI analog of pkcon (PackageKit), written in bash.

Options:
-b BACKEND  invoke the specified BACKEND instead of all enabled ones (this option may be used more than once)
-h          display this usage string

Actions:
install			- Install packages from repositories
remove			- Remove installed packages
update			- Update the repository database
upgrade			- Update the system and all packages
remove-deps		- Remove packages with dependencies
remove-deps-configs	- Remove packages with dependencies and all configuration files
remove-configs		- Delete packages with all configuration files
search			- Perform a keyword search in a remote repository
search-local		- Perform a keyword search among locally installed packages
install-local		- Install packages from a file
list-files-local	- View a list of files that provide locally installed packages
version			- View the package manager version
list			- View a list of all packages in the repository
list-local		- View a list of all locally installed packages
owned-by		- View which package from the repository owns the file
owned-by-local		- View which locally installed package owns the file
install-by-file		- Install a package from a repository based on a file it owns
list-files		- View a list of package files from the repository
clean			- Clear the batch manager cache
remove-unneeded		- Remove unnecessary packages
" >&2
	exit 1
}

if [[ $# -eq 0 ]]; then
	usage
fi

actions=('install' 'remove' 'update' 'upgrade' 'remove-deps' 'remove-deps-config'
	'remove-configs' 'search' 'search-local' 'install-local' 'list-files-local'
	'version' 'list' 'list-local' 'owned-by' 'owned-by-local' 'install-by-file'
	'list-files' 'clean' 'remove-unneeded')

[[ -z $CONFIG_FILENAME ]] && CONFIG_FILENAME='/etc/PackageBit.conf'
[[ -z $LIB_DIR ]] && LIB_DIR='/usr/local/share/PackageBit'

while getopts :b:h opt; do
	case $opt in
	b)
		enabled_backends+=("$OPTARG")
		;;

	h)
		usage
		;;

	*)
		echo "error: unknown option: -$opt" >&2
		exit 1
		;;
	esac
done

shift $((OPTIND - 1))

if [[ -f "$CONFIG_FILENAME" ]]; then
	# shellcheck disable=SC1090
	source "$CONFIG_FILENAME"
fi

if [[ "${#enabled_backends[@]}" -eq 0 ]]; then
	# shellcheck disable=SC2207
	enabled_backends=($(basename -a -s .backend.sh "$LIB_DIR"/*.backend.sh))
fi

set +e

for backend in "${enabled_backends[@]}"; do
	unset "${actions[@]}" is_action_known

	# shellcheck disable=SC1090
	if ! source "$LIB_DIR/$backend.backend.sh"; then
		continue
	fi

	for action in "${actions[@]}"; do
		if [[ $action = "$1" ]]; then
			is_action_known=1
			break
		fi
	done
	if [[ -z $is_action_known ]]; then
		echo "$PROGRAM_NAME: error: unknown action: $1" >&2
		continue
	fi

	if ! command -v "$1" >/dev/null; then
		echo "$PROGRAM_NAME: error: action not supported by the $backend backend: $1" >&2
		continue
	fi

	"$@"
done
