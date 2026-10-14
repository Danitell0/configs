# dotfiles.sh - shell setup for the Ghostty + tmux workspaces.
# Sourced from ~/.bashrc (install.sh adds the line). Keep personal stuff in .bashrc.

case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
export EDITOR=nvim VISUAL=nvim
# yazi: `y` opens the file manager, and quitting with q cd's you to where you were
y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# zoxide: `z proj` jumps to a frequent dir, `zi` picks interactively
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
# eza: nicer ls
if command -v eza >/dev/null; then
	alias ls='eza --icons --group-directories-first'
	alias ll='eza -la --icons --git --group-directories-first'
	alias lt='eza --tree --level=2 --icons'
fi
# In a ws "code" workspace, nvim listens on $NVIM_SOCK so the yazi tree
# can open files in it (see ~/.local/bin/ws and nvim-open).
nvim() {
	if [ -n "$NVIM_SOCK" ] && [ -z "$NVIM" ] &&
		! command nvim --server "$NVIM_SOCK" --remote-expr 1 >/dev/null 2>&1; then
		rm -f -- "$NVIM_SOCK"
		command nvim --listen "$NVIM_SOCK" "$@"
	else
		command nvim "$@"
	fi
}
# bat: called batcat on Ubuntu's apt package, bat everywhere else
if command -v batcat >/dev/null; then
	alias bat='batcat'
	alias cat='batcat --paging=never --style=plain'
elif command -v bat >/dev/null; then
	alias cat='bat --paging=never --style=plain'
fi
