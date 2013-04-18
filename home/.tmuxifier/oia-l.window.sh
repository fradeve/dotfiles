# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "/home/fradeve/git/sipontomedievale"

# Create new window. If no argument is given, window name will be based on
# layout file name.
#new_window "foo"

select_window oia-l

# Split window into panes.
split_h 40

# Run commands.
run_cmd "vagup && vagrant ssh"                                      #   second pane
run_cmd "cd /home/fradeve/git/sipontomedievale/sip-site && vim"     1   # first pane

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "tmuxifier load-window geolog" 1 # paste into active pane

# Set active pane.
#select_pane 0
