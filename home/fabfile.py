# Copyright (c) 2013 Francesco de Virgilio <fradeve at inventati dot org>
# All rights reserved.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# CREDITS
#########
# this file is based almost totally on `fabfile.py` from Alexey Bezhan
#   https://github.com/allait/allait.github.com/blob/master/static/code/fabfile.py
#
# environments structure    https://gist.github.com/pix0r/2002643#file-fabfile-py

# HOWTO
#######
#
# Install
# -------
#
# This file requires a Python YAML interpreter installed on the system; in
# ArchLinux this is sufficient
#
#       yaourt -S python2-yaml
#
# Define config
# -------------
#
# In the `CONFIG` section you could define standard directories
# for VIM rc files, Tmuxinator, project dir, ecc.
#
# Setting up a project  
# --------------------
#
#       fab setup:projectname
#
# will ask for:
# - root project dir
# - creation of files defined in `files` template (default: `Vagrantfile`,
#   `README.md`, `.gitignore`, `projectname.window.sh`, `.vimrc`, `server_config.yaml`)
# - filling variables in such scripts
#
# All files are self-explaining; `server_config.yaml` contains per-project settings
# of servers. You can deploy the current project using something like
#
#       fab s:servername deploy
# 
# Launching commands within a project
# -----------------------------------
#
#       fab s:vagrant command
#
# `fab e` command is used to select an environment. 
# At every launch, this fabfile walks on the following path:
# 
# 1. search for a Vagrantfile in the current (project)dir
# 2. if Vagrantfile exists, the script automagically adds settings to manage
#    the Vagrant WM, searching them in Vagrant config files
# 3. after, it tries to import the previously generated `server_settings.yaml`
#    which contains settings to connect to external servers.
#
# More functions
# --------------
#
# per-server commands       in `server_config.yaml` a `postcmd` field is defined: inside
#                           this, every nested `cmd` field can bring a command. When calling
#       `_postcmd` function, all commands in `postcmd` will be executed subsequently, 
#       allowing to define a custom sequence of commands and keeping a custom function as
#       server-agnostic as possible. Sudo is automagically wrapped in Fabric's `sudo()`
#
#       ## `server_config.yaml`
#       server1:
#           host    :   "myip"
#           user    :   "duck"
#           password:   "duck"
#           postcmd :
#               cmd :   "sudo chmod a+x public_html/project1/proxy.cgi"
#
#       ## `fabfile.py`
#       def rsync():
#           rsync_project(
#                   remote_dir=env.deploydir,
#                   exclude=("server_config.yaml", ".gitignore", "*.pyc")
#           )
#           _postcmd()
#
#       ## giving `fab s:server1 rsync` we get:
#       1 - syncing local project folder with `duck@myip:deploydir` defined in
#           `server_config.yaml`
#       2 - after rsync, che `sudo chown ...` command is executed
# 
#
# deployed dir auto-chown   If both `deployuser` and `deploygroup` are set `in server_config`,
#                           the `_chowndeploy` command auto-chown the deployed dir on the
#                           server with user and group defined.
#
# Examples
# --------
#
#   def ciao():
#       local('echo "ciao"')
#
#   def uname():
#       run('uname -a')
# 
# having /home/git
#        |
#        |-- project1
#        |          |-- js
#        |          |-- css
#        |          |-- html
#        |          \-- server_config.yaml --> server1
#        |
#        \-- project2
#                   |-- html
#                   |-- Vagrantfile
#                   \-- server_config.yaml --> server2a, server2b
#
# run command on localhost
#       cd ~
#       fab ciao
#
# run command on server1
#       cd ~/git/project1
#       fab s:server1 uname
#
# run command on server2a
#       cd ~/git/project2
#       fab s:server2a uname
#
# run local command while in project dir
#       cd ~/git/project2
#       fab ciao
# run same command on multiple servers
#       cd ~/git/project2
#       fab s:server2a,server2b,vagrant uname
#
# If you need additional configuration, setup ~/.fabricrc file:
#       user = your_remote_server_username
#
# To get specific command help type:
#       fab -d command_name

import getpass, fileinput, sys, os
from os import walk as _walk, getcwd

from fabric.api import *
from fabric.utils import puts
from fabric import colors
import fabric.network
import fabric.state
from fabric.contrib.project import rsync_project


YAML_AVAILABLE = True
try:
    import yaml
except ImportError:
    YAML_AVAILABLE = False


JSON_AVAILABLE = True
try:
    import simplejson as json
except ImportError:
    try:
        import json
    except ImportError:
        JSON_AVAILABLE = False

sys.path.append(os.getcwd())
try:
    with open('Vagrantfile'):
        vaghost = local('vagrant ssh-config | grep HostName', capture=True).split()[1]
        vagport = local('vagrant ssh-config | grep Port', capture=True).split()[1]
        vagkey = local('vagrant ssh-config | grep IdentityFile', capture=True).split()[1].strip('"')
        vagenv = {"vagrant": {
                    "host"      :   vaghost,
                    "port"      :   vagport,
                    "user"      :   "vagrant",
                    "password"  :   "vagrant",
                    "key_filename"  :   vagkey
                    }
                 }
except IOError:
    print 'No Vagrantfile found'

################################
#         CONFIG               #
################################

# the directory where Tmuxinator handles layout files
TMUXIFIER = '/home/' + getpass.getuser() + '/.tmuxifier/'
# where VIM stores rc files for projects
VIMRCS = '/home/' + getpass.getuser() + '/.vim/rc/'
# default project dir
PRJDIR = '/home/' + getpass.getuser() + '/git/'

# rc files templates

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
                                'server_config.yaml\n' +
                                '*.pyc')
            },
          'serverconf'   :
            {
                'name'      :   'server_config.yaml',
                'location'  :   '',
                'content'   :   ('#TIPS\n' +
                                '# - all values must be between quotation marks\n' +
                                '# - all dirs must end with trailing slash\n' +
                                '# - the postcmd value must be empty\n' +
                                '"$servername":\n' +
                                '    host        :  "$serverhost"\n' + 
                                '    user        :  "$serveruser"\n' +
                                '    port        :  "$serverport"\n' +
                                '    password    :  "$serverpassword"\n' +
                                '    deploydir   :  "$deploydir"\n' +
                                '    deployuser  :  "$deployuser"\n' +
                                '    deploygroup :  "$deploygroup"\n' +
                                '    postcmd     :\n' +
                                '        cmd     :  ""\n' +
                                '        cmd2    :  ""')
            }
        }

optional = { 'tmuxwindow':  ('# Set window root path. Default is `$session_root`.\n' +
                            '# Must be called before `new_window`.\n' +
                            'window_root "$winroot"\n\n' +
                            '#new_window "foo"\n\n' +
                            'select_window "$projname"\n\n' +
                            '# Split window into panes.\n' +
                            'run_cmd "$firstpane"\n' +
                            'split_h 40\n' +
                            'run_cmd "$secondpane"\n' +
                            'split_v 20\n\n' +
                            '# Paste text\n' +
                            '#send_keys "top"    # paste into active pane\n' +
                            '#send_keys "tmuxifier load-window geolog" 1 # paste into active pane\n\n' +
                            '# Set active pane.\n' +
                            '#select_pane 0'),
            }

# do not edit below this line
#############################

################################
#    PROJECTS SETUP SCRIPT     #
################################

createdfiles = []
def setup(prjname):
    """ Creates files for new project: .vimrc, server_config, README, tmux, Vagrantfile."""
    global PRJDIR

    ## 1 -- create project directory
    PRJDIR = raw_input("Please select project folder [" + PRJDIR + \
            prjname + "]:\t") or (PRJDIR + prjname)
    local('mkdir %s' % (PRJDIR))

    print '\nPlease select which files to you want to setup.'

    ## 2 -- create all files in `files` dictionary: these are mandatory
    for file in files:
        fileloc = PRJDIR + files[file]['location'] + '/' + files[file]['name']
        userchoice = raw_input(colors.magenta('\n%s [Y/n]: \t') %fileloc) or 'y'

        if userchoice == 'y':
            f = open("%s" %fileloc, "w")
            f.write(files[file]['content'])
            f.close()
            print colors.green("\__added %s" %fileloc)
            createdfiles.append([files[file]['name'], fileloc])
        else:
            continue
        
    ## 3 -- create project tmux window file for Tmuxifier
    userchoice = raw_input('\nDo you want to setup a Tmuxifier window? [Y/n]: \t') or 'y'

    if userchoice == 'y':
        _createtmux(prjname)
    else:
        pass

    ## 4 -- check for unconfigured variables in created files
    toconfvars = _checkvars(createdfiles)

    if toconfvars > 0:
        print ('\nIt seems you have ' + str(toconfvars) + \
                ' unconfigured variables for this project.')
        userchoice = raw_input('\nDo you want to configure them now? [Y/n]: \t') or 'y'

        if userchoice == 'y':
            _configurevars(createdfiles)
        else:
            pass
    else:
        pass

    ## 5 -- add a `.vimrc` file for the project
    userchoice = raw_input('\nDo you want to add a .vimrc file \
    to this project? [Y/n]: \t') or 'y'

    if userchoice == 'y':
        rclist = []
        for filenames in _walk(VIMRCS):
            rclist.extend(filenames[2])
        vimrc = raw_input('Please select one of the following files [%s]: \t' \
                %(', '.join(map(str, rclist)))) or 'dev'
        local('cp %s%s %s/.vimrc' %(VIMRCS, vimrc, PRJDIR))

def _createtmux(tmuxname):
    desttemplateloc = TMUXIFIER + tmuxname + '.window.sh'
    f = open("%s" %desttemplateloc, "w")
    f.write(optional['tmuxwindow'])
    f.close()
    print (colors.green("\___added %s") %desttemplateloc)
    createdfiles.append(['tmuxwindow', desttemplateloc])

def _checkvars(rcfiles):
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

def _configurevars(rcfiles):
    valsdict = {}
    for item in rcfiles:
        # for each file, build a dictionary of values for each undefined variable
        for key in item[2:]:
            valsdict[key] = raw_input(colors.yellow('\n[%s]\t\t%s: \t') %(item[0], key))
        # replace variable with inserted value
        for line in fileinput.input(item[1], inplace = 1):
            for key in valsdict:
                line = line.replace(key, valsdict[key])
            sys.stdout.write(line)

################################
#         ENVIRONMENTS         #
################################

def _load_config(**kwargs):
    """Find and parse server config file.

    If `config` keyword argument wasn't set look for default
    'server_config.yaml' or 'server_config.json' file.

    """
    config, ext = os.path.splitext(kwargs.get('config',
        'server_config.yaml' if os.path.exists('server_config.yaml') else 'server_config.json'))

    if not os.path.exists(config + ext):
        print colors.red('Error. "%s" file not found.' % (config + ext))
        return {}
    if YAML_AVAILABLE and ext == '.yaml':
        loader = yaml
    elif JSON_AVAILABLE and ext =='.json':
        loader = json
    else:
        print colors.red('Parser package not available')
        return {}
    # Open file and deserialize settings.
    with open(config + ext) as config_file:
        return loader.load(config_file)

def s(*args, **kwargs):
    """Set destination servers or server groups by comma delimited list of names"""
    # Load config
    servers = _load_config(**kwargs)
    try:
        servers.update(vagenv)
        print 'Added vagrant config'
    except NameError:
        pass
    # If no arguments were recieved, print a message with a list of available configs.
    if not args:
        print 'No server name given. Available configs:'
        for key in servers:
            print colors.green('\t%s' % key)

    # Create `group` - a dictionary, containing copies of configs for selected servers. Server hosts
    # are used as dictionary keys, which allows us to connect current command destination host with
    # the correct config. This is important, because somewhere along the way fabric messes up the
    # hosts order, so simple list index incrementation won't suffice.
    env.group = {}
    # For each given server name
    for name in args:
        #  Recursive function call to retrieve all server records. If `name` is a group(e.g. `all`)
        # - get it's members, iterate through them and create `group`
        # record. Else, get fields from `name` server record.
        # If requested server is not in the settings dictionary output error message and list all
        # available servers.
        _build_group(name, servers)


    # Copy server hosts from `env.group` keys - this gives us a complete list of unique hosts to
    # operate on. No host is added twice, so we can safely add overlaping groups. Each added host is
    # guaranteed to have a config record in `env.group`.
    env.hosts = env.group.keys()

def _build_group(name, servers):
    """Recursively walk through servers dictionary and search for all server records."""
    # We're going to reference server a lot, so we'd better store it.
    server = servers.get(name, None)
    # If `name` exists in servers dictionary we
    if server:
        # check whether it's a group by looking for `members`
        if isinstance(server, list):
            if fabric.state.output['debug']:
                    puts("%s is a group, getting members" % name)
            for item in server:
                # and call this function for each of them.
                _build_group(item, servers)
        # When, finally, we dig through to the standalone server records, we retrieve
        # configs and store them in `env.group`
        else:
            if fabric.state.output['debug']:
                    puts("%s is a server, filling up env.group" % name)
            env.group[server['host']] = server
    else:
        print colors.red('Error. "%s" config not found. Run `fab s` to list all available configs' % name)

def _setup(task):
    """
    Copies server config settings from `env.group` dictionary to env variable.

    This way, tasks have easier access to server-specific variables:
        `env.owner` instead of `env.group[env.host]['owner']`

    """
    def task_with_setup(*args, **kwargs):
        # If `s:server` was run before the current command - then we should copy values to
        # `env`. Otherwise, hosts were passed through command line with `fab -H host1,host2
        # command` and we skip.
        if env.get("group", None):
            for key,val in env.group[env.host].items():
                setattr(env, key, val)
                if fabric.state.output['debug']:
                    puts("[env] %s : %s" % (key, val))

        task(*args, **kwargs)
        # Don't keep host connections open, disconnect from each host after each task.
        # Function will be available in fabric 1.0 release.
        # fabric.network.disconnect_all()
    return task_with_setup

def _chowndeploy():
    """If both `deployuser` and `deploygroup` are set in server_config, chown the
    deployed folder with these settings"""
    deployprojdir = env.deploydir + os.getcwd().rsplit('/',1)[1]
    if env.deployuser and env.deploygroup:
        try:    # TODO better error handling
            run('chown -R %s:%s %s' %(env.deployuser,env.deploygroup,deployprojdir))
        except:
            print 'Got an error!'
    else:
        print colors.red('Tried to chown, but settings are not defined.')

def _postcmd():
    """Searches for `postcmd` field in server_config and executes the commands,
    stripping out sudo from raw command and wrapping with Fabric's sudo() if needed"""
    if env.postcmd:
        for cmd in env.postcmd:
            if env.postcmd[cmd]:
                if env.postcmd[cmd].split()[0] == 'sudo':
                    sudo(env.postcmd[cmd].split(' ',1)[1])
                else:
                    run(env.postcmd[cmd])
            else:
                print colors.red('No postcmd found.')
    else:
        print colors.red('No postcmd found.')

#############################
#          TASKS            #
#############################

@_setup
def uname():
    run('uname -a')

@_setup
def rsync():
    rsync_project(
            remote_dir=env.deploydir,
            exclude=("server_config.yaml", ".gitignore", "*.pyc")
            )
    _chowndeploy()
    _postcmd()

def load(projname):
    """Loads per-prpject tmux windows configuration."""
    local('tmux rename-window %s && tmuxifier load-window %s' % (projname, projname))
