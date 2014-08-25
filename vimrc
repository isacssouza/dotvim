        " pathogen call
execute pathogen#infect()
call pathogen#helptags()

runtime! plugin/sensible.vim

set nocompatible
set encoding=utf-8

" Sets how many lines of history VIM has to remember
set history=700
syntax enable

" force filetype reload for pathogen
filetype plugin on
filetype indent on

set hlsearch

let mapleader=","
let g:mapleader = ","

" configure yankring
let g:yankring_max_history = 10
let g:yankring_max_element_length = 100000 " 100Kb

" invoke yank ring window
map <leader>y :YRShow<CR>

" show tabs and new lines
"set listchars=tab:>~,trail:~,extends:>,precedes:<
set list

" File browser
" let g:netrw_liststyle=3

" Set 4 lines to the curors - when moving vertical..
set so=4

set nofoldenable

" show line numbers
set number

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" persistent buffers
set hidden

" autowrite when changing buffers
" set autowriteall

" tabs
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set cindent

set ai "Auto indent
set si "Smart indet

" remove trailing whitespace
nnoremap <silent> <leader>dt :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Really useful!
" "  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Tab configuration
map <leader>. :edit .<cr>

" tagbar
nmap <leader>tb :TagbarOpenAutoClose<CR>

" Format the statusline
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ Line:\ %l/%L:%c
set laststatus=2

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" On ubuntu (running Vim in gnome-terminal)
" The reason for the double-command on <C-c> is due to some weirdness with
" the X clipboard system.
vmap <leader>sc y:call system("xclip -i -selection clipboard",getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <leader>sv :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
if (has("unix"))
    nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
    imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
    nmap <F2> :.w !pbcopy<CR><CR>
    vmap <F2> :w !pbcopy<CR><CR>
endif

" make
" ,M writes buffers, runs :make
map <buffer> <leader>M :wall<CR>:make<CR>
" ,MT writes buffers, runs :make test
map <buffer> <leader>MT :wall<CR>:make test<CR>

" Erlang completion
let g:erlangManPath="/home/isouza/.evm/erlang_versions/otp_src_R13B04/lib/erlang/man/"
let g:erlangCompletionGrep="zgrep"

" wrangler
let g:erlangRefactoring=1

" p4 commands
map <leader>pe :w!<CR>:!p4 edit %<CR>
map <leader>pr :w!<CR>:!p4 revert %<CR>
map <leader>ps :w!<CR>:!p4 sync %<CR>
map <leader>psa :w!<CR>:!p4 sync ...<CR>

" generate tags
map <leader>ct :silent execute "!ctags-exuberant --recurse=yes"<CR><C-L>
map <leader>cft :silent execute "!coffeetags -R -f tags"<CR><C-L>

" maps NERDTree to <leader>nt
map <leader>nt :NERDTreeToggle<CR>

" window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" learning
map <up> <nop>
map <down> <nop>
map <right> <nop>
map <left> <nop>

" grep
map <silent> <F3> :noautocmd silent execute "vimgrep /" . expand("<cword>") . "/j **/*.coffee **/*.js **/*.erl **/*.hrl **/*.java **/*.c **/*.cpp **/*.h" <Bar> botright cw<CR>

" autodetect file indentation
"autocmd BufReadPost * :DetectIndent 
"let g:detectindent_preferred_indent = 4
"let g:detectindent_preferred_expandtab = 1

" easymotion
map <leader>f <leader><leader>f

" vimdiff
map <leader>dp :diffput<CR>

" I can type :help on my own, thanks.
noremap <F1> <Esc>
inoremap <F1> <Esc>

" insert blank line but do not enter insert mode
map <leader>o o<ESC>
map <leader>O O<ESC>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" force saving as root
cmap w!! :!sudo tee > /dev/null %

nnoremap u g-
nnoremap <C-R> g+

noremap <silent><Leader>/ :nohls<CR>

noremap <leader>sp :set paste<CR>
noremap <leader>np :set nopaste<CR>

" select all
map <Leader>a ggVG

function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>
inoremap <leader><Tab> <Tab>

" ex mode commands made easy
nnoremap ; :

autocmd BufNewFile *:\d* call GoToLine()

function! GoToLine()
    let full_name = expand("%")
    if filereadable(full_name)
        execute "edit " . full_name
    else
        let tokens = split(full_name, ':')
        let name = tokens[0]
        let line = tokens[1]

        if filereadable(name)
            execute "edit " . name
            execute line
        else
            execute "edit " . full_name
        endif
    endif
endfunction
    
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" Open last/alternate buffer
noremap <Leader><Leader> <C-^>

" 80-character line coloring
"if exists('+colorcolumn')
"    set colorcolumn=80
"else
"    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory('~/.vim-undo') == 0
    :silent !mkdir -p ~/.vim-undo > /dev/null 2>&1
  endif
  set undodir=~/.vim-undo//
  set undofile
endif

function! DoPrettyXML()
  :!echo getline(".") | xmllint --format -
endfunction
command! PrettyXML call DoPrettyXML()
map <leader>xl :PrettyXML<CR>

" run sml file
map <leader>ss :!sml %<CR>
map <leader>st :!../test.sh %<CR>

" run nodeunit tests
map <leader>nu :!nodeunit %<CR>

" call jshint for the current file
map <leader>jh :JSHint %<CR>

" Syntastic

" enable
let g:syntastic_check_on_open=0
" open error list
let g:syntastic_auto_loc_list=1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_loc_list_height = 3

map <leader>sc :SyntasticCheck<CR>

" page down/up moves only half page
map <pagedown> <C-d>
map <pageup> <C-u>

" use W, B and E for camel case moving
map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b
map <S-E> <Plug>CamelCaseMotion_e

" Use ln and lp to move on syntastic errors
map <leader>ln :lnext<CR>
map <leader>lp :lprev<CR>

set wrap "Wrap lines

map <leader>ff :CtrlP<cr>
map <leader>fb :CtrlPBuffer<cr>
map <leader>ft :CtrlPTag<cr>

" force .md files to be identified as Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

nnoremap <leader>u :GundoToggle<CR>

let g:UltiSnipsExpandTrigger="<s-tab>"

" rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" yankring
let g:yankring_replace_n_pkey = '<leader>pp'
let g:yankring_replace_n_nkey = '<leader>nn'

set background=dark
colorscheme railscasts

nnoremap <leader>w <C-w>v<C-w>l
