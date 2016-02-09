# -*- coding: utf-8 -*-
#!/usr/bin/python

import tmuxp

server = tmuxp.Server()
session = server.list_sessions()[0]
window = session.list_windows()[1]

commands = {
    0: 'task project:side agile:todo',
    1: 'task project:side agile:pro',
    2: 'task project:side agile:done',
    3: 'task project:side agile:dep'
}

for k, v in commands.iteritems():
    pane = window.select_pane(k)
    pane.send_keys('clear && {0}'.format(v))
