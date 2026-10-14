#!/usr/bin/env bash
# install.sh - set up these configs on a machine, no sudo needed.
#
#   ./install.sh          link configs + install missing tools
#   ./install.sh links    only link configs
#   ./install.sh tools    only install missing tools
#
# Configs are symlinked, so editing ~/.config/... edits this repo.
# Anything already there is moved to <name>.bak-<date> first.
# Tools go to ~/.local/bin from their official GitHub releases (x86_64 Linux).

set -u
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$HOME/.local/bin"
CFG="$HOME/.config"
STAMP="$(date +%Y%m%d-%H%M%S)"

say() { printf '\033[36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[33m !\033[0m  %s\n' "$*"; }

# link SRC (in repo) -> DEST
link() {
	local src="$REPO/$1" dest="$2"
	mkdir -p "$(dirname "$dest")"
	if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
		return
	fi
	if [ -L "$dest" ]; then
		rm "$dest"                       # old link (e.g. repo moved): just replace
	elif [ -f "$dest" ] && cmp -s "$src" "$dest"; then
		rm "$dest"                       # same file already: no backup needed
	elif [ -e "$dest" ] || [ -L "$dest" ]; then
		mv "$dest" "$dest.bak-$STAMP"
		warn "moved old $dest -> $dest.bak-$STAMP"
	fi
	ln -s "$src" "$dest"
	say "linked $dest"
}

do_links() {
	link nvim                   "$CFG/nvim"
	link ghostty/config         "$CFG/ghostty/config"
	link tmux/tmux.conf         "$CFG/tmux/tmux.conf"
	link tmux/keys.txt          "$CFG/tmux/keys.txt"
	link yazi/yazi.toml         "$CFG/yazi/yazi.toml"
	link yazi-sidebar/yazi.toml "$CFG/yazi-sidebar/yazi.toml"
	link cava/config            "$CFG/cava/config"
	link fastfetch/config.jsonc "$CFG/fastfetch/config.jsonc"
	link fastfetch/skull.txt    "$CFG/fastfetch/skull.txt"
	link bash/dotfiles.sh       "$CFG/bash/dotfiles.sh"
	for f in "$REPO"/bin/*; do
		link "bin/$(basename "$f")" "$BIN/$(basename "$f")"
	done
	# btop rewrites its whole config on exit, so copy it instead of linking
	if [ ! -e "$CFG/btop/btop.conf" ]; then
		mkdir -p "$CFG/btop" && cp "$REPO/btop/btop.conf" "$CFG/btop/btop.conf"
		say "copied btop.conf"
	fi
	local line='[ -f ~/.config/bash/dotfiles.sh ] && . ~/.config/bash/dotfiles.sh'
	if ! grep -qF "$line" "$HOME/.bashrc" 2>/dev/null; then
		printf '\n# Ghostty/tmux workspace setup (configs repo)\n%s\n' "$line" >> "$HOME/.bashrc"
		say "added dotfiles.sh to ~/.bashrc"
	fi
}

# gh_get OWNER/REPO ASSET_REGEX -> prints a temp dir with the extracted asset
gh_get() {
	local url tmp
	url=$(curl -fsSL "https://api.github.com/repos/$1/releases/latest" |
		grep -o '"browser_download_url": *"[^"]*"' | sed 's/.*"\(http[^"]*\)"$/\1/' |
		grep -E "$2" | head -1)
	[ -z "$url" ] && return 1
	tmp=$(mktemp -d)
	curl -fsSL -o "$tmp/asset" "$url" || return 1
	case "$url" in
		*.zip) unzip -q "$tmp/asset" -d "$tmp/x" ;;
		*.tar.gz | *.tgz) mkdir -p "$tmp/x" && tar -xzf "$tmp/asset" -C "$tmp/x" ;;
		*.tbz | *.tar.bz2) mkdir -p "$tmp/x" && tar -xjf "$tmp/asset" -C "$tmp/x" ;;
	esac
	echo "$tmp"
}

# tool NAME OWNER/REPO ASSET_REGEX [BINARIES...]
tool() {
	local name="$1" repo="$2" re="$3" tmp b f
	shift 3
	command -v "$name" >/dev/null && return
	say "installing $name"
	if ! tmp=$(gh_get "$repo" "$re"); then
		warn "could not download $name"
		return
	fi
	for b in "${@:-$name}"; do
		f=$(find "$tmp/x" -type f -name "$b" -perm -u+x | head -1)
		[ -n "$f" ] && install -m755 "$f" "$BIN/$b"
	done
	rm -rf "$tmp"
}

do_tools() {
	mkdir -p "$BIN"
	export PATH="$BIN:$PATH"
	if ! command -v nvim >/dev/null; then
		say "installing nvim"
		if tmp=$(gh_get neovim/neovim 'nvim-linux-x86_64\.tar\.gz$'); then
			rm -rf "$HOME/.local/opt/nvim" && mkdir -p "$HOME/.local/opt"
			mv "$tmp/x/nvim-linux-x86_64" "$HOME/.local/opt/nvim"
			ln -sfn "$HOME/.local/opt/nvim/bin/nvim" "$BIN/nvim"
			rm -rf "$tmp"
		else
			warn "could not download nvim"
		fi
	fi
	tool yazi      sxyazi/yazi           'yazi-x86_64-unknown-linux-musl\.zip$' yazi ya
	tool fzf       junegunn/fzf          'linux_amd64\.tar\.gz$'
	tool fastfetch fastfetch-cli/fastfetch 'fastfetch-linux-amd64\.tar\.gz$'
	tool zoxide    ajeetdsouza/zoxide    'x86_64-unknown-linux-musl\.tar\.gz$'
	tool eza       eza-community/eza     'eza_x86_64-unknown-linux-musl\.tar\.gz$'
	command -v batcat >/dev/null ||
		tool bat   sharkdp/bat           'x86_64-unknown-linux-musl\.tar\.gz$'
	tool btop      aristocratos/btop     'btop-x86_64-unknown-linux-musl\.tar\.gz$'

	# no official prebuilt binaries for these two
	for t in tmux cava; do
		command -v "$t" >/dev/null && continue
		if command -v brew >/dev/null; then
			say "installing $t (brew)"
			brew install "$t"
		else
			warn "$t not found and no prebuilt binary exists."
			warn "   ask IT, or install Homebrew in your home dir, then: brew install $t"
		fi
	done
}

case "${1:-all}" in
	links) do_links ;;
	tools) do_tools ;;
	all) do_tools; do_links ;;
	*) echo "usage: $0 [links|tools]"; exit 1 ;;
esac
say "done. Open a new terminal (or run: . ~/.bashrc)"
command -v tmux >/dev/null || warn "without tmux, Ghostty opens a plain shell instead of the workspaces"
