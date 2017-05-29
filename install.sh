#!/bin/bash -ex

InstallVimRc() {
	install vimrc ~/.vimrc
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

BuildYcm() {
	tool=dnf
	if ! which $tool ; then
		tool=yum
	fi
	sudo $tool install -y automake gcc gcc-c++ kernel-devel cmake
	sudo $tool install -y python-devel python3-devel
	sudo $tool install -y clang-devel
	cur=$(pwd)
	cd ~/.vim/bundle/YouCompleteMe
	./install.py --clang-completer
	./install.py --gocode-completer
	cd $cur
}

Install() {
	InstallVundle
	InstallVimRc
	InstallPlugin
	BuildYcm
}

Clean() {
	rm ~/.vimrc
	rm -rf ~/.vim/bundle
}

Usage() {
	echo "usage: $0 install|installrc|clean"
}

if [ $# != 1 ]; then
	Usage
fi

case $1 in
	install)
		Install
		;;
	installrc)
		InstallVimRc
		;;
	clean)
		Clean
		;;
	*)
		Usage
		;;
esac
