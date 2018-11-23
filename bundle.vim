call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'rking/ag.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
Plug 'Raimondi/delimitMate'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-git'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'scrooloose/nerdcommenter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/switch.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'kana/vim-textobj-user'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'airblade/vim-gitgutter'
Plug 'kaicataldo/material.vim'
Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'raphamorim/lucario'
Plug 'tpope/vim-bundler'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mmozuras/vim-github-comment'
Plug 'kablamo/vim-git-log'
Plug 'osyo-manga/vim-monster'
Plug 'rhysd/committia.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'esneider/YUNOcommit.vim'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
Plug 'joshdick/onedark.vim'
Plug 'jgdavey/tslime.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-highlight'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-projectionist'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/paredit.vim'
Plug 'jreybert/vimagit'
Plug 'janko-m/vim-test'
Plug 'aliou/sql-heredoc.vim'
Plug 'w0rp/ale'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
" Auto complete stuff
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-github'
Plug 'SirVer/ultisnips'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

