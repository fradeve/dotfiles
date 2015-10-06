" options for vim-addon-manager

    set runtimepath+=~/.vim/bundle/vim-addon-manager
    call vam#ActivateAddons(["Command-T", "DirDo", "Solarized", "localrc", "dbext", "Syntastic", "surround", "The_NERD_Commenter", "EasyMotion", "git-gutter-vim", "The_NERD_tree"])

" plugins settings
" ==============

" [Command-t]

    " Vim's wildignore setting is sourced by Command-t to filter out files
    " when searching; this has effects also on the Vim command line
    set wildignore=*.jpg,*.jpeg,*.gif,*.png,*.avi,*.flv,*.mp4,*.mp3

" [Command-t]

    let g:CommandTCancelMap='<C-x>'
