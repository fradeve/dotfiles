# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "/home/fradeve/DATA/Dropbox/documenti/scuole/university/fare/arte_moderna/riassunti/opere"

# Create new window. If no argument is given, window name will be based on
# layout file name.
#new_window "foo"

select_window arte

# Split window into panes.
split_h 30

# Run commands.
run_cmd "cd /home/fradeve/DATA/Dropbox/documenti/scuole/university/fare/arte_moderna/riassunti/opere && makelatex opere.tex"    #
run_cmd "cd /home/fradeve/DATA/Dropbox/documenti/scuole/university/fare/arte_moderna/riassunti/opere && vim"                    1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "tmuxifier load-window geolog" 1 # paste into active pane

# Set active pane.
#select_pane 0
