# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/git/sipontomedievale"

# Create new window. If no argument is given, window name will be based on
# layout file name.
#new_window "oia"

# Split window into panes.
#split_h 40

# Run commands.
run_cmd "cd /home/fradeve/git/sipontomedievale/sip-site && vim"   # runs in active pane
#run_cmd "vagrant ssh" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into active pane

# Set active pane.
#select_pane 1
