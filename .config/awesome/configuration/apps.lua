local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'

return {
	-- The default applications that we will use in keybindings and widgets
	default = {
		-- Default web browser
		web_browser = 'google-chrome-stable',
		-- Default terminal emulator
		terminal = 'kitty',
		-- Default text editor
		text_editor = 'nvim',
		-- Default file manager
		file_manager = 'dolphin',
		-- Default media player
		multimedia = 'vlc',
		-- Default game, can be a launcher like steam
		game = 'supertuxkart',
		-- Default graphics editor
		graphics = 'gimp-2.10',
		-- Default sandbox
		sandbox = 'virtualbox',
		-- Default IDE
		development = '',
		-- Default network manager
		network_manager = 'kitty iwctl',
		-- Default bluetooth manager
		bluetooth_manager = 'blueman-manager',
		-- Default power manager
		power_manager = 'xfce4-power-manager',
		-- Default GUI package manager
		package_manager = 'pamac-manager',
		-- Default locker
		lock = 'awesome-client "awesome.emit_signal(\'module::lockscreen_show\')"',
		-- Default quake terminal
		quake = 'kitty --name QuakeTerminal',
		-- Default rofi global menu
		rofi_global = 'rofi -dpi ' .. screen.primary.dpi ..
							' -show "Global Search" -modi "Global Search":' .. config_dir ..
							'/configuration/rofi/global/rofi-spotlight.sh' ..
							' -theme ' .. config_dir ..
							'/configuration/rofi/global/rofi.rasi',
		-- Default app menu
		rofi_appmenu = 'rofi -dpi ' .. screen.primary.dpi ..
							' -show drun -theme ' .. config_dir ..
							'/configuration/rofi/appmenu/rofi.rasi',

    -- Rofi
    rofi_pass = 'rofi-pass',
    rofi_clipboard = 'rofi -modi "clipboard:greenclip print" -show clipboard ' ..
              "-dpi " .. screen.primary.dpi ..
							"-run-command '{cmd}' -theme " ..
              config_dir .. "/configuration/rofi/global/search.rasi",
    rofi_emoji = 'rofi -show emoji -modi emoji ' ..
              '-dpi ' .. screen.primary.dpi .. ' ' ..
              '-theme ' .. config_dir .. '/configuration/rofi/global/search.rasi',
    -- Colorpick any color from screen
    colorpicker = 'farge --notify --expire-time 5000',
	},

	-- List of apps to start once on start-up
  -- Autostart
	run_on_start_up = {
    -- Screen setup
    'xrandr --output DP-1 --mode 3440x1440 --rate 60 --dpi 110 --primary --output DP-0 --mode 1920x1080 --rate 60 --dpi 100 --left-of DP-1',
    'setxkbmap -layout pl -option caps:escape -option altwin:swap_lalt_lwin',
    -- Mouse
    'xinput set-prop "MX Master 2S Mouse" "Coordinate Transformation Matrix" 2.400000, 0.000000, 0.000000, 0.000000, 2.400000, 0.000000, 0.000000, 0.000000, 1.000000',
    -- Keyboard
    'xset r rate 200 90',
		-- Compositor
		'picom -b --experimental-backends --dbus --config ' ..
		config_dir .. '/configuration/picom.conf',
		-- Blueman applet
		'blueman-applet',
		-- Music server
		'mpd',
    -- Clipboard daemon
    'greenclip daemon',
		-- Polkit and keyring
		'/usr/bin/lxqt-policykit-agent &' ..
		' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',
		-- Load X colors
		'xrdb $HOME/.Xresources',
		-- Audio equalizer
		'pulseeffects --gapplication-service',
		-- Lockscreen timer
		[[
		xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
		"awesome-client 'awesome.emit_signal(\"module::lockscreen_show\")'" ""
		]],
	},

	-- List of binaries/shell scripts that will execute for a certain task
	utils = {
		-- Fullscreen screenshot
		full_screenshot = 'flameshot screen -c',
		-- Area screenshot
		area_screenshot = 'flameshot gui',
		-- Update profile picture
		update_profile  = utils_dir .. 'profile-image'
	}
}
