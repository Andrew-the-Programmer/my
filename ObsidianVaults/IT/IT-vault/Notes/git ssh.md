---
id: 1734951171-git-ssh
aliases:
  - git ssh
tags: []
---
# git ssh

# Create ssh key
```bash
ssh-keygen -t ed25519 -C <your_email>
```
> for default file and no passphrase: \<CR\> $\times$ 3
# Copy ssh key to clipboard
## Windows
```bash
cd C:\Users\<user>
clip < ./.ssh/id_ed25519.pub
```
## Linux
```bash
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
```
# Add new ssh key to GitHub
`GitHub -> Settings -> SSH and GPG keys -> New SSH key`
