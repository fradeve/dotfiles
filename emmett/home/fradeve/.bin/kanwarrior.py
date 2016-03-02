# -*- coding: utf-8 -*-
#!/usr/bin/python

import tmuxp

server = tmuxp.Server()
session = server.list_sessions()[0]
window = session.list_windows()[1]
panes = window.panes

commands = [
    'task project:side agile:todo',
    'task project:side agile:pro',
    'task project:side agile:done',
    'task project:side agile:dep'
]

# panes_id = [
#     int(id=pane._pane_id.encode('utf-8').strip('%'))
#     for pane in window.list_panes()
# ]

for i, command in enumerate(commands):
    pane = window.panes[i].select_pane()
    pane.send_keys('clear && {0}'.format(command))

