# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "/home/fradeve/git/sipontomedievale"

# Create new window. If no argument is given, window name will be based on
# layout file name.
#new_window "foo"

select_window oial

# Split window into panes.
run_cmd "cd /home/fradeve/git/sipontomedievale/sip-site && vim"
split_h 40
run_cmd "vagrant up && vagrant ssh"
split_v 20

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "tmuxifier load-window geolog" 1 # paste into active pane

# Set active pane.
#select_pane 0
