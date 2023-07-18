#!/usr/bin/env python3

import os, subprocess, re, datetime

class Event:
  def __init__(self, title, diff, ongoing, time, url):
      self.title = title
      self.title_cut = self.title[:100].strip()
      self.diff = diff
      self.human_diff = ':'.join(str(self.diff).split(':')[:-1])
      self.ongoing = ongoing
      self.time = time
      self.url = url
      if self.ongoing:
          self.human_str = f"{self.title_cut} {self.human_diff} left"
      else:
          self.human_str = f"{self.title_cut} in {self.human_diff}"

  def __repr__(self):
      return f"Event(title: {self.title}, diff: {self.diff}, ongoing: {self.ongoing}, time: {self.time}, url: {self.url})"

def get_events():
  datetime_format = '%d %b %Y %H:%M'
  now = datetime.datetime.now()
  url_pattern = r'\b((?:https?://)?(?:(?:www\.)?(?:[\da-z\.-]+)\.(?:[a-z]{2,6})|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])))(?::[0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])?(?:/[\w\.-]*)*/?)\b'

  cmd = "icalBuddy -n -nc -nrd -npn -ea -ps '/|/' -nnr '' -b '' -ab '' -iep 'title,notes,datetime' eventsToday+1"
  output = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
  lines = output.decode('utf-8').strip().split('\n')

  events = []
  if lines == ['']: return events

  for line in lines:
      splat = line.split('|')
      title = splat[0]

      urls = re.findall(url_pattern, splat[1])
      url = (urls + [None])[0]
      if url is not None and 'meet' in url: url += '?authuser=l.kurpiewski@codeandpepper.com'

      timerange = splat[-1].replace('at ', '')
      starttime, endtime = timerange.split(' - ')
      endtime = datetime.datetime.strptime(starttime[:-5] + endtime, datetime_format)
      starttime = datetime.datetime.strptime(starttime, datetime_format)

      ongoing = starttime <= now <= endtime
      if ongoing:
          diff = endtime-now
      else:
          diff = starttime-now

      time = ' '.join(timerange.split()[3:])

      events.append(Event(title, diff, ongoing, time, url))
  return events

def generate_main_text(events):
  next_event_text = ' 􀄧 ' + events[1].human_str if (len(events) > 1 and events[0].ongoing) else ''
  return events[0].human_str + next_event_text

def plugin_undraw():
  args = [
      '--set upcoming drawing=off',
      # '--set "seperator_upcoming" drawing=off',
  ]
  os.system('sketchybar -m ' + ' '.join(args))

def plugin_draw(main_text, popup_items):
  args = [
      f'--set upcoming label="{main_text}"',
      '--set upcoming drawing=on',
      '--set "seperator_upcoming" drawing=on',
  ]

  for i,item in enumerate(popup_items):
      args += [
          f'--add item upcoming.{i} popup.upcoming',
          f'--set upcoming.{i} background.padding_left=10',
          f'--set upcoming.{i} background.padding_right=10',
          f'--set upcoming.{i} label="{item["text"]}"',
          f'--set upcoming.{i} click_script="open {item["url"]} ; sketchybar -m --set upcoming popup.drawing=off"'
      ]

  print(args)
  os.system('sketchybar -m ' + ' '.join(args))

if __name__ == '__main__':
  events = get_events()
  if len(events) == 0:
      # plugin_undraw()
      main_text = 'No events today'
      plugin_draw(main_text, ({}))
  else:
      main_text = generate_main_text(events)
      plugin_draw(main_text, ({'text': e.human_str, 'url': e.url} for e in events))
