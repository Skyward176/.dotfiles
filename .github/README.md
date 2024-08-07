# Overview
Set up using a bare git repository following the really cool tutorial that Atlassian put up a while back.
# New Environment Setup

- *Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:*

`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

`echo ".cfg" >> .gitignore`

- *Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:*

`git clone --bare <git-repo-url> $HOME/.cfg`

- *Define the alias in the current shell scope:*

`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

- *Checkout the actual content from the bare repository to your $HOME:*
`config checkout`

- *The step above might fail with a message like:*
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care. I provide you with a possible rough shortcut to move all the offending files automatically to a backup folder:
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

```
- *Re-run the check out if you had problems:*

`config checkout`

- *Set the flag showUntrackedFiles to no on this specific (local) repository:*

`config config --local status.showUntrackedFiles no`

# NVIM

## Packages

Here's a list of all the packages in my nvim config and their relevant keybinds.

### nvim tree

The classic nerdtree but its lua.

### Telescope

A fuzzy finder for nvim. Also has a cool file explorer extension.

### lualine

Airline stuff, it's the little tabs at the top and bottom of the screen

### treesitter

Fancy highlighting and text objects and more

### yanky.nvim

Improves yank behavior. Important notes:
- replaces put with yanky put
- `<c-p>` and `<c-n>` let you cycle entries in yanky ring(clipboard, basically)

Also gives cool put features(read keybinds file)

### vim-cutlass

Delete actually deletes, adds a 'move' or 'cut' motion with the 'x' key.

### vim-subversive

Adds substitute/find-replace motion. Read the keybinds for details.

### vim-repeat

It's a prereq to other packages. I don't actually know what it does really.

### vim-fugitive

Git in vim

### nvim-web-devicons

Devicons.

### tokyonight

Theme.

### dressing.nvim

Make things pretty.

### nvim-surround

Motions/verbs to edit all the surrounding bits but *cooler*.

The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the following examples, * will denote the cursor position:

    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls
Detailed information on how to use this plugin can be found in :h nvim-surround.usage.

### nvim-cmp

Code completion in nvim. 
Sources:
- nvim-copilot
- nvim_lsp
- nvim_lua
- luasnip

### Mason

Handles installation and configuration of nvim-lsps 

# TMUX
# Other Tools
