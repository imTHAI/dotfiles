# Shortcuts

pip() {
  if [[ "$1" == "install" ]]; then
    command pip install "${@:2}" --break-system-packages
  else
    command pip "$@"
  fi
}
alias buildpushmyarch='docker build --platform=linux/amd64 -t imthai/myarch -f Dockerfile_arch . && docker push imthai/myarch'
alias arch_docker="docker run -it --rm --platform=linux/amd64 -v ~/downloads:/downloads -v ~/.home_archdocker:/root imthai/myarch"

alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="eza -l --group-directories-first"
alias ls="eza --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias  dl="aria2c -x4 --dir=/Users/pbear/Downloads"
alias macos_sign="xattr -cr"
alias sync_photoslib="rsync -vah --exclude='.DS_Store' --delete \
                     /Volumes/TB_500Go/Images/Photos\ Library.photoslibrary coruscant:/mnt/user/backups/ \
                   && rsync -vah --exclude='.DS_Store' --delete \
                     /Volumes/TB_500Go/Images/ColdStorage.photoslibrary coruscant:/mnt/user/backups/"
alias sync_calibre="rsync -vah --exclude='.DS_Store' --delete \
                     /Volumes/TB_500Go/Librairie\ Calibre coruscant:/mnt/user/media/books/"
alias sync_udmroot="rsync -vah -e ssh --delete udm:/root/ --include='.bashrc' --exclude='.*' /Users/pbear/Library/Mobile\ Documents/com~apple~CloudDocs/Backups/udm/root/"
# Backup my local bin folder to coruscant and to iCloud
alias sync_bin="rsync -avh --exclude='.DS_Store' --delete ~/Applications/bin coruscant:/mnt/user/backups/ && \
                rsync -avh --exclude='.DS_Store' --delete ~/Applications/bin /Users/pbear/Library/Mobile\ Documents/com~apple~CloudDocs/Backups/ "



ogg2m4a() {
    find . -name "*.ogg" -type f -exec sh -c '
      mkdir -p output
      basename_file=$(basename "$1" .ogg)
      clean_name=$(echo "$basename_file" | sed "s/^[0-9]\{1,2\}\. //")
      ffmpeg -i "$1" -vn -c:a alac -f mp4 "output/${clean_name}.m4a"
    ' _ {} \;
}


# Backup some folders from my homedir on coruscant to iCloud
alias sync_homedir="rsync -vah -e ssh --exclude='Survivalisme' --exclude='Recycle.Bin' --exclude='.DS_Store' --exclude='instagram' --exclude='__pycache__' --delete coruscant:/mnt/user/homedir-pbear/ '/Users/pbear/Library/Mobile Documents/com~apple~CloudDocs/Backups/homedir-pbear/' "

flac2m4u() {
    find . -name "*.flac" -type f -exec sh -c '
      mkdir -p output 
      basename_file=$(basename "$1" .flac) \
      clean_name=$(echo "$basename_file" | sed "s/^[0-9]\+\. //") 
      ffmpeg -i "$1" -vn -c:a alac -f mp4 "output/${clean_name}.m4a"
    ' _ {} \;
}

alias sync_devonthink='
BACKUP_SRC="$HOME/Databases"
BACKUP_DST="/mnt/user/backups/DEVONthink"
REMOTE_HOST="coruscant"
DATE=$(date +%F)

for DB in "$BACKUP_SRC"/*.dtBase2 "$BACKUP_SRC"/*.dtSparse; do
  EXT="${DB##*.}"
  BASENAME=$(basename "$DB" .$EXT)

  # Vérification de fermeture
  if [ "$EXT" = "dtBase2" ]; then
    if [ -e "$DB/.lock" ]; then
      echo "⏸️ Base $BASENAME.$EXT ouverte, sautée."
      continue
    fi
  elif [ "$EXT" = "dtSparse" ]; then
    MOUNTED=$(hdiutil info | grep -F "$DB")
    if [ -n "$MOUNTED" ]; then
      echo "⏸️ Image $BASENAME.$EXT montée, sautée."
      continue
    fi
  fi

  REMOTE_PATH="$BACKUP_DST/${BASENAME}_$DATE.$EXT"

  echo "🔄 Backup de $BASENAME.$EXT vers $REMOTE_HOST:$REMOTE_PATH"

  if [ -d "$DB" ]; then
    rsync -avz "$DB/" "$REMOTE_HOST:$REMOTE_PATH/"
  else
    rsync -avz "$DB" "$REMOTE_HOST:$REMOTE_PATH"
  fi

  echo "🧹 Rotation des anciennes versions (max 4 gardées)..."
  ssh "$REMOTE_HOST" "cd $BACKUP_DST && ls -dt ${BASENAME}_*.$EXT 2>/dev/null | tail -n +5 | xargs -r rm -rf"
done

echo "✅ Backup terminé."
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
