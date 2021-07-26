cmd=pip

install() {
	$cmd install "$@"
}

remove() {
	$cmd uninstall "$@"
}

upgrade() {
	pip-review --auto "$@"
}

version() {
	$cmd --version
}

search() {
	$cmd search "$@"
}

list-files-local() {
	$cmd show --files "$@"
}

list-local() {
	$cmd list "$@"
}

clean() {
	$cmd cache purge "$@"
}
