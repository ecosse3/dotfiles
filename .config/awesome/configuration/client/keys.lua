local awful = require('awful')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
require('awful.autofocus')
local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key

local client_keys = awful.util.table.join(
  -- MOD+F - Toggle fullscreen
	awful.key(
		{modkey},
		'f',
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = 'toggle fullscreen', group = 'client'}
	),
  -- MOD+Q - Quit
	awful.key(
		{modkey},
		'q',
		function(c)
			c:kill()
		end,
		{description = 'close', group = 'client'}
	),
  -- MOD+D - Focus right
	awful.key(
		{modkey},
		'd',
		function()
			awful.client.focus.byidx(1)
		end,
		{description = 'focus next by index', group = 'client'}
	),
  -- MOD+A - Focus left
	awful.key(
		{modkey},
		'a',
		function()
			awful.client.focus.byidx(-1)
		end,
		{description = 'focus previous by index', group = 'client'}
	),
  -- MOD+SHIFT+D - Move client to right
	awful.key(
		{ modkey, 'Shift'  },
		'd',
		function ()
			awful.client.swap.byidx(1)
		end,
		{description = 'swap with next client by index', group = 'client'}
	),
  -- MOD+SHIFT+A - Move client to left
	awful.key(
		{ modkey, 'Shift' },
		'a',
		function ()
			awful.client.swap.byidx(-1)
		end,
		{description = 'swap with next client by index', group = 'client'}
	),
  -- MOD+U - Jump to urgent client
	awful.key(
		{modkey},
		'u',
		awful.client.urgent.jumpto,
		{description = 'jump to urgent client', group = 'client'}
	),
  -- MOD+TAB - Go back
	awful.key(
		{modkey},
		'Tab',
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = 'go back', group = 'client'}
	),
  -- MOD+N - Minimize client
  awful.key(
    {modkey},
    'n',
    function(c)
      c.minimized = true
    end,
    {description = 'minimize client', group = 'client'}
  ),
  -- MOD+Shift+C - Center client
	awful.key(
		{ modkey, 'Shift' },
		'c',
		function(c)
			local focused = awful.screen.focused()

			awful.placement.centered(c, {
				honor_workarea = true
			})
		end,
		{description = 'align a client to the center of the focused screen', group = 'client'}
	),
  -- MOD+C - Toggle floating
	awful.key(
		{modkey},
		'c',
		function(c)
			c.fullscreen = false
			c.maximized = false
			c.floating = not c.floating
			c:raise()
		end,
		{description = 'toggle floating', group = 'client'}
	),
  -- MOD+Up - Move up by 20px
	awful.key(
		{modkey},
		'Up',
		function(c)
			c:relative_move(0, dpi(-20), 0, 0)
		end,
		{description = 'move floating client up by 20 px', group = 'client'}
	),
  -- MOD+Down - Move down by 20px
	awful.key(
		{modkey},
		'Down',
		function(c)
			c:relative_move(0, dpi(20), 0, 0)
		end,
		{description = 'move floating client down by 20 px', group = 'client'}
	),
  -- MOD+Left - Move left by 20px
	awful.key(
		{modkey},
		'Left',
		function(c)
			c:relative_move(dpi(-20), 0, 0, 0)
		end,
		{description = 'move floating client to the left by 20 px', group = 'client'}
	),
  -- MOD+Right - Move right by 20px
	awful.key(
		{modkey},
		'Right',
		function(c)
			c:relative_move(dpi(20), 0, 0, 0)
		end,
		{description = 'move floating client to the right by 20 px', group = 'client'}
	),
  -- MOD+Shift+Up - Increase vertically up by 20px
	awful.key(
		{modkey, 'Shift'},
		'Up',
		function(c)
			c:relative_move(0, dpi(-20), 0, dpi(20))
		end,
		{description = 'increase floating client size vertically by 10 px up', group = 'client'}
	),
  -- MOD+Shift+Down - Increase vertically down by 20px
	awful.key(
		{modkey, 'Shift'},
		'Down',
		function(c)
			c:relative_move(0, 0, 0, dpi(20))
		end,
		{description = 'increase floating client size vertically by 10 px down', group = 'client'}
	),
  -- MOD+Shift+Left - Increase horizontally left by 20px
	awful.key(
		{modkey, 'Shift'},
		'Left',
		function(c)
			c:relative_move(dpi(-20), 0, dpi(20), 0)
		end,
		{description = 'increase floating client size horizontally by 20 px left', group = 'client'}
	),
  -- MOD+Shift+Right - Increase horizontally right by 20px
	awful.key(
		{modkey, 'Shift'},
		'Right',
		function(c)
			c:relative_move(0, 0, dpi(20), 0)
		end,
		{description = 'increase floating client size horizontally by 20 px right', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Up',
		function(c)
			if c.height > 10 then
				c:relative_move(0, 0, 0, dpi(-20))
			end
		end,
		{description = 'decrease floating client size vertically by 20 px up', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Down',
		function(c)
			local c_height = c.height
			c:relative_move(0, 0, 0, dpi(-20))
			if c.height ~= c_height and c.height > 20 then
				c:relative_move(0, dpi(20), 0, 0)
			end
		end,
		{description = 'decrease floating client size vertically by 20 px down', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Left',
		function(c)
			if c.width > 20 then
				c:relative_move(0, 0, dpi(-20), 0)
			end
		end,
		{description = 'decrease floating client size horizontally by 20 px left', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Right',
		function(c)
			local c_width = c.width
			c:relative_move(0, 0, dpi(-20), 0)
			if c.width ~= c_width and c.width > 20 then
				c:relative_move(dpi(20), 0 , 0, 0)
			end
		end,
		{description = 'decrease floating client size horizontally by 20 px right', group = 'client'}
	)
)

return client_keys
