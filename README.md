# vim-gasm

Vim-gasm is the the respository I use to manage my neovim/vim configuration. As a lot of now newovim users I started using vim as my editor, so I keep an old configuration to my previous most loved editor in the `legacy` branch.

Other than that, this repo contains only lua-based neovim configurations which
I started to develop in 2020. Since January 1st 2021, the stable configuration
is in the `main` branch. I mostly work sshing to different servers and to edit
files I want a blazing fast editor with some IDE features. So the core ideas
for this repo are:
- Fast: Neovim starts usually in 10 ms. I love that speed, and I want it to
remain that way. `packer.nvim` allows to lazyload the plugins thus the startup
time does not necesarily linearly increase with the number of plugins. I try
to lazyload as much plugins as possible. Obviously some of them do not make
sense to be lazyloaded, since I want them in any nvim session. But for example
`nvim-cmp` does not need to be loaded till I start insert mode. I leverage this 
azyloading it till that event happens.
- Extensible: I mostly code in `C/C++` and `python`, but I also need to look
at code written in other languages. I want to be able to use the same
configuration but very few changes to read other languages and have similar
features. 
- Lua: I want to use as much lua as possible. This is a 100 % full-written in 
`lua` neovim configuration.

> luavim launches in ~ 40 ms in my M1 Macbook Air, 70 ms in my mid2013 Macbook
> Air and in 60 ms (averagge) in the main cluster of machines I log in to.

## Features
* Vast majority of plugins are lazy loaded.
* Lua-based configuration.
* Less than 50 ms startup time in my M1 Macbook Air.
* +70 configured plugins.
* Using builtin LSP and Treesitter.
* Copilot and TabNine completion enabled.


## How does it look?

<img width="1680" alt="Screenshot 2022-01-01 at 04 44 12" src="https://user-images.githubusercontent.com/41004396/147843614-267a8f74-e8b9-4eb8-9a97-b97788e66547.png">

<img width="1680" alt="Screenshot 2022-01-01 at 04 44 54" src="https://user-images.githubusercontent.com/41004396/147843608-86537859-ea47-4fce-b252-3e1ea83dc0c9.png">

<img width="1680" alt="Screenshot 2022-01-01 at 04 53 20" src="https://user-images.githubusercontent.com/41004396/147843599-80cdbb73-14f0-494b-bd7e-9d6881ad49b0.png">


## Testing and usage
Here I post some useful tips:
* **Template:** This repository should work out of the box. If it does not, please open an
issue and I will try to fix it. Be aware that some binaries are needed in order 
this repo to work out such as `fzf`, `treesiter`, `ripgrep` etc.
* **Terminal:** I use kitty as my terminal with Victor/Iosevka fonts (nerdfonts). Kitty is in
my opinion one of the best terminal emulators out there. I use it as my primary 
emulator and I leverage a lot its image protocol features. For example latex and
markdown previews will not work without kitty.
* **System:** My main machine runs macOS (Monterey) but I actually spent most 
of my time editing in servers running CentOS7 and SCL6. Where this configuration
is working.
* **Neovim:** Version *0.6* is required (not mostly) for example to have virtual 
text as Copilot needs. As a matter of fact I usually just use the main branch 
of the neovim project: `brew install neovim --HEAD`.
* **Homebrew:** I *homebrew* both in macOS and in the servers I use. So the 
reproduction of the configuration should be easy.
* **Dotfiles:** This is very related with my other project fictional-couscous.
I just split the two projects in two different repos so I can test different
neovim configurations easier.
