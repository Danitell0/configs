# configs

My terminal setup: Ghostty + tmux workspaces, nvim, yazi, and friends.
Solarized Dark everywhere, keys that mirror my nvim config.

## Install (no sudo needed)

```bash
git clone <this repo> ~/configs
cd ~/configs && ./install.sh
```

- Links every config into `~/.config` (edits there edit this repo).
  Whatever was there before is kept as `<name>.bak-<date>`.
- Downloads missing tools into `~/.local/bin`: nvim, yazi, fzf, fastfetch,
  zoxide, eza, bat, btop. tmux and cava have no official prebuilt
  binaries, so they need apt, brew, or IT.
- Adds one line to `~/.bashrc` that sources `bash/dotfiles.sh`.

`./install.sh links` or `./install.sh tools` does just one half.

## Layout

| Path | What |
|---|---|
| `nvim/` | Neovim config (lazy.nvim, Telescope, Harpoon, Solarized) |
| `ghostty/config` | Terminal: theme, font, opens straight into `ws` |
| `tmux/tmux.conf` | Workspaces, nvim-style keys, Solarized top bar |
| `tmux/keys.txt` | Cheat sheet data (`Ctrl+Space ?` or `keys`) |
| `bin/ws` | Builds the workspace set; `ws code [dir]` adds a project workspace |
| `bin/pick-project` | Fuzzy project picker used by `ws` |
| `bin/nvim-open` | Opens files from the yazi tree in the workspace's nvim |
| `bin/keys` | Searchable cheat sheet |
| `bin/pane-restart` | Force-restart a frozen pane (`Ctrl+Space X`) |
| `bash/dotfiles.sh` | `y`, `z`, eza/bat aliases, nvim socket wrapper |
| `yazi/`, `yazi-sidebar/` | File manager, full view and tree view |
| `btop/`, `cava/`, `fastfetch/` | The sys workspace (monitor, visualizer, skull) |

## Workspaces

| Key | Workspace |
|---|---|
| `Alt+1` | code: yazi tree + Claude, nvim + terminal (project picked at start) |
| `Alt+2` | files: yazi |
| `Alt+3` | sys: btop, fastfetch, cava |
| `Alt+4` | dev: nvim + shell |

Leader is `Ctrl+Space`. `Ctrl+Space ?` shows every key.
