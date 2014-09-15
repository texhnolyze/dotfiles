"###---- base settings ----###"
syntax on
scriptencoding utf-8
set encoding=utf-8

set ttyfast							" don't lag...
set cursorline						" track position
set nobackup						" disable backup files (filename~)
set nowrap							" don't wrap lines
set splitbelow						" place new files below the current 
set showmatch						" matching brackets & the like
set clipboard+=unnamed				" yank and copy to X clipboard	
set number							" show line numbers
set whichwrap=b,s,h,l,<,>,[,]		" whichwrap -- left/right keys can travere up/down
set linebreak						" attempt to wrap lines cleanly
set wildmenu						" enchanced tab-completion shows all matching cmds in popup menu
set wildmode=list:longest,full		" full completion options
set autoread						" automatically read changes to file from outside

" tabs and indenting
set tabstop=4						" tabs appear as n number of columns
set shiftwidth=4					" n columns for auto-indenting
set noexpandtab						" insert spaces instead of tabs
set autoindent 						" auto indents next new line
set smartindent 					" smart indent

" searching
set hlsearch						" hightlight search results
set incsearch 						" increment search
set ignorecase						" ignore case when searching
set smartcase						" uppercase causes case-sensitive search

" code completion 
set tags=~/.vim/tags/*

" status bar
" replaced by lightline
"set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1

" color settings
"set background=dark
"set background=light
"colorscheme solarized
"colorscheme molokai


"###---- aliases and keymaps ---###"
map <C-h> <C-w>h<C-w><Esc>
map <C-k> <C-w>k<C-w><Esc>
map <C-j> <C-w>j<C-w><Esc>
map <C-l> <C-w>l<C-w><Esc>


"###---- plugins ----###"
" vundle settings
set nocompatible					" leave the old ways behind
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let vundle manage itself (required)
Bundle 'gmarik/Vundle.vim'

" base plugins
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'rking/ag.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
"Bundle 'Valloric/YouCompleteMe'
 
" color and design plugins
"Bundle 'altercation/vim-colors-solarized'
"Bundle 'tomasr/molokai'
Bundle 'flazz/vim-colorschemes'
Bundle 'itchyny/lightline.vim'

" php plugins
"Bundle 'joonty/vim-phpunitqf'
"Bundle 'joonty/vim-phpqa'
Bundle 'joonty/vdebug'

" python plugins
"Bundle 'joonty/vdebug'

" ruby plugins
"Bundle 'joonty/vdebug'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'

" general coding plugins
Bundle 'scrooloose/syntastic'


" vundle settings end 
call vundle#end()
filetype plugin indent on


"###---- plugin settings ----###"
" YouCompleteMe
"let g:ycm_collect_identifiers_from_tags_files = 1

" lightline
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
