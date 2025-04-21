# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="eza -l --group-directories-first"
alias ls="eza --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias  dl="aria2c -x4 --dir=/Users/pbear/Downloads"
#alias notarize="codesign --deep -f -s -"
alias macos_sign="xattr -cr"
alias sync_photoslib="rsync -vah --exclude='.DS_Store' --delete \
                     /Volumes/TB_500Go/Images/Photos\ Library.photoslibrary coruscant:/mnt/user/backups/"
alias sync_calibre="rsync -vah --exclude='.DS_Store' --delete \
                     /Volumes/TB_500Go/Librairie\ Calibre coruscant:/mnt/user/media/books/"
alias sync_udmroot="rsync -vah -e ssh --delete udm:/root/ --include='.bashrc' --exclude='.*' /Users/pbear/Library/Mobile\ Documents/com~apple~CloudDocs/Backups/udm/root/"
# Backup my local bin folder to coruscant and to iCloud
alias sync_bin="rsync -avh --exclude='.DS_Store' --delete ~/Applications/bin coruscant:/mnt/user/backups/ && \
                rsync -avh --exclude='.DS_Store' --delete ~/Applications/bin /Users/pbear/Library/Mobile\ Documents/com~apple~CloudDocs/Backups/ "


# Backup some folders from my homedir on coruscant to iCloud
alias sync_homedir="rsync -vah -e ssh --exclude='Survivalisme' --exclude='Recycle.Bin' --exclude='.DS_Store' --exclude='instagram' --exclude='__pycache__' --delete coruscant:/mnt/user/homedir-pbear/ '/Users/pbear/Library/Mobile Documents/com~apple~CloudDocs/Backups/homedir-pbear/' "

alias dtbackup='
BACKUP_SRC="$HOME/Databases"
BACKUP_DST="/mnt/user/backups/DEVONthink"
REMOTE_HOST="coruscant"
DATE=$(date +%F)

for DB in "$BACKUP_SRC"/*.(dtBase2|dtSparse)(N); do
  EXT="${DB##*.}"
  BASENAME=$(basename "$DB" .$EXT)
  REMOTE_PATH="$BACKUP_DST/${BASENAME}_$DATE.$EXT"

  echo "🔄 Backup de $BASENAME.$EXT vers $REMOTE_HOST:$REMOTE_PATH"

  # Test si fichier ou dossier
  if [ -d "$DB" ]; then
    rsync -avz "$DB/" "$REMOTE_HOST:$REMOTE_PATH/"
  else
    rsync -avz "$DB" "$REMOTE_HOST:$REMOTE_PATH"
  fi

  echo "🧹 Rotation des anciennes versions (max 2 gardées)..."
  ssh "$REMOTE_HOST" "cd $BACKUP_DST && ls -dt ${BASENAME}_*.$EXT 2>/dev/null | tail -n +3 | xargs -r rm -rf"
done

echo '✅ Backup terminé.'
'


# Fonction rm personnalisée qui déplace les fichiers vers ~/.Recycle au lieu de les supprimer
function rm {
    # Définir le chemin du dossier .Recycle
    local RECYCLE_BIN="$HOME/.Trash"

    # Créer le dossier .Recycle s'il n'existe pas
    mkdir -p "$RECYCLE_BIN"

    # Boucle sur tous les arguments passés à la commande rm
    for FILE in "$@"; do
        # Vérifier si le fichier ou le répertoire existe
        if [[ -e "$FILE" ]]; then
            # Déplacer le fichier ou répertoire vers le dossier .Recycle
            mv "$FILE" "$RECYCLE_BIN/"
            echo "Moved $FILE to $RECYCLE_BIN"
        else
            echo "rm: cannot remove '$FILE': No such file or directory"
        fi
    done
}

function heic2jpg {
    local input_file="$1"
    local output_file="${input_file%.*}.jpg"

    # Utilisation du chemin absolu
    input_path="$(realpath "$input_file")"
    output_path="$(dirname "$input_path")/${input_file%.*}.jpg"

    sips -s format jpeg "$input_path" --out "$output_path"
}

alias sed=gsed


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
alias gdiff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
