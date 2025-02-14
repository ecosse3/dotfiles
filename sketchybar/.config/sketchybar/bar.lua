local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 40,
  corner_radius = 12,
  -- notch_display_height = 33,
  margin = 12,
  y_offset = 8,
  color = colors.with_alpha(colors.bar.bg, colors.transparency),
  blur_radius = 20,
  padding_right = 5,
  padding_left = 5,
})
