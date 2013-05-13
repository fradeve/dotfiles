__kupfer_name__ = _("Hamster tracker")
__kupfer_actions__ = ("AddActivity", )
__description__ = _("Quick add/stop activity to Hamster\nUsage: just open Kupfer and write\n\nactivity@category#tag1#tag2!description")
__version__ = "0.1"
__author__ = "Francesco de Virgilio <fradeve@inventati.org>"

from kupfer.objects import Action, TextLeaf
from kupfer import utils
import re, os, string


class AddActivity (Action):
    def __init__(self):
        Action.__init__(self, _("Add Hamster activity"))

    def has_result(self):
        return True

    def activate(self, leaf):
        argv = ['hamster start ', '"', ', ', '"']
        fragments = re.split('(\W)', leaf.object)
        i = 0
        for item in fragments[1:]:
            i = i + 1
            if str(item) == '@':
                argv.insert(2, (str(item) + fragments[i+1]))
            elif str(item) == '#':
                argv.insert(4, (str(item) + fragments[i+1] + ','))
            elif str(item) == '!':
                actdesc = (fragments[i+1] + ' ')
                argv.insert(4, actdesc)
            else:
                pass
        argv.insert(2, fragments[0])

        print string.join(argv, '')
        os.system(string.join(argv, ''))

    def item_types(self):
        yield TextLeaf

    def get_description(self):
        return __description__

    def get_icon_name(self):
        return "hamster-time-tracker"
