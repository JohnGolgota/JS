" Archivo plugin.vim

" Configuraciones generales
set number
set tabstop=4
set shiftwidth=4

" Plugins usando un gestor de plugins como vim-plug
call plug#begin('~/.vim/plugged')

" Agregar plugins aquí
Plug 'github/copilot.vim'

" También puedes añadir configuraciones específicas de cada plugin
" Ejemplo:
" autocmd FileType python setlocal expandtab

call plug#end()
