cmd='yarn global'

install() {
	$cmd add "$@"
}

uninstall() {
	$cmd remove "$@"
}

upgrade() {
	$cmd upgrade "$@"
}

version() {
	$cmd --version "$@"
}

list-local() {
	$cmd list "$@"
}
