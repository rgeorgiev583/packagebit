cmd=pacman

install() {
	$cmd --sync "$@"
}

remove() {
	$cmd --remove "$@"
}

update() {
	$cmd --sync --refresh "$@"
}

upgrade() {
	$cmd --sync --refresh --sysupgrade "$@"
}

remove-deps() {
	$cmd --remove --recursive "$@"
}

remove-deps-configs() {
	$cmd --remove --recursive --nosave "$@"
}

remove-configs() {
	$cmd --remove --nosave "$@"
}

version() {
	$cmd --version
}

search() {
	$cmd --sync --search "$@"
}

search-local() {
	$cmd --query --search "$@"
}

install-local() {
	$cmd --upgrade "$@"
}

list-files-local() {
	$cmd --query --list "$@"
}

list-local() {
	$cmd --query "$@"
}

list() {
	$cmd --sync --list "$@"
}

owned-by-local() {
	$cmd --query --owns "$@"
}

clean() {
	$cmd --sync --clean "$@"
}

remove-unneeded() {
	$cmd --query --deps --unrequired --quiet "$@" | $cmd --remove --recursive --noconfirm -
}
