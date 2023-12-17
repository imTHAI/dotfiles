# Shortcuts
#alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="eza -l --group-directories-first"
alias ls="eza --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias sync_photoslib="rsync -avr --delete /Users/pbear/Pictures/Photos\ Library.photoslibrary unraid:/mnt/user/backups/"
alias sync_calibre="rsync -avr --delete /Volumes/Mac\ HD\ Extra/Librairie\ Calibre unraid:/mnt/user/media/Books/"


# Directories
alias dotfiles="cd $DOTFILES"
alias cdd="cd $HOME/downloads"
alias cdm="cd $HOME/media"
alias cddu="cd $HOME/downloads_unraid"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
