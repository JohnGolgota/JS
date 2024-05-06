# ssh and gpg info

No idea

```sh
ssh-keygen -t ed25519 -C "104475729+JohnGolgota@users.noreply.github.com"
```

```sh
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
# add github

git config --global --unset gpg.format
# this a example... I am clarifying this because I know that I will forget it
git config --global user.signingkey 3AA5C34371567BD2
git config --global commit.gpgsign true
```
