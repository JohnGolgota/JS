# ssh and gpg info

No idea

```sh
ssh-keygen -t ed25519 -C "104475729+JohnGolgota@users.noreply.github.com"
```

```sh
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
# add github
gpg --armor --export 3AA5C34371567BD

git config --global --unset gpg.format
# this a example... I am clarifying this because I know that I will forget it
git config --global user.signingkey 3AA5C34371567BD2
git config --global commit.gpgsign true
```

No puede pasar un dia sin errores

output:
```sh
# gpg: Note: database_open 134217901 waiting for lock (held by 391) ...
# gpg: Note: database_open 134217901 waiting for lock (held by 391) ...
# gpg: Note: database_open 134217901 waiting for lock (held by 391) ...
# gpg: Note: database_open 134217901 waiting for lock (held by 391) ...
# gpg: Note: database_open 134217901 waiting for lock (held by 391) ...
# gpg: keydb_search_first failed: Connection timed out
# https://forum.endeavouros.com/t/after-the-latest-eos-update-cryptomator-is-crashing-cannot-update-or-reinstall/51151/2
gpgconf --unlock pubring.db
gpgconf --kill gpg-agent

# error: gpg failed to sign the data
# https://gist.github.com/paolocarrasco/18ca8fe6e63490ae1be23e84a7039374
gpg --list-secret-keys --keyid-format=long
git config --global user.signingkey <your key>
```