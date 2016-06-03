" general settings
" ==============

" Use Vim not vi

    set nocompatible

" avoid backup

    set nobackup
    set noswapfile

" allow editing files using sudo without reopening Vim
    cmap w!! %!sudo tee > /dev/null %

" fix tmux arrowkeys behaviour

    if &term =~ '^screen'
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
    endif

" remapped keybindings

    map <silent><A-Right> :tabnext<CR>      " move among tabs using ALT+left or ALT+right
    map <silent><A-Left> :tabprevious<CR>
    map <C-n> :tabnew<CR>

    nmap <silent> <Leader>C :on<CR>         " close all splits execept current one

" higlight current line and show ruler

    set cursorline
    set ruler

" set default tabbing behaviour

    set tabstop=4
    set shiftwidth=4
    set expandtab

" Italian spell corrections

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

" set spell and remap F2, F3, F4 to change spell lang on the fly

    set spell
    setlocal nospell
    map <F2> <Esc>:setlocal spell spelllang=it<CR>
    map <F3> <Esc>:setlocal spell spelllang=en_us<CR> 
    map <F4> <Esc>:setlocal nospell<CR>

" free movement of arrows

    :set whichwrap=b,s,<,>,[,]

" show paragraphs until the last line instead of hiding them with "@"

    :set display=lastline

" enable incremental search using smart searching for upper-lowercase managing

    :set incsearch
    :set ignorecase
    :set smartcase

" maintains a certain number of lines visible in the upper part of the screen
" when editing long files

    set scrolloff=2

" generate new help every time the .vim/doc/tip.txt file gets modified

    autocmd BufWrite tip.txt             :helptags ~/.vim/doc/

" opens new tip file for editing in a new tab with leader+h keystroke

    nmap <leader>h :tabnew ~/.vim/doc/tip.txt<CR>

" add 1 line on top of a GIT commit, start in insert mode

    au FileType gitcommit execute "normal! O" | startinsert

" add vertical column

    set colorcolumn=+1          " highlight column after 'textwidth'
    set colorcolumn=+1,+2,+3    " highlight three columns after 'textwidth'
    highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" installed plugins
" =================

call plug#begin()

Plug 'thinca/vim-localrc'
Plug 'weynhamz/vim-plugin-minibufexpl'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'Rykka/riv.vim'

call plug#end()

" plugins settings
" ================

" [localrc]

    let g:localrc_filename='.vimrc'

" [minibufexpl]

    " set this option if the TaskList plugin is installed
    let g:miniBufExplModSelTarget = 1

" [Powerline Python]

    let $PYTHONPATH="/usr/lib/python3.5/site-packages"
    let g:powerline_pycmd="py3"
    set laststatus=2

" [Solarized - colorscheme]

    set t_Co=16
    set background=dark
    let g:solarized_termcolors=16
    let g:solarized_termtrans = 1
    colorscheme solarized

" [EasyMotion]

    hi link EasyMotionTarget ErrorMsg
    hi link EasyMotionShade  Comment

" [NERD Tree]

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    let g:NERDTreeWinPos = "right"

" [NERD Tree Tabs]

    map <Leader>P :NERDTreeTabsToggle<CR>

" [Syntastic]

    let g:syntastic_check_on_open=1
    let g:syntastic_auto_loc_list=0
    let g:syntastic_loc_list_height=3
    let g:syntastic_enable_signs=1
    let g:syntastic_mode_map = { 'mode': 'active',
                   \ 'active_filetypes': ['js'],
                   \ 'passive_filetypes': [] }

    let g:syntastic_rst_checkers = ['rstcheck']

" [Riv]

    let g:riv_web_browser = 'chromium'

" FocusMode

    function! ToggleFocusMode()
        if (&foldcolumn != 12)
            set laststatus=0
            set numberwidth=10
            set foldcolumn=12
            set noruler
            hi FoldColumn ctermbg=none
            hi LineNr ctermfg=0 ctermbg=none
            hi NonText ctermfg=0
        else
            set laststatus=2
            set numberwidth=4
            set foldcolumn=0
            set ruler
            execute 'colorscheme ' . g:colors_name
        endif
    endfunc
    nnoremap <F1> :call ToggleFocusMode()<cr>
