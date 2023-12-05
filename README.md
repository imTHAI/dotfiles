## A Fresh macOS Setup

These instructions are for setting up new Mac devices.

### Backup the data

If you're migrating from an existing Mac, you should first make sure to backup all of your existing data. Go through the checklist below to make sure you didn't forget anything before you migrate.

- commit and push any changes/branches to your git repositories
- save all important documents from non-iCloud directories
- update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`

### Setting up the Mac

1. Update macOS to the latest version through system preferences

2. Clone this repo to `~/.dotfiles` with:

    ```zsh
    git clone --recursive git@github.com:imthai/dotfiles.git ~/.dotfiles
    ```

3. Run the installation with:

    ```zsh
    cd ~/.dotfiles && ./bootstrap.sh
    ```

5. After mackup is synced with the cloud storage, restore preferences by running `mackup restore`
6. Restart the computer to finalize the process

