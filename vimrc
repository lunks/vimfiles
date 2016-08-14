set clipboard=unnamed

so ~/.vim/bundle.vim

set nonumber
set ruler
set encoding=utf-8
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

" Focus current split
" set winwidth=999
" set winheight=5
" set winminheight=5
" set winminwidth=80

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
au BufRead,BufNewFile {*.es6}   set ft=javascript

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

set fdl=999
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

map <silent> <Leader>rt :!ctags --languages=ruby,javascript --extra=+f --exclude=.git --exclude=log -R *<CR><CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-K> [e
nmap <C-J> ]e
" Bubble multiple lines
vmap <C-K> [egv
vmap <C-J> ]egv


autocmd! BufWritePost * Neomake
autocmd! BufReadPost * Neomake

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

" Presing jj get back to normal mode
inoremap jj <esc>
inoremap jk <esc>

"Rd will delete the line and keep the unnamed register untouched
nnoremap R "_d

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set termguicolors
" Default color scheme
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set background=dark
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme gruvbox

command Todo Ack TODO
if has("mouse")
  set mouse=a
endif

map <Leader>d obinding.pry<esc>:w<cr>
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...
set formatoptions-=or
au BufWritePre *.rb :%s/\s\+$//e

let delimitMate_expand_space = 1
nnoremap - :Switch<cr>
let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --ignore .git --ignore .DS_Store --smart-case -m 1'
" Insert CRs with ease
" nmap <Return> o<Esc>
" Clean search
map //  :nohlsearch<CR>

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

let g:used_javascript_libs = 'underscore,angularjs,angularuirouter,angularui,requirejs,jasmine,jquery'

let g:neoterm_position = 'horizontal'

" run set test lib
nnoremap <silent> ,R :call neoterm#test#run('file')<cr>
nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>
nnoremap <silent> ,rc :call neoterm#close()<cr>
let g:neoterm_rspec_lib_cmd = 'bin/rspec'
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
map <leader>t :Files<cr>
map <leader>b :Buffers<cr>

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:neomake_elixir_enabled_makers = []

let g:polyglot_disabled = ['javascript', 'json']
let g:jsx_ext_required = 0
let g:indent_guides_guide_size = 1

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
