cmd=rustup

install() {
	$cmd toolchain install "$@"
}

remove() {
	$cmd toolchain uninstall "$@"
}

upgrade() {
	$cmd update "$@"
}

list-local() {
	$cmd toolchain list "$@"
}
