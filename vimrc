" settings
set number
set mouse=a
syntax on

" utf8
set enc=utf-8
set fileencoding=utf-8

" tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" theme
colorscheme molokai

" powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode

