#!/bin/bash

install_dev_tool()
{
	sudo apt-get install qgit meld
}

install_ubuntu_tool()
{
	sudo lshw | grep vbox && sudo usermod -a -G vboxsf gavin

	# Enable source list
	sudo sed -i '/^#.*deb-src.*\/\/us.*universe/s/^# //' /etc/apt/sources.list

	sudo apt-get update

	sudo apt-get install compizconfig-settings-manager <<< y
}

install_vim()
{
	sudo apt-get install vim vim-gnome <<< y
	sudo apt-get install ctags <<< y
}

install_tmux()
{
	# Remove current tmux
	which tmux && sudo apt-get remove tmux
	(ls ./tmux/.git || git clone https://github.com/tmux/tmux.git ./tmux)

	# Check out to the latest TAG
	#(cd tmux && git checkout $(git describe --abbrev=0 --tags))
	(cd tmux && git pull origin master)

	sudo apt-get build-dep tmux <<< y

	(cd tmux && ./autogen.sh;./configure && make && sudo make install)

	echo "New tmux version " $(tmux -V)
}

vnc()
{
	sudo apt-get install xrdp <<< y
	dconf write /org/gnome/desktop/remote-access/enabled true
	dconf write /org/gnome/desktop/remote-access/prompt-enabled true
	dconf write /org/gnome/desktop/remote-access/authentication-methods "'none'"
	dconf write /org/gnome/desktop/remote-access/require-encryption false
}

ssh()
{
	sudo apt-get install openssh-server <<< y
	sudo /etc/init.d/ssh restart
	service ssh status
}

vpn()
{
	sudo apt-get install network-manager-vpnc vpnc <<< y
}

yocto_env()
{
	sudo apt-get install autoconf automake libtool <<< y
	sudo apt-get install gawk wget diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm <<< y
}

nfs()
{
	sudo apt-get install nfs-kernel-server nfs-common <<< y
	ls /etc/exports && sed -i '/\/home\/gavin'/d /etc/exports
	echo "/home/gavin/work *(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
	sudo exportfs -a
	sudo service nfs-kernel-server restart
	sudo service nfs-kernel-server status
}

smba()
{
	sudo apt-get install samba <<< y

	# Remove my add on to the end
	sudo sed -i '/my add on/,$ d' /e	samba/smb.conf

sudo bash -c 'cat >> /etc/samba/smb.conf << EOF

# my add on
[work]
comment = Public stuff
path = /home/gavin/work
public = yes
writeable = yes
browseable = yes
guest ok = yes
force user = gavin
force group = gavin
EOF'
	sudo service smbd restard
}

set_tmux()
{
cat > ~/.tmux.conf << EOF
unbind C-b
set -g prefix C-x
bind C-a send-prefix

bind -T root WheelUpPane   if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
bind -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"
#bind -t vi-copy    WheelUpPane   page-up
#bind -t vi-copy    WheelDownPane page-down

bind-key q kill-window
bind-key \ split-window -h
bind-key - split-window
bind-key x kill-pane

set -g mouse on

EOF

sed -i '/^alias tmux=/'d ~/.bashrc
echo -e "\nalias tmux='tmux ls || tmux new-session;(tmux ls | grep attached && tmux new-session) || tmux attach'" >> ~/.bashrc
}

set_vim()
{
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
}

set_git()
{
	git config --global user.name "GavinHuang"
	git config --global user.email "476058970@qq.com"
	git config --global http.sslverify false
	git config --global alias.st status
}


# Run functions
for COMMAND in $*
do
	echo $COMMAND ...
	sleep 1
	$COMMAND
done
