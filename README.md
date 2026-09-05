# conf

Personal configuration for Neovim, tmux, and zsh.

Each directory holds the real config; the live dotfile locations are symlinks
back into this repo, so `git status` here shows exactly what has drifted.

```
nvim/     Neovim config (lua, lazy.nvim)
tmux/     tmux config + helper scripts   -> see tmux/README.md
zsh/      zsh theme
bin/      setup scripts
```

# Neovim

## Quick start

```bash
git clone https://github.com/jwke21/conf.git ~/Documents/conf
cd ~/Documents/conf
./bin/setup-nvim
```

The script installs any missing dependencies, links `~/.config/nvim` to
`nvim/`, and bootstraps plugins. It is safe to re-run.

To see what it would do without changing anything:

```bash
./bin/setup-nvim --check
```

## Prereqs

| Tool | Why | macOS | Debian/Ubuntu |
|---|---|---|---|
| Neovim >= 0.12.0 | nvim-treesitter `main` requires it | `brew install neovim` | build from source |
| tree-sitter CLI >= 0.26.1 | builds parsers | `brew install tree-sitter` | `cargo install tree-sitter-cli` |
| C compiler + make | parsers, telescope-fzf-native | `xcode-select --install` | `apt install build-essential` |
| ripgrep | telescope live_grep | `brew install ripgrep` | `apt install ripgrep` |
| git, curl, tar | plugin and parser downloads | included | usually present |

Install the tree-sitter CLI from a package manager or cargo — **not npm**.
The npm build is explicitly unsupported by nvim-treesitter.

Ubuntu's `neovim` package is far too old. Build from source:
<https://github.com/neovim/neovim/blob/master/BUILD.md>

### For Go development

```bash
go install golang.org/x/tools/cmd/goimports@latest
```

`goimports` is conform's only Go formatter and is **not** installed by Mason.
Make sure `$(go env GOPATH)/bin` is on your PATH, or format-on-save silently
falls back to LSP formatting and stops managing imports.

### Fonts

Icons in nvim-tree and lualine need a [Nerd Font](https://www.nerdfonts.com/).
`SauceCodePro ExtraLight` is the one in use.

## Manual setup

If you'd rather not run the script:

```bash
mkdir -p ~/.config
ln -s ~/Documents/conf/nvim ~/.config/nvim
nvim    # lazy.nvim installs everything on first launch
```

First launch clones plugins, downloads three LSP servers via Mason, and
compiles 16 tree-sitter parsers. Expect a few minutes of churn.
Check the result with `:checkhealth`.

## What's configured

- **Plugins** — lazy.nvim, pinned by `nvim/lazy-lock.json`
- **LSP** — mason + mason-lspconfig v2; `gopls`, `lua_ls`, `rust_analyzer`
- **Completion** — nvim-cmp with LSP, buffer, path, cmdline, and LuaSnip sources
- **Syntax** — nvim-treesitter (`main` branch) + textobjects
- **Finder** — telescope with the native fzf sorter
- **Format** — conform, `goimports` on save for Go
- **Git** — gitsigns
- **UI** — catppuccin (mocha), lualine, nvim-tree, which-key

## Keymaps

Leader is `<Space>`. Press it alone to see everything via which-key.

| Key | Action |
|---|---|
| `<leader>w` | save file |
| `<leader>e` / `<leader>fe` | toggle / focus file explorer |
| `<leader>t` | terminal in a split below |
| `<leader>ff` `<leader>fg` `<leader>fb` `<leader>fh` | find files, live grep, buffers, help |
| `<leader>ca` `<leader>rn` `<leader>lf` | code action, rename, format |
| `gd` `gD` `gi` `gR` `K` | definition, declaration, implementation, references, hover |
| `]c` / `[c` | next / previous git hunk |
| `<leader>gs` `<leader>gp` `<leader>gb` | stage hunk, preview hunk, toggle blame |
| `]m` / `[m` | next / previous function |
| `af` `if` `ac` `ic` `aa` `ia` | select function / struct / parameter |
| `<Esc>` (terminal) | leave terminal mode |

## Notes

**Use `:Lazy install`, not `:Lazy sync`.** `sync` updates every plugin past
the lockfile. That has broken this config before — a newer catppuccin required
`vim.pack`, which older Neovim builds don't have. `install` only fetches what
is missing.

To deliberately update: commit `lazy-lock.json` first, run `:Lazy update`, and
test. `git checkout nvim/lazy-lock.json` followed by `:Lazy restore` is the way
back.

**Changing a plugin's branch needs a re-clone.** lazy.nvim will not move an
already-installed plugin between branches; the lockfile wins. Delete the
directory under `~/.local/share/nvim/lazy/` and re-run
`nvim --headless "+Lazy! install" +qa`.

**nvim-treesitter `main` cannot be lazy-loaded.** Both treesitter specs keep
`lazy = false` deliberately.
