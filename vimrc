set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
call vundle#end()

filetype plugin indent on
set autoindent

set number
set laststatus=2
set tabstop=4
set shiftwidth=4

set ignorecase smartcase
set incsearch
set hlsearch
set magic

" NERDTree
let NERDTreeAutoDeleteBuffer=1

"Tagbar
let g:tagbar_sort = 0
