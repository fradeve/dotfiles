# -*- coding: utf-8 -*-
#!/usr/bin/python

import tmuxp

server = tmuxp.Server()
session = server.list_sessions()[0]
window = session.list_windows()[1]

commands = [
    'task project:side agile:todo',
    'task project:side agile:pro',
    'task project:side agile:done',
    'task project:side agile:dep'
]

complete_commands = dict(zip(panes_id, commands))

for k, v in complete_commands.iteritems():
    pane = window.panes[k].select_pane()
    pane.send_keys('clear && {0}'.format(v))

