cmd=cargo

upgrade() {
	$cmd install-update "$@"
}

search() {
	$cmd cargo search "$@"
}
