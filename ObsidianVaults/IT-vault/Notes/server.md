---
id: 279-server
aliases:
  - server
tags: []
---

# server
https://www.youtube.com/watch?v=Lk_v6Q0YsNo&t=931s

# [[1728763957-ssh|ssh]]

# Linux

## Add wheel group

```bash
groupadd wheel
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
```
## Add user

```bash
username=""
useradd -m $username
passwd $username
usermod -G wheel $username
```

> if sudo command not found: 
> ```bash
> root$ pacman -S sudo
> root$ visudo
> ```
>  Add "root ALL=(ALL:ALL) ALL"
>  ```bash
>  su $username
>  ```
## Create ssh
```bash
# on client
ssh-copy-id $host
```
```bash
sudo vim /etc/ssh/sshd_config
```

https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/

```bash
///
PermitRootLogin yes
->
PermitRootLogin no
///

///
#PublickeyAuthentication yes
->
PublickeyAuthentication yes
///

///
#PasswordAuthentication yes
->
PasswordAuthentication no
///

///
#AuthorizedKeysFile .ssh/authorized_keys
->
AuthorizedKeysFile .ssh/authorized_keys
///
```

May also change the port.

```bash
sudo systemctl restart sshd
```

# Git

## 0. Start sshd

```bash
sudo systemctl start sshd
```

## 1. **Generate an SSH key (if needed)**

If you don't have an SSH key, create one:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Follow prompts to save the key (default is usually fine), and set a passphrase if desired.

## 2. **Add your SSH key to the SSH agent**

Start the SSH agent:
```bash
eval "$(ssh-agent -s)"
```

Add your key:
```bash
ssh-add ~/.ssh/id_ed25519
```

_(Replace filename if your key has a different name.)_

## 3. **Add your SSH public key to GitHub**

Copy your public key:

`cat ~/.ssh/id_ed25519.pub`

Go to GitHub:

- Settings → SSH and GPG keys → New SSH key
- Paste the public key there, give it a name, and save.

## 4. **Test SSH connection to GitHub**

Run:
```bash
ssh -T git@github.com
```

Expected output:
`Hi username! You've successfully authenticated, but GitHub does not provide shell access.`