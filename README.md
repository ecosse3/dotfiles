# dotfiles
## Screenshots
![](./screenshot.png)

## Some details
+ **OS**: Manjaro
+ **WM**: i3-gaps
+ **Shell**: oh-my-zsh
+ **Terminal**: Kitty
+ **File Manager**: Nautilus for GUI, Ranger for terminal
+ **Launcher**: Rofi
+ **Editor**: VS Code
+ **Browser**: Google Chrome (from snap)
+ **Theme**: Ant-Dracula
+ **Icons**: Numix-Circle-Arc
+ **Terminal Font**: Fira Code

## Dependencies
Here is a complete list of dependencies needed for making these themes work.
If you install all of them you will have a (mostly) smooth out of the box experience.
Also if you are willing to edit a few configuration files, **which you will have to do** at some point, most of these dependencies can be replaced. For example you can replace `rofi` with `dmenu`,`maim` with `scrot`.

If you notice that something is missing, please contact me.
Almost all dependencies you can download from `yaourt`.

| Dependency | Description | Why/Where is it needed? |
| --- | --- | --- |
| `i3-gaps` | Window manager | (explains itself) |
| `polybar` | Status bar | (explains itself) |
| `rofi` | Window switcher, application launcher and dmenu replacement | (explains itself) |
| `compton` | X Compositor | Makes transparency to windows |
| `lm_sensors` | CPU temperature sensor | CPU temperature widgets |
| `pulseaudio`, `libpulse` | Sound system **(Installed by default on most distros)** | Volume widgets and keybinds |
| `mpd` | Server-side application for playing music | Music widgets |
| `mpc` | Minimalist command line interface to MPD | Music widgets |
| `maim` | Takes screenshots (improved `scrot`) | Screenshot keybinds |
| [i3lock-fancy-multimonitor](https://github.com/guimeira/i3lock-fancy-multimonitor) | Fancy i3lock | (explains itself) |
| `scrot` | Takes screenshots | We need it for lockscreen |
| `i3-lock` | Locks screen | We need it for lockscreen |
| `feh` | Image viewer and wallpaper setter | Screenshot previews, wallpapers |
| `dunst` | Notification daemon | (explains itself) |
| `xautolock` | An automatic X screen-locker | (explains itself) |

### Fonts
##### Icon fonts
+ **Font Awesome 5**
+ **NotoEmoji Nerd**
##### Monospace
+ **Fira Code**
+ **DejaVu Sans Mono**
##### Sans
+ **Google Sans**
+ **Roboto Condensed**
+ **Noto Sans**

## Things to do after you set up dependencies

+ Backup your current i3 setup
+ Copy my dotfiles

+ Install i3lock-fancy-multimonitor:
```
git clone https://github.com/guimeira/i3lock-fancy-multimonitor.git
cp -r i3lock-fancy-multimonitor ~/.scripts
chmod +x ~/.scripts/i3lock-fancy-multimonitor/lock
```

+ Copy `weather` from `.scripts` dir to `/usr/bin/weather`.

```
cp -r ~/.scripts/weather /usr/bin/weather
chmod +x /usr/bin/weather
```

+ Install `oh-my-zsh` additional plugins:

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
source ~/.zshrc
```

## Some recommended applications
+ **Terminals**: Kitty / urxvt / st
+ **File managers**: Nautilus / Thunar
+ **Launchers**: Rofi / dmenu
+ **Browsers**: Google Chrome / Firefox (with Vimium extension)
+ **Editors**: VSCode / Vim / Atom
+ **Music players**: mpd (with ncmpcpp)

### Eye-candy suggestions
- `neofetch` - Display a ton of system info
- [even-better-ls](https://github.com/illinoisjackson/even-better-ls) - Icons for the `ls` command
- `cava` - Audio visualizer
- `lolcat` - For rainbow effect (ex. usage `neofetch|lolcat`)

## Basic keybinds

I use `super` AKA Windows key as my main modifier.

#### i3
+ `super + [1-0]` - Change workspace
+ `super + shift + [1-0]` - Move focused window to workspace
+ `super + [arrow keys] / [hjkl]` - Change focus by direction
+ `super + shift + [arrow keys] / [hjkl]` - Move client by direction
+ `super + q` - Kill window
+ `super + shift + s` - Screenshot
+ `super + ctrl + l` - Lock screen
+ `super + shift + minus` - Make the currently focused window a scratchpad
+ `super + minus` - Show scratchpad

#### exec apps
+ `super + enter` - Spawn terminal
+ `super + shift + enter` - Spawn google-chrome window
+ `super + m` - Open nautilus (file manager)
+ `super + d` - Launch rofi
+ `super + c` - Open calculator (rofi)

#### layout
+ `super + shift + space` - Toggle floating client
+ `super + r` - Resize mode
+ `super + f` - Toggle fullscreen
+ `super + h` - Split in horizontal orientation
+ `super + v` - Split in vertical orientation
+ `super + s` - Stacking layout
+ `super + w` - Tabbed layout
+ `super + e` - Split layout

+ ... And many many more.