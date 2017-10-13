" Mappings for vim-surround (* = [',",{, ...])
" ys* - add surrounds
" cs* - change surrounds
" ds* - delete surrounds
" S* - add surrounds in visual mode

" Go back to previous location <C-o>
" Reverse of <C-o> is <C-i>

set shell=/bin/bash
runtime macros/matchit.vim

" Fix lag in vim
set ttyfast
set lazyredraw

" have jsx highlighting/indenting work in .js files as well
let g:jsx_ext_required = 0

let $PATH='/usr/local/bin:' . $PATH

" Sessions
let g:session_autoload = 'no'

" Exit insert mode using jk 
:imap jk <Esc>

" Current file in nerdtree
map <F9> :NERDTreeFind<CR>
" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>
" Change NERDTree mappings
let g:NERDTreeMapOpenInTab='<C-t>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeWinSize=50

" Reduce timeout after <ESC> is recvd. This is only a good idea on fast links.
set ttimeout
set ttimeoutlen=20
set notimeout

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

set backspace=1   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
"set hlsearch      " highlight matches
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set clipboard=unnamed "Copy/paste to/from clipboard by default
set colorcolumn=120  " Set max text characters per line

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
"  syntax on
"endif

" Add pathogen execution on startup
execute pathogen#infect()
execute pathogen#helptags()

filetype plugin indent on
syntax on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  " autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Indent Guides settings
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=Red
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Yellow
"To enable Indent Guides use <Leader>ig

" Indentations
set tabstop=4
set shiftwidth=4
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" Ag!(grep) shortcut
let g:ag_prg = 'ag --literal --column --nogroup --noheading'
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <F3> :Ag!<SPACE>

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'gruvbox'
let g:airline_symbols.space = "\ua0"

"Save on focus lost
:au FocusLost * :wa

:set smartcase
:set ignorecase
:set noantialias

" Colorscheme
set t_Co=256
set encoding=utf-8
set background=dark
colorscheme gruvbox

" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" Tab completion
" will insert tab at beginning of line,
" will use <C-x><C-o> (omnicompletion)
"
" type Tab <C-n>/<C-p> to navigate omnicomp
" type <C-n>/<C-p> to navigate local expressions
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" To remove completion preview tab after chosen
"autocmd CompleteDone * pclose
" To remove completion preview tab alltogether
autocmd BufEnter * set completeopt-=preview

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Center page when moving up or down
set scroll=10
nnoremap <C-d> <C-d>z.
nnoremap <C-u> <C-u>z.

" Switch syntax for strange file endings
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.babelrc set filetype=json
au BufNewFile,BufRead *.eslintrc set filetype=json
au BufNewFile,BufRead *.spacemacs set filetype=lisp

" Easy navigation between splits. Instead of ctrl-w + j. Just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Navigations between tabs
nnoremap L gt
nnoremap H gT

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=o

" Style for vim-table mode
" You can activate it with <Leader>tm
let g:table_mode_corner='|'

" Go to file under cursor
nnoremap go gf
nnoremap gf <c-w>gf
nnoremap gF :vertical wincmd f<CR>

" Go to definition made easier for JS files
nnoremap gj lbve"bygd/'<cr>l<c-w>gfgT2<C-o>z.gtgg/<C-r>b<cr>
nnoremap gJ lbve"bygd/'<cr>lgfgg/<C-r>b<cr>

" Multiple Cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Ommit new line char (for visual mode)
vmap $ g_

" Mapping for :%s/EXPRESSION/REPLACEMENT/gc
function! ReplaceIt()
    let expression = input('Enter expression: ')
    call inputsave()
    let replacement = input('Enter replacement: ')
    call inputrestore()
    execute '%sno@'.expression.'@'.replacement.'@gc'
endfunction
nnoremap <F2> :call ReplaceIt()<cr>

" Mapping for :%s/EXPRESSION/REPLACEMENT/gc
function! MassReplaceIt()
    let expression = input('Enter expression: ')
    call inputsave()
    let replacement = input('Enter replacement: ')
    call inputrestore()
    execute 'cdo sno@'.expression.'@'.replacement.'@g | update'
endfunction
nnoremap <F12> :call MassReplaceIt()<cr>

" Bitch, don't copy the stuff I delete into the register :D
nnoremap DD "0dd:let @*=@0<cr>
vnoremap D "0d:let @*=@0<cr>
nnoremap d "_d
nnoremap dd "_dd
vnoremap d "_d
nnoremap s "_s
vnoremap s "_s
nnoremap c "_c
vnoremap c "_c
nnoremap x "_x
vnoremap x "_x

vnoremap p "0p

" Paste while in insert mode
inoremap <C-r> <Esc>:set paste<cr>a<C-r>*<Esc>:set nopaste<cr>a

" Move tab left and right
nnoremap th :tabm -1<cr>
nnoremap tl :tabm +1<cr>

" Load previous session
function! SaveSession()
    let dirPath = fnamemodify('%', ':~:h:t')
    let choice = confirm('Save Session ?',"&Yes\n&No", 1)
    if choice == 1
        execute 'mksession! ~/vim_session/'.dirPath
    endif
endfunction

function! OpenSession()
    let dirPath = fnamemodify('%', ':~:h:t')
    let file = '~/vim_session/'.dirPath
    if glob(file)!=#""
        execute 'source '.file
    endif
endfunction

map <F5> :call OpenSession()<cr>
map <F7> :call SaveSession()<cr>

" Search for word under cursor
map KK lbvey:Ag! <C-r>*<cr>
map K lbvey:Ag! <C-r>* 

" Copy to multiple words to register with ,
nmap <Leader>8 lbve"ay:let @a .= ', '<cr>
nmap <Leader>9 lbve"Ay:let @a .= ', '<cr>
" Copy to multiple words to register with ={}
nmap <Leader>* lbve"by:let @a = '<C-r>b={<C-r>b} '<cr>
nmap <Leader>( lbve"by:let @a .= '<C-r>b={<C-r>b} '<cr>
" Paste words from register on new lines
nmap <Leader>0 o<Esc>"apx^ma:s/ /\r/g<cr>

" Indent correctly
nmap <Leader>) V`a=

" Convert each NAME_LIKE_THIS to NameLikeThis in the current line.
nmap <Leader>2 lbve:s#\%V_*\(\u\)\(\u*\)#\1\L\2#g<cr><C-o>vu
" Convert CamelCase/camelCase to NAMED_CONTANT
nmap <Leader>3 lbve:s#\%V\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<cr><C-o>veU

" For js import aliases ( ../../../components => components)
set path=$PWD/app/js
set path+=$PWD/app/js/**

" Autosave config
"let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_silent = 1  " do not display the auto-save notification

" Ale configurations
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint'], 'css': ['stylelint']}
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_enter = 1
" :lnext and :lprev jumps from error to error

" Seach the copied content in file
nmap // /\V<C-r>*<cr>

" Copy whole text without new line
nmap <Leader>v gg^vG$y

" NerdCommenter settings
" <leader>cm => comment line
" <leader>cs => multi comment
" <leader>cu => multi uncomment
let g:NERDSpaceDelims = 1

" Get off my lawn
nnoremap <Left>     :echoerr "Use h"<CR>
nnoremap <Right>    :echoerr "Use l"<CR>
nnoremap <Up>       :echoerr "Use k"<CR>
nnoremap <Down>     :echoerr "Use j"<CR>
nnoremap gt         :echoerr "use H or L"<CR>

" Leader Mappings
map <Space> <leader>
map <Leader>w :update<CR>
map <Leader>d :bd<CR>
map <Leader>t :tabclose<CR>
map <Leader>q :call SaveSession()<CR>:qall<CR>
map <Leader>f :lopen<CR><CR><C-J>:bd<CR>z.
