cmd=gem

install() {
	$cmd install "$@"
}

remove() {
	$cmd uninstall "$@"
}

upgrade() {
	$cmd update "$@"
}

version() {
	$cmd --version
}

search() {
	$cmd search "$@"
}

search-local() {
	$cmd list "$@"
}

list() {
	$cmd search "$@"
}

list-local() {
	$cmd list "$@"
}

list-files() {
	$cmd contents "$@"
}

remove-unneeded() {
	$cmd cleanup "$@"
}
