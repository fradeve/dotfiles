" general settings
" ==============

" Use Vim not vi

    set nocompatible

" avoid backup

    set nobackup
    set noswapfile

" fix tmux arrowkeys behaviour

    if &term =~ '^screen'
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
    endif

" options for vim-addon-manager

    set runtimepath+=~/.vim/bundle/vim-addon-manager
    call vam#ActivateAddons(["Command-T", "DirDo", "Solarized", "Powerline", "localrc", "dbext", "Syntastic", "surround", "surround", "The_NERD_Commenter", "EasyMotion", "git-gutter-vim", "The_NERD_tree", "vim-nerdtree-tabs"])

" This makes vim invoke Latex-Suite when you open a tex file.

    filetype plugin on

" Filetype & Syntax Highlighting

    filetype indent on
    syntax on

" remappint keybindings

    map <silent><A-Right> :tabnext<CR>      " move among tabs using ALT+left or ALT+right
    map <silent><A-Left> :tabprevious<CR>
    map <C-n> :tabnew<CR>

    nmap <silent> <Leader>C :on<CR>         " close all splits execept current one

"Higlight current line and show ruler

    set cursorline
    set ruler

" set default tabbing behaviour

    set tabstop=4
    set shiftwidth=4
    set expandtab

" abbreviations

    iab		perchè		perché
    iab		Perchè		Perché
    iab		poichè		poiché
    iab		Poichè		Poiché
    iab		benchè		benché
    iab		Benchè		Benché
    iab		giacchè		giacché
    iab		Giacchè		Giacché
    iab		dacchè		dacché
    iab		Dacchè		Dacché
    iab		finchè		finché
    iab		Finchè		Finché
    iab		allorchè	allorché
    iab		Allorchè	allorché
    iab		chè		    ché
    iab		Chè		    Ché
    iab		macchè		macché
    iab		Macchè		Macché
    iab		clichè		cliché
    iab		Clichè		Cliché
    iab		anzichè		anziché
    iab		Anzichè		Anziché
    iab		dò		    do
    iab		fà		    fa
    iab		nè		    né
    iab		nonchè		nonché
    iab		Nonchè		Nonché
    iab		pò		    po'
    iab		quà		    qua
    iab		quì		    qui
    iab		sà		    sa
    iab		sè		    sé
    iab		sò		    so
    iab		sù		    su

" Remap Ctrl+V to paste the clipboard in normal and insert modes
" and Ctrl+C to copy the clipboard in visual mode

    nmap <C-V> "+gP
    imap <C-V> <ESC><C-V>i
    vmap <C-C> "+y

"set spell and remap F2, F3, F4 to change spell lang on the fly

    set spell
    setlocal nospell
    map <F2> <Esc>:setlocal spell spelllang=it<CR>
    map <F3> <Esc>:setlocal spell spelllang=en_us<CR> 
    map <F4> <Esc>:setlocal nospell<CR>

"permette il libero movimento dei tasti direzione

    :set whichwrap=b,s,<,>,[,]

"visualizza paragrafi fino all'ultima linea invece
"di nasconderli con "@"

    :set display=lastline

"enable incremental search using smart searching for upper-lowercase managing

    :set incsearch
    :set ignorecase
    :set smartcase

"maintains a certain number of lines visible in the upper part of the screen
"when editing long files

    set scrolloff=2

"generate new help every time the .vim/doc/tip.txt file gets modified

    autocmd BufWrite tip.txt             :helptags ~/.vim/doc/

"opens new tip file for editing in a new tab with leader+h keystroke

    nmap <leader>h :tabnew ~/.vim/doc/tip.txt<CR>

" plugins settings
" ==============

" [localrc]

    let g:localrc_filename='.vimrc'

" [Command-t]

    " Vim's wildignore setting is sourced by Command-t to filter out files
    " when searching; this has effects also on the Vim command line
    set wildignore=*.jpg,*.jpeg,*.gif,*.png,*.avi,*.flv,*.mp4,*.mp3

" [minibufexpl]

    " set this option if the TaskList plugin is installed
    let g:miniBufExplModSelTarget = 1

" [Syntastic]

    let g:syntastic_check_on_open=1
    let g:syntastic_auto_loc_list=0
    let g:syntastic_loc_list_height=3
    let g:syntastic_enable_signs=1
    let g:syntastic_mode_map = { 'mode': 'active',
                   \ 'active_filetypes': ['js'],
                   \ 'passive_filetypes': [] }

" [Solarized - colorscheme]

    set t_Co=16
    set background=dark
    let g:solarized_termcolors=16
    let g:solarized_termtrans = 1
    colorscheme solarized

" [Powerline]

    set laststatus=2
    let g:Powerline_symbols='fancy'
    let g:Powerline_theme='default'
    let g:Powerline_colorscheme='skwp'

" [Command-t]

    let g:CommandTCancelMap='<C-x>'

" [EasyMotion]

    hi link EasyMotionTarget ErrorMsg
    hi link EasyMotionShade  Comment

" [NERD Tree]

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    let g:NERDTreeWinPos = "right"

" [NERD Tree Tabs]

    map <Leader>P :NERDTreeTabsToggle<CR>
