# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/geolog"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "geolog"

# Split window into panes.
split_h 50

# Run commands.
run_cmd "tail -f /tmp/mapserv.log"     # runs in active pane
run_cmd "sudo tail -f /var/log/apache2/sipontomedievale.it-error.log" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into active pane

# Set active pane.
#select_pane 0
