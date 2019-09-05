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


set guifont=Fira\ Code:h24
" make uses real tabs
au FileType make 	set noexpandtab

>
" Status bar
set laststatus=2

" Fix issues with the shell and fugitive
set shell=bash

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,Procfile,config.ru,Fastfile}    set ft=ruby
au BufRead,BufNewFile {*.es6}   set ft=javascript
au BufRead,BufNewFile {.babelrc}   set ft=json
au BufRead,BufNewFile {*.zsh-theme}   set ft=zsh

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
au FileType groovy  set tabstop=4 softtabstop=4 expandtab shiftwidth=4

augroup Javascript
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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


if has("pythonx")
  set pyx=3
  set pyxversion=3
endif

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:github_user = 'lunks'


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
colorscheme gruvbox8
let g:airline_theme = 'gruvbox'

command Todo Ack TODO
if has("mouse")
  set mouse=a
endif

map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...
set formatoptions-=or
au BufWritePre *.rb :%s/\s\+$//e

nnoremap - :Switch<cr>
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

let g:used_javascript_libs = 'underscore,react,ramda'

" run set test lib
map <Leader>R :TestFile<CR>
map <Leader>rn :TestNearest<CR>
map <Leader>rr :TestLast<CR>
let test#strategy = "dispatch"
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

let g:polyglot_disabled = ['json']
let g:jsx_ext_required = 0
let g:indent_guides_guide_size = 1
let g:tslime_always_current_session = 1
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_fixers.typescript = ['tslint']
let g:ale_fixers.ruby = ['rubocop']
let g:ale_fix_on_save = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_pattern_options = {'schema\.rb$': {'ale_enabled': 0, 'ale_fixers': {}}}
command S Subvert
" Autocomplete
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <c-c> <ESC>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = '<tab>'
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

map <leader>rc :silent !tmux send-keys -t bottom C-c<CR>

set titlestring=%t
set title
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

set wildoptions=pum
set pumblend=20

nnoremap <leader>f :CocAction<CR>
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
set cmdheight=2
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
