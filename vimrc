set nocompatible
filetype off

set clipboard=unnamed

so ~/.vim/bundle.vim

filetype plugin indent on
set nonumber
set ruler
syntax on
set encoding=utf-8
"let g:html_indent_inctags = "body,head,tbody,ul,li,p,script"
let g:html_indent_style1 = "inc"
let g:html_indent_script1 = "inc"
set hidden
let mapleader = ","
set cursorline
set history=1000
set timeoutlen=500
set viminfo='100,f1
highlight RSpecFailed guibg=#671d1a
autocmd BufNewFile,BufRead *_spec.rb compiler rspec
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a<Leader> :Tabularize /,\zs<CR>
vmap <Leader>a<Leader> :Tabularize /,\zs<CR>
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "Dispatch! bundle exec rspec {spec}"
let g:HammerQuiet=1
" Show 80 column line
set colorcolumn=80
" Whitespace stuff
set wrap
set scrolloff=3
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
let &sbr=nr2char(8618).' '

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*,tags

" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" make uses real tabs
au FileType make 	set noexpandtab

" Status bar
set laststatus=2
" set statusline=%<%f\ %h%m%r%%=%-14.(%l,%c%V%)\ %P
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{exists('g:loaded_rvm')?rvm#statusline():''}%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" Fix issues with the shell and fugitive
set shell=bash

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,Procfile,config.ru}    set ft=ruby

" Recognize .int as yaml
au BufRead,BufNewFile {.int}    set ft=yaml

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype

filetype plugin indent on
set fdl=999
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Generate CTags for every gem included in the Gemfile.
map <silent> <Leader>rt :!bundle list --paths=true \| xargs ctags --extra=+f --exclude=.git --exclude=log -R *<CR><CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-K> [e
nmap <C-J> ]e
" Bubble multiple lines
vmap <C-K> [egv
vmap <C-J> ]egv


" Enable syntastic syntax checking
let g:syntastic_enable_signs=1

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_css_checkers = ['scss_lint']

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:github_user = 'lunks'


" toggle between last open buffers
nnoremap <leader><leader> <c-^>

map <leader>t :CtrlP<cr>
map <leader>g :Gstatus<cr>
" Presing jj get back to normal mode
inoremap jj <esc>
inoremap jk <esc>

"Rd will delete the line and keep the unnamed register untouched
nnoremap R "_d

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Default color scheme

set background=dark

" Detect if we're running a 256 colors terminals
" PuTTY - putty-256color
" rxvt - rxvt-256color
" Eterm - Eterm-256color
" Konsole - konsole-256color
" XFCE's Terminal - gnome-256color
" more details here : http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=256
if matchstr(&t_Co, '256')
  color tomorrow-night
else
  color desert
endif

command Todo Ack TODO
if has("mouse")
  set mouse=a
endif

"map <Leader>o :call RunCurrentLineInTest()<CR>
"map <Leader>p :call RunCurrentTest()<CR>
map <Leader>d obinding.pry<esc>:w<cr>
map <Leader>gs :Gstatus<CR>
map <Leader>f :call OpenFactoryFile()<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...
set formatoptions-=or
au BufWritePre *.rb :%s/\s\+$//e

function! OpenFactoryFile()
  if filereadable("test/factories.rb")
    execute ":sp test/factories.rb"
  else
    execute ":sp spec/factories.rb"
  end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt) modified to use gitmove
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':Gmove ' . new_name
  endif
endfunction
map <leader>n :call RenameFile()<cr>

let delimitMate_expand_space = 1
nnoremap - :Switch<cr>
let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" Insert CRs with ease
" nmap <Return> o<Esc>
" Clean search
map //  :nohlsearch<CR>

map <Leader>R :call RunCurrentSpecFile()<CR>
map <Leader>r :call RunNearestSpec()<CR>
map <Leader>rr :call RunLastSpec()<CR>

let g:ycm_seed_identifiers_with_syntax = 1



" easier redo
noremap U <C-r>
" convert hash rocket to 1.9 hash syntax
nmap <leader>hr mm:s/\v:(\w+) \=\>/\1:/g<CR>`m
" strip trailing whitespace
nnoremap <silent> <leader><space> mm:%s/\s\+$//e<CR>`m
" auto indent whole file
nnoremap <silent> <leader>= mmgg=G`m
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>
nmap <Leader>a :Ag<space>
function! PasteAsCoffee()
  :read !pbpaste | /usr/local/share/npm/bin/js2coffee
endfunction

:command! PasteAsCoffee :call PasteAsCoffee()
:map <leader>pc :PasteAsCoffee<CR>

let g:used_javascript_libs = 'underscore,backbone,jquery'
au BufNewFile,BufRead *.emblem set filetype=slim
