### Setup Git info. in bash prompt ###
source ~/.git-prompt.sh

if [[ $(uname) == "Darwin" ]]; then
    host=local
else
    host=$(hostname)
fi

export GIT_PS1_SHOWUPSTREAM=verbose, git
export GIT_PS1_SHOWUNTRACKEDFILES=enabled
export GIT_PS1_SHOWDIRTYSTATE=enabled
PS1='\[\033[01;32m\]\u@${host}\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

test -f ~/.git-completion.sh && . $_ # Add git-completion

### Add pems via SSH ###
if [ -d ~/.pems ]; then
    for pem in $(find ~/.pems -name *.pem); do
        ssh-add $pem >/dev/null 2>&1
    done
fi

### Alter path for custom executables
export PATH="~/.dotfiles/exec:$PATH"
export PATH="~/.dotfiles/git/exec:$PATH"

source ~/.aliases
if [ -f ~/.aliases.local ]; then
    source ~/.aliases.local
fi
source ~/.dotfiles/docker/fns

export CLOUDSDK_PYTHON=/usr/bin/python2.7
if [ -d $HOME/repos ]; then
    for REPO in $( find $HOME/repos -maxdepth 1 -mindepth 1 -type d ); do
        export PYTHONPATH=$REPO:$PYTHONPATH
    done
fi
