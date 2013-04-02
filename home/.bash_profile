#
# ~/.bash_profile
#

## TexLive executables
export PATH=/usr/local/texlive/2012/bin/x86_64-linux:${PATH}

## doctorjs Arch
export NODE_PATH=/usr/lib/jsctags:$NODE_PATH

## fradeve's local bins
export PATH=/home/fradeve/.bin:${PATH}

## ruby
export PATH=/home/fradeve/.gem/ruby/2.0.0/bin:${PATH}

### CODE FOR $PS1 ###
#####################

# Colour Codes
export Cyan="\[\e[m\]\[\e[0;36m\]"
export Red="\[\e[m\]\[\e[0;31m\]"
export White="\[\e[m\]\[\e[1;37m\]"
export LightCyan="\[\e[m\]\[\e[1;36m\]"
export LightRed="\[\e[m\]\[\e[1;31m\]"

# Code for a cool Prompt
function pre_prompt
{
    newPWD="${PWD}"
    user="whoami"
    host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
    datenow=$(date "+%a, %d %b %y")
    let promptsize=$(echo -n "--($user@$host ddd, DD mmm YY)---(${PWD})---" \
                 | wc -c | tr -d " ")

    width=$(tput cols)

    if [ `id -u` -eq 0 ]
    then
        let fillsize=${width}-${promptsize}+1
    else
        let fillsize=${width}-${promptsize}-1
    fi

    fill=""

    while [ "$fillsize" -gt "0" ]
    do
        fill="${fill}─"
        let fillsize=${fillsize}-1
    done

    if [ "$fillsize" -lt "0" ]
    then
        let cutt=3-${fillsize}
        newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
    fi
}

# Set prompt colour
if [ `id -u` -eq 0 ]
then
    cText="${LightRed}"
    cBorder="${Red}"
else
    cText="${LightCyan}"
    cBorder="${Cyan}"
fi

PROMPT_COMMAND=pre_prompt

# Display Prompt
PS1="${cBorder}┌─(${White}\u@\h \$(date \"+%a, %d %b %y\")${cBorder})─\${fill}─(${cText}\$newPWD\
${cBorder})────┐\n${cBorder}└─(${cText}\$(date \"+%H:%M\")${cBorder})─> ${White}"

#PS1='[\u@\h \W]\$ '