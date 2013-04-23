from fabric.api import *
from string import Template
import getpass, fileinput, sys

# colors

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

def disable(self):
    self.HEADER = ''
    self.OKBLUE = ''
    self.OKGREEN = ''
    self.WARNING = ''
    self.FAIL = ''
    self.ENDC = ''

# rc files template

files = { 'vagrantfile' : 
            {
                'name'      :   'Vagrantfile',
                'location'  :   '',
                'content'   :   ('# -*- mode: ruby -*-\n' +
                                '# vi: set ft=ruby :\n\n' +
                                'Vagrant.configure("2") do |config|\n' +
                                'config.vm.box = "$boxname"\n' +
                                'config.vm.network :forwarded_port, guest: 80, host: 4567\n' +
                                'config.ssh.username = "vagrant"\n' +
                                'config.vm.synced_folder "$hostfolder", "$clientfolder", :owner => "$owner", :group => "www-data"\n' +
                                'config.vm.synced_folder "/home/fradeve/.dotfiles", "/home/vagrant/.dotfiles"\n' +
                                'end')
            },
          'readme'      :
            {
                'name'      :   'README.md',
                'location'  :   '',
                'content'   :   ('$projectname\n')
            },
          'gitignore'   :
            {
                'name'      :   '.gitignore',
                'location'  :   '',
                'content'   :   ('*_test*\n' +
                                '.vagrant*\n' +
                                '*.pyc')
            },
        }

optional = { 'tmuxwindow':  ('# Set window root path. Default is `$session_root`.\n' +
                            '# Must be called before `new_window`.\n' +
                            'window_root "$winroot"\n\n' +
                            '#new_window "foo"\n\n' +
                            'select_window "$projname"\n\n' +
                            '# Split window into panes.\n' +
                            'split_h 40\n\n' +
                            '# Run commands.\n' +
                            'run_cmd "$secondpane"  #   second pane\n' +
                            'run_cmd "$firstpane"     1   # first pane\n\n' +
                            '# Paste text\n' +
                            '#send_keys "top"    # paste into active pane\n' +
                            '#send_keys "tmuxifier load-window geolog" 1 # paste into active pane\n\n' +
                            '# Set active pane.\n' +
                            '#select_pane 0')
            }

createdfiles = []

# projects setup script

def setup(prjname):

    # create project directory
    prjdir = raw_input(bcolors.HEADER + "Please select project folder [/home/" + getpass.getuser() + "/git/" + prjname + "]:\t")
    prjdir = prjdir or ('/home/' + getpass.getuser() + '/git/' + prjname)
    local('mkdir %s' % (prjdir))

    print bcolors.HEADER + '\nPlease select which files to you want to setup.'

    for file in files:
        filename = files[file]['name']
        fileloc = prjdir + '/' + files[file]['location'] + '/' + filename
        filecont = files[file]['content']
        userchoice = raw_input(bcolors.HEADER + '\n%s [Y/n]: \t' %fileloc)
        userchoice = userchoice or 'y'

        if userchoice == 'y':
            f = open("%s" %fileloc, "w")
            f.write(filecont)
            f.close()
            print (bcolors.OKGREEN + "\__added %s" %fileloc)
            createdfiles.append([filename, fileloc])
        else:
            continue

    # create project tmux window file
    userchoice = raw_input(bcolors.HEADER + '\nDo you want to setup a Tmuxifier window? [Y/n]: \t')
    userchoice = userchoice or 'y'

    if userchoice == 'y':
        createtmux(prjname)
    else:
        return

    toconfvars = checkvars(createdfiles)

    if toconfvars > 0:
        print (bcolors.HEADER + '\nIt seems you have ' + str(toconfvars) + ' unconfigured variables for this project.')
        userchoice = raw_input('\nDo you want to configure them now? [Y/n]: \t')
        userchoice = userchoice or 'y'
        if userchoice == 'y':
            configurevars(createdfiles)
        else:
            return
    else:
        return


def createtmux(tmuxname):
    desttemplateloc = '/home/' + getpass.getuser() + '/.tmuxifier/' + tmuxname + '.window.sh'
    filecont = optional['tmuxwindow']
    f = open("%s" %desttemplateloc, "w")
    f.write(filecont)
    f.close()
    print (bcolors.OKGREEN + "added %s" %desttemplateloc)
    createdfiles.append(['tmuxwindow', desttemplateloc])

def checkvars(rcfiles):
    varcount = 0
    for file in rcfiles:
        with open("%s" %file[1], "r") as f:
            for line in f:
                for word in line.split('"'):
                    if word.startswith('$'):
                        varcount = varcount +1
                        createdfiles[createdfiles.index(file)].append(word)
        f.close()
    return varcount

def configurevars(rcfiles):
    valsdict = {}
    for item in rcfiles:
        for key in item[2:]:
            userdefvar = raw_input(bcolors.OKBLUE + '\n[%s]\t%s: ' %(item[0], key))
            valsdict[key]=userdefvar
        for line in fileinput.input(item[1], inplace = 1):
            for key in valsdict:
                line = line.replace(key, valsdict[key])
            sys.stdout.write(line)

## raw operations

def uname():
    run('uname -a')

def commit():
    local("./manage.py test my_app")
    local("git add -p && git commit")
    local("git push")

# loader

def load(projname):
    local('tmux rename-window %s && tmuxifier load-window %s' % (projname, projname))

# http://docs.fabfile.org/en/1.6/tutorial.html
