local sbar = require("sketchybar")
local colors = require("colors")
local icons = require("icons")

local M = {}
M.popup_items = {}

-- Helper function to split a string
local function split_string(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

-- Helper function to trim whitespace from a string
local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

-- Define the Event class
local Event = {}
Event.__index = Event

function Event:new(title, diff, ongoing, time, url)
  local title_cut = trim(title:sub(1, 100))
  -- Format the time difference in a more readable format
  local hours = math.floor(math.abs(diff) / 3600)
  local minutes = math.floor((math.abs(diff) % 3600) / 60)
  local human_diff
  if hours > 0 then
    human_diff = string.format("%dh%02dm", hours, minutes)
  else
    human_diff = string.format("%dm", minutes)
  end

  local human_str
  if ongoing then
    human_str = title_cut .. " " .. human_diff .. " left"
  else
    human_str = title_cut .. " in " .. human_diff
  end

  return setmetatable({
    title = title,
    title_cut = title_cut,
    diff = diff,
    human_diff = human_diff,
    ongoing = ongoing,
    time = time,
    url = url,
    human_str = human_str
  }, self)
end

function Event:__tostring()
  return string.format("Event(title: %s, diff: %s, ongoing: %s, time: %s, url: %s)", self.title, self.diff,
    tostring(self.ongoing), self.time, self.url)
end

-- Function to parse datetime string
local function parse_datetime(dt_str, base_date)
  if not dt_str then return nil end
  -- Remove "at " from the string if present
  dt_str = dt_str:gsub("at ", "")
  -- Try full date pattern first
  local day, month, year, hour, min = dt_str:match("(%d+)%s+(%a+)%s+(%d+)%s+(%d+):(%d+)")

  -- If not matched, try time-only pattern
  if not day then
    hour, min = dt_str:match("(%d+):(%d+)")
    if hour and min and base_date then
      -- Use the date components from base_date
      local base_time = os.date("*t", base_date)
      return os.time {
        year = base_time.year,
        month = base_time.month,
        day = base_time.day,
        hour = tonumber(hour),
        min = tonumber(min)
      }
    end
  else
    -- Month name to number mapping
    local month_numbers = {
      Jan = 1,
      Feb = 2,
      Mar = 3,
      Apr = 4,
      May = 5,
      Jun = 6,
      Jul = 7,
      Aug = 8,
      Sep = 9,
      Oct = 10,
      Nov = 11,
      Dec = 12
    }

    local month_num = month_numbers[month]
    if month_num then
      return os.time {
        year = tonumber(year),
        month = month_num,
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min)
      }
    end
  end

  return nil
end

-- Function to get events using icalBuddy
local function get_events(callback)
  local now = os.time()

  local cmd = "icalBuddy -n -nc -nrd -npn -ea -ps '/|/' -nnr '' -b '' -ab '' -iep 'title,notes,datetime' eventsToday+1"
  sbar.exec(cmd, function(output)
    local trimmed_output = trim(output)
    local lines = split_string(trimmed_output, "\n")

    local events = {}

    if #lines == 0 then
      callback(events)
      return
    end

    for _, line in ipairs(lines) do
      local splat = split_string(line, "|")
      if #splat < 2 then
        goto continue
      end

      local title = trim(splat[1])
      local timerange = trim(splat[#splat])
      -- Split the timerange into start and end times
      local start_str, end_str = timerange:match("(.+)%s+%-%s+(.+)")

      -- Parse start and end times
      local starttime = parse_datetime(start_str)
      local endtime = parse_datetime(end_str, starttime)

      if not starttime or not endtime then
        goto continue
      end

      local ongoing = now >= starttime and now <= endtime
      local diff
      if ongoing then
        diff = os.difftime(endtime, now)
      else
        diff = os.difftime(starttime, now)
      end

      -- Format the time difference in a human-readable format
      local hours = math.floor(diff / 3600)
      local minutes = math.floor((diff % 3600) / 60)
      local human_diff = string.format("%d:%02d", hours, minutes)

      local time = timerange
      local url = nil

      -- Extract URL if present
      -- if #splat > 2 then
      --   local urls = {}
      --   for url_match in string.gmatch(splat[2], url_pattern) do
      --     table.insert(urls, url_match)
      --   end
      --   url = urls[1] or nil
      --   if url and url:find("meet") then
      --     url = url .. "?authuser=l.kurpiewski@codeandpepper.com"
      --   end
      -- end

      table.insert(events, Event:new(title, diff, ongoing, time, url))
      ::continue::
    end

    -- Sort events by start time
    table.sort(events, function(a, b)
      if a.ongoing and not b.ongoing then
        return true
      elseif not a.ongoing and b.ongoing then
        return false
      else
        return a.diff < b.diff
      end
    end)

    callback(events)
  end)
end

-- Function to generate main text for the events
local function generate_main_text(events)
  local next_event_text = (#events > 1 and events[1].ongoing) and " 􀄧 " .. (events[2].human_str or "") or ""
  return (events[1].human_str or "") .. next_event_text
end

-- Create the item (only one definition)
M.upcoming = sbar.add("item", "upcoming", {
  position = "right",
  drawing = true,
  update_freq = 5,
  icon = {
    string = "􀧞",
    font = {
      family = "SF Pro",
      style = "Bold",
      size = 14.0,
    },
    color = colors.white,
    padding_right = 6,
    drawing = true,
  },
  label = {
    string = "Loading...",
    font = {
      family = "SF Pro",
      style = "Regular",
      size = 13.0,
    },
    color = colors.white,
    padding_right = 10,
    drawing = true,
  },
  updates = true,
  popup = {
    drawing = false,
    height = 26,
    align = "center",
    y_offset = 5,
    background = {
      corner_radius = 9,
      color = colors.with_alpha(colors.popup.bg, colors.transparency),
      border_width = 1,
      border_color = colors.popup.border,
    }
  }
})

local popup_visible = false

M.upcoming:subscribe("mouse.clicked", function(env)
  popup_visible = not popup_visible

  -- Toggle popup visibility
  M.upcoming:set({ popup = { drawing = popup_visible } })

  if popup_visible then
    get_events(function(events)
      -- Remove existing popup items if any
      for _, item in ipairs(M.popup_items) do
        if item then
          item:remove()
        end
      end
      M.popup_items = {}

      -- Create popup items for each event
      for i, event in ipairs(events) do
        local item = sbar.add("item", {
          position = "popup." .. M.upcoming.name,
          width = 300,
          icon = {
            string = event.time,
            align = "left",
            font = {
              family = "SF Pro",
              style = "Regular",
              size = 14.0,
            },
            color = colors.white,
            padding_left = 10,
          },
          label = {
            string = event.title_cut,
            align = "left",
            font = {
              family = "SF Pro",
              style = "Regular",
              size = 14.0,
            },
            color = event.ongoing and colors.green or colors.white,
            padding_left = 5,
          },
          background = {
            height = 24,
            color = event.ongoing and colors.bg2 or colors.transparent,
            border_width = 0,
          }
        })
        table.insert(M.popup_items, item)
      end

      if #events == 0 then
        local item = sbar.add("item", {
          position = "popup." .. M.upcoming.name,
          width = 300,
          label = {
            string = "No events today",
            align = "center",
            font = {
              family = "SF Pro",
              style = "Regular",
              size = 12.0,
            },
            color = colors.white,
          }
        })
        table.insert(M.popup_items, item)
      end
    end)
  else
    -- Clean up popup items when closing
    for _, item in ipairs(M.popup_items) do
      if item then
        item:remove()
      end
    end
    M.popup_items = {}
  end
end)

-- Subscribe to events
M.upcoming:subscribe({ "routine", "forced", "system_woke" }, function()
  get_events(function(events)
    if #events == 0 then
      M.upcoming:set({
        drawing = true,
        label = { string = "No events" }
      })
    else
      local main_text = generate_main_text(events)
      M.upcoming:set({
        label = { string = main_text },
        drawing = true
      })
    end
  end)
end)

-- Trigger an immediate update
sbar.trigger("forced")

return M
