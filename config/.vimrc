" file settings
set encoding=utf-8
set backup
set writebackup
set backupdir=~/tmp/ " backup files dir
set directory=~/tmp/ " swap file dir

" timestamp-extension to backups
au BufWritePre * let &bex = '-' . strftime("%Y%m%d%H%M") . '.backup'

" folding
filetype plugin indent on
set foldmethod=indent " fold by indentation

" indent
set tabstop=2 shiftwidth=2 softtabstop=2
set noexpandtab
set backspace=2 " backspace to del prev in insert mode

" look-and-feel
" chdir ~ " go home
colorscheme desert " def colors
set cursorline " current line highlight

"set guifont=* " font selector on startup
set guifont=Consolas:h11
set guioptions-=m
set guioptions-=T " hide toolbar, menubar and use text-tabs
set guioptions-=e

set ls=2 " always status line
set statusline=%<%f\ " Filename
set statusline+=\ [%{getcwd()}] " Current dir
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y] " Filetype
set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of
set statusline+=[tabs=%{&ts}]
set statusline+=%=%-14.(line:%l,col:%c%V%)\ %p%% " Right aligned file nav

set wildmenu " show completion list
set iskeyword+=- " autocomplete words with dash

" syntax formatting
syntax on
set number " line numbers

" abbreviations
" source ~/.vimabbrev

" key mappings
imap jkk <esc>
