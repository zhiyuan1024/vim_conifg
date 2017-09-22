#!/bin/bash

InstallVimRc() {
	install vimrc ~/.vimrc
	InstallPlugin
}

InstallVundle() {
	if [ -e ~/.vim/bundle ] ; then
		rm ~/.vim/bundle -rf
	fi
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

InstallPlugin() {
	vim +PluginInstall +qall
}

BuildYcmForRedhat() {
	tool=dnf
	if ! which $tool ; then
		tool=yum
	fi
	sudo $tool install -y automake gcc gcc-c++ kernel-devel cmake
	sudo $tool install -y python-devel python3-devel
	sudo $tool install -y clang-devel
	cur=$(pwd)
	cd ~/.vim/bundle/YouCompleteMe
	./install.py --gocode-completer --clang-completer
	cd $cur
}

BuildYcmForUbuntu() {
	sudo apt-get install build-essential cmake
	sudo apt-get install python-dev python3-dev
	cur=$(pwd)
	cd ~/.vim/bundle/YouCompleteMe
	./install.py --gocode-completer --clang-completer
	cd $cur
}

BuildYcm() {
	os=$(hostnamectl| grep Operating | awk -F ':' '{print $2}')
	case $os in
		*centos*|*fedora*)
		BuildYcmForRedhat
		;;
		*ubuntu*|*elementary*)
		BuildYcmForUbuntu
		;;
		*)
		echo "unknown linux release, cannot auto buildycm, please DIY."
		;;
	esac
}

Install() {
	InstallVundle
	InstallVimRc
	BuildYcm
}

Clean() {
	rm ~/.vimrc
	rm -rf ~/.vim/bundle
}

Usage() {
	echo "usage: $0 install|installrc|clean|buildycm"
}

if [ $# != 1 ]; then
	Usage
	exit
fi

case $1 in
	install)
		Install
		;;
	installrc)
		InstallVimRc
		;;
	buildycm)
		BuildYcm
		;;
	clean)
		Clean
		;;
	*)
		Usage
		;;
esac
