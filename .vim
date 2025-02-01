set nocompatible 
syntax on
set nocompatible 
set number           
set tabstop=4       
set shiftwidth=4     
set expandtab        
set background=dark
set clipboard=unnamedplus
set ruler
inoremap kj <Esc>
set showcmd
autocmd! bufwritepost .vimrc source %
:filetype plugin on
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
