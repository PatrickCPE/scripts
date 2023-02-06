#!/bin/sh

echo "User Input Required"
ssh-keygen -t ed25519 -C `git config --get user.email`

echo "Adding Key to Keychain"
ssh-add ~/.ssh/id_ed25519

echo "Now you need to add the key to github"
echo "https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account"
