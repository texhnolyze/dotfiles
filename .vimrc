syntax on
filetype plugin on
filetype indent on

colorscheme desert

set ttyfast							" don't lag...
set cursorline						" track position
set nocompatible					" leave the old ways behind
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

" status bar
set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1








