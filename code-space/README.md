# Quickstart
+ Create ssh key ([guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent))
```
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t ed25519 -C "your_email@example.com"
cp * ~/source/.ssh
```
+ Add key to [github](https://github.com/settings/keys)
- Add ssh key:

```
eval "$(ssh-agent -s)"
ssh-add ~/source/.ssh/id_ed25519
```
- Add continue model
+ Add the model with ip:11434