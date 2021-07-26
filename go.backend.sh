cmd=go

install() {
	$cmd get "$@"
}

upgrade() {
	$cmd get -u "$@" all
}

version() {
	$cmd version "$@"
}
