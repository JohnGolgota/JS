ssh-keygen -t ed25519 -C "104475729+JohnGolgota@users.noreply.github.com"

gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
add github

git config --global --unset gpg.format
git config --global user.signingkey 3AA5C34371567BD2
git config --global commit.gpgsign true