# Overview
Set up using a bare git repository following the really cool tutorial that Atlassian put up a while back.
# New Environment Setup

- *Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:*

`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

`echo ".cfg" >> .gitignore`

- *Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:*

`git clone --bare https://github.com/Skyward176/.dotfiles.git $HOME/.cfg` # https
`git clone --bare git@github.com:Skyward176/.dotfiles.git $HOME/.cfg` # ssh

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

# Oh my kitty!

the kitty config for tmux users

the shortcuts (key bindings) is heavily inspired by [Oh my tmux!](https://github.com/gpakosz/.tmux#bindings)

mainly used under Linux

## new features

### session support

kitty >= 0.43 finally support session save and allow you to switch between sessions.

we now support save current session to the session file via single keypress <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>s</kbd>.

you 'll need to create a default session file for the first time.

```shell
touch ~/.config/kitty/default.kitty-session
```

TODO: more session management features like:
1. switch between sessions
2. delete session
3. rename session
4. list sessions

## usage

```shell
# backup your config first
# mv ~/.config/kitty  ~/.config/kitty.bak

git clone https://github.com/ttys3/oh-my-kitty.git ~/.config/kitty

touch ~/.config/kitty/default.kitty-session # create a default session file
```

## customization

### override default config

You can override any default settings by creating a local config file: `${USER}.local.conf` (e.g., `ttys3.local.conf` if your username is `ttys3`).

This file is automatically included at the end of `kitty.conf`, so any settings in it will override the defaults. This allows you to customize your kitty configuration without modifying the main config file, making it easier to update the base config.

**Example: Override font family and size**

Create `~/.config/kitty/${USER}.local.conf` (replace `${USER}` with your actual username):

```conf
# Override font settings
font_family Lilex
font_size 13.0
```

You can override any kitty setting in this file. Common customizations include:
- `font_family` - Change the font
- `font_size` - Adjust font size
- `background_opacity` - Set transparency
- `background_image` - Set background image
- And any other kitty configuration option

After creating or modifying `${USER}.local.conf`, reload the config with <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>R</kbd> or restart kitty.

## suggested shell alias

```shell
alias icat="kitten icat"
alias s="kitten ssh"
alias d="kitten diff"
```

## Shortcuts

key name see <https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h>

or using `kitty --debug-input` to detect keysyms

### config

keybindings explain:

<kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>R</kbd> means:
press `ctrl` + `a` in the same time, release and then, press R (`shift`+`r`)

| key                                       | description   |
| ----------------------------------------- | ------------- |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>R</kbd> | reload config |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>E</kbd> | edit config |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>D</kbd> | debug config  |

### session

| key                                       | description                         |
| ----------------------------------------- | ----------------------------------- |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>s</kbd> | save current layout to session file |

### tab

| key                                           | description        |
| --------------------------------------------- | ------------------ |
| <kbd>ctrl</kbd>+<kbd>shift</kbd>+<kbd>←</kbd> | goto previous tab        |
| <kbd>ctrl</kbd>+<kbd>shift</kbd>+<kbd>→</kbd> | goto next tab           |
| <kbd>ctrl</kbd>+<kbd>shift</kbd>+<kbd>,</kbd> | move tab backward  |
| <kbd>ctrl</kbd>+<kbd>shift</kbd>+<kbd>.</kbd> | move tab forward   |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>,</kbd>     | change tab title   |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>c</kbd>     | create new tab     |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>x</kbd>     | close window / tab |

### os window

| key                          | description       |
| ---------------------------- | ----------------- |
| <kbd>ctrl</kbd>+<kbd>q</kbd> | quit kitty        |
| <kbd>f11</kbd>               | toggle fullscreen |

### window

| key                                                         | description                  |
| ----------------------------------------------------------- | ---------------------------- |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>-</kbd>                   | horizontal split with cwd    |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>shift</kbd>+<kbd>-</kbd>  | horizontal split             |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>\\</kbd>                  | vertial split with cwd       |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>shift</kbd>+<kbd>\\</kbd> | vertial split                |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>x</kbd>                   | close window                 |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>z</kbd>                   | zoom (maxmize) window        |
| <kbd>ctrl</kbd>+<kbd>shift</kbd>+<kbd>r</kbd>               | resize window                |
| <kbd>ctrl</kbd>+<kbd>←</kbd>                                | goto left window               |
| <kbd>ctrl</kbd>+<kbd>→</kbd>                                | goto right window              |
| <kbd>ctrl</kbd>+<kbd>↑</kbd>                                | goto up window                 |
| <kbd>ctrl</kbd>+<kbd>↓</kbd>                                | goto down window               |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>h</kbd>                   | goto left window               |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>l</kbd>                   | goto right window              |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>k</kbd>                   | goto up window                 |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>j</kbd>                   | goto down window               |
| <kbd>shift</kbd>+<kbd>←</kbd>                               | move current window to left  |
| <kbd>shift</kbd>+<kbd>→</kbd>                               | move current window to right |
| <kbd>shift</kbd>+<kbd>↑</kbd>                               | move current window to up    |
| <kbd>shift</kbd>+<kbd>↓</kbd>                               | move current window to down  |
| <kbd>alt</kbd>+<kbd>n</kbd>                                 | resize window narrower       |
| <kbd>alt</kbd>+<kbd>w</kbd>                                 | resize window wider          |
| <kbd>alt</kbd>+<kbd>u</kbd>                                 | resize window taller         |
| <kbd>alt</kbd>+<kbd>d</kbd>                                 | resize window shorter        |
| <kbd>ctrl</kbd>+<kbd>home</kbd>                             | resize window reset          |

### font

| key                          | description     |
| ---------------------------- | --------------- |
| <kbd>ctrl</kbd>+<kbd>=</kbd> | font size +     |
| <kbd>ctrl</kbd>+<kbd>-</kbd> | font size -     |
| <kbd>ctrl</kbd>+<kbd>0</kbd> | font size reset |

### misc

| key                                                       | description                                                                          |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>t</kbd>                 | kitten themes                                                                        |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>space</kbd>             | copy pasting with hints like [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs) |
| <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>ctrl</kbd>+<kbd>a</kbd> | send real <kbd>ctrl</kbd>+<kbd>a</kbd> (emacs shortcut <kbd>Home</kbd>)              |

## session restore

this config has been enabled by default in this config.

you can use <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>s</kbd> to save the current session to the session file.

which will save the current session to the session file under `~/.config/kitty/session.conf`

> kitty has long had support for [Sessions](https://sw.kovidgoyal.net/kitty/sessions/), aka simple text files where you can define what tabs, windows and programs you wish to run in kitty. Now in addition to that kitty has the ability to [create and switch between sessions](https://sw.kovidgoyal.net/kitty/sessions/#goto-session) with a single keypress and 
> also to manually setup some tabs/windows in kitty and [save it as a session file](https://sw.kovidgoyal.net/kitty/sessions/#complex-sessions), for seamless and intuitive session file creation.


## kitty docs

Keyboard shortcuts <https://sw.kovidgoyal.net/kitty/conf/#keyboard-shortcuts>

The launch command syntax reference <https://sw.kovidgoyal.net/kitty/launch/#syntax-reference>

## troubleshooting

kitty ask me where to save the session file?

you can just create a empty file for the first time:

```shell
touch ~/.config/kitty/default.kitty-session
```

and then you can use <kbd>ctrl</kbd>+<kbd>a</kbd>><kbd>s</kbd> to save the current session to the session file, it will not ask you again.

## fonts

### macOS

macOS user fonts is under `~/Library/Fonts`

Iosevka Term is a good font for terminal, you can install it via:

```shell
brew install --cask font-iosevka-term-nerd-font
```

Iosevka is a good font for coding, you can install it via:

```shell
brew install --cask font-iosevka
```

Lilex is a good font for coding, you can install it via:

```shell
brew install --cask font-lilex
```

### Linux

donwload and put the fonts to `~/.local/share/fonts` then run `fc-cache -f -v` to refresh the font cache.s
