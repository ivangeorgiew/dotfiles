""" COMMENTS START
" (?!(?:badword|second|\*)) search for not one of these words/characters

" vim-table mode
" You can activate it with <Leader>tm

" Macro
" qe...q OR qr...q
" qE...q to append
" :let @e='<c-r><c-r>e then edit and append '<CR>

"Emmet
"to use type <c-z>,

"Mundo (undo history)
"press V for vimdiff

"Git (vim-fugitive) commands in vim
" [ ] - move between files in Gstatus
" - - adds/removed file to commit
" U - removes file changes
" p - stash -p

" tCommenter
" gcc - comment line
" gc - toggle comment
" g> - comment(vis and normal)
" g< - uncomment(vis and normal)

"Increment and Decrement numbers commands
"X to increment, <C-x> to decrement

" Mappings for vim-surround (* = [',",{, ...])
" ys* - add surrounds
" cs* - change surrounds
" ds* - delete surrounds
" S* - add surrounds in visual mode

" Go back to previous location <C-o>
" Reverse of <C-o> is <C-i>

" :e! to reload file

"<leader>o - close all buffers except the one you're in

"Vimdiff
"<leader>1 - toggle vimdiff for vertsplit
"du - re-scan the files for differences
"do - diff obtain (2 windows)
"dp - diff put (2 windows)
"dl - get code from left (3 windows)
"dr - get code from right (3 windows)
"[ - next difference
"] - previous difference

"To enable Indent Guides use <Leader>ig

" will insert tab at beginning of line,
" will use <C-x><C-o> (omnicompletion)
"
" type Tab <C-n>/<C-p> to navigate omnicomp
" type <C-n>/<C-p> to navigate local expressions
""" COMMENTS END




""" MISC START
" Add pathogen execution on startup
execute pathogen#infect()
execute pathogen#helptags()

colorscheme gruvbox

"Ag replace command
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
""" MISC END




""" SET VALUES START
" Fix lag in vim
set ttyfast
set lazyredraw

" Common
set scroll=10
set cursorline
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands
set clipboard=unnamed "Copy/paste to/from clipboard by default
set colorcolumn=120  " Set max text characters per line
set hlsearch "highlight matches
set smartcase
set noignorecase
set noantialias
set diffopt+=vertical
set nowrap

"Folding
set foldmethod=manual
set foldnestmax=3 "default 20
set foldlevelstart=3 "default 20
set sessionoptions-=folds

" Indentations
set tabstop=4
set shiftwidth=4
set expandtab

" Colorscheme
set background=dark

" Numbers
set number
set numberwidth=5

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" Tab completion
set wildmode=list:longest,list:full

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" For import aliases ( ../../../components => components)
set path=$PWD/app/js
set path+=$PWD/app/js/**

"Silver searcher
if executable('ag')
  set grepprg=ag
endif
""" SET VALUES END




""" AUTOCMD START
augroup syntax
    au!

    "Indent Guides colors
    au VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=Red
    au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Yellow

    " Switch syntax for strange file endings
    au BufNewFile,BufRead *.ejs set filetype=html
    au BufNewFile,BufRead *.babelrc set filetype=json
    au BufNewFile,BufRead *.eslintrc set filetype=json
    au BufNewFile,BufRead *.md set filetype=markdown
augroup END

augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    au BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") && line("$") < 1000 |
        \   exe "normal g`\"" |
        \ endif
    
    "Save on focus lost
    au FocusLost * :wa

    " Disable automatic comment insertion
    au BufEnter * set fo-=c fo-=o

    " highlight vertical column of cursor
    au WinLeave * set nocursorline nocursorcolumn
    au WinEnter * set cursorline
augroup END
""" AUTOCMD END




""" GLOBAL START
" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Change NERDTree mappings
let g:NERDTreeMapOpenInTab='<C-t>'
let g:NERDTreeMapOpenInTabSilent='<C-r>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeWinSize=50

" Indent Guides settings
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

"Emmet settings
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx' } }
let g:user_emmet_leader_key='<C-Z>' "<C-z>, to activate

"Mundo (undo history) settings
let g:mundo_width = 40
let g:mundo_preview_height = 25
let g:mundo_preview_bottom = 1
let g:mundo_close_on_revert = 1

" have jsx highlighting/indenting work in .js files as well
let g:jsx_ext_required = 0

" Autosave config
"let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_silent = 1  " do not display the auto-save notification

" ALE configurations
let g:ale_linters = {'javascript': ['eslint'], 'css': ['stylelint']}
let g:ale_fixers = {'javascript': ['eslint'], 'css': ['stylelint']}
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_enter = 1

" vim-table settings
let g:table_mode_corner='|'

"The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --hidden %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
let g:ag_prg = 'ag --column --nogroup --noheading'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'gruvbox'
let g:airline_symbols.space = "\ua0"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
""" GLOBAL END




""" FUNCTIONS START
function! SaveSession()
    let dirPath = fnamemodify('%', ':~:h:t')
    if expand('%:p') =~ "projects" && expand('%:t') != ''
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

function! FileReplaceIt()
    let expression = @b
    call inputsave()
    let replacement = input('Enter replacement: ')
    call inputrestore()
    execute '%sno@'.expression.'@'.replacement.'@gc'
endfunction

function! VisReplaceIt()
    call inputsave()
    let expression = input('Enter expression: ')
    call inputrestore()
    call inputsave()
    let replacement = input('Enter replacement: ')
    call inputrestore()
    execute "%s@\\%V".expression."@".replacement."@g"
endfunction

function! MassReplaceIt()
    call inputsave()
    let expression = input('Enter expression: ')
    call inputrestore()
    call inputsave()
    let replacement = input('Enter replacement: ')
    call inputrestore()
    execute 'cdo sno@'.expression.'@'.replacement.'@g | update'
endfunction

function! ToggleDiff()
    if &diff
        execute "windo diffoff"
    else
        execute "windo diffthis"
    endif
endfunction
""" FUNCTIONS END




""" MAPPINGS START
" Main Leader Mappings
map <Space> <leader>
map <Leader>q :call SaveSession()<CR>:qall<CR>
map <Leader>w :update<CR>
map <Leader>d :bd<CR>
map <Leader>t :tabclose<CR>

"Folding mappings
"Fold all
nnoremap zm zM
"Unfold all
nnoremap zn zR
"open/close fold
nnoremap Z za
"fold visual selection
vnoremap Z zf
nnoremap <silent> zl1 :set foldlevel=1<CR>
nnoremap <silent> zl2 :set foldlevel=2<CR>
nnoremap <silent> zl3 :set foldlevel=3<CR>

"Close insert mode
imap jk <Esc>

"NERDTree
map <F9> :NERDTreeFind<CR>
map <F10> :NERDTreeToggle<CR>

"X to increment
nnoremap X <C-a>

"Go to last text char in vis
vnoremap $ g_

" Get off my lawn
nnoremap <Left>     :echoerr "Use h"<CR>
nnoremap <Right>    :echoerr "Use l"<CR>
nnoremap <Up>       :echoerr "Use k"<CR>
nnoremap <Down>     :echoerr "Use j"<CR>
nnoremap gt         :echoerr "use H or L"<CR>

" Copy whole file contents
map <Leader>v gg^vGg_y

"Vimdiff
"diff 2 buffers in vertical split
nmap <Leader>1 :call ToggleDiff()<cr>
"close every buffer except the one you're in
nmap <Leader>o :only<CR>
nmap <Leader>[ ]c
nmap <Leader>] [c
nnoremap du :diffupdate<CR>
nnoremap dl :diffget //2<CR>
nnoremap dr :diffget //3<CR>

"Git (vim-fugitive) mappings
nmap <Leader>gac :Git add .<CR>:Gcommit -m 
nmap <Leader>gc :Gcommit -m 
nmap <Leader>gd :Gdiff<CR>gg
nmap <Leader>gp :Gpush<CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gw :Gwrite<CR>

" Navigations between tabs
nnoremap H gT
nnoremap L gt

" Go to file under cursor
"current new tab
nnoremap gf <c-w>gf
"vertical split
nnoremap gF :vertical wincmd f<CR>
"current window
nnoremap gO gf

" Go to definition made easier for JS files using Ag
"current new tab
nnoremap <silent> gj lbve"by:tabe<CR>:AgNoLoc '(export) (?:.+ .+ <C-r>b[ (]\|.+ <C-r>b[ (]\|<C-r>b )'<CR>:if (line('$') == 1)<CR>tabclose<CR>endif<CR>
"vertical split
nnoremap <silent> gJ lbve"by:vnew<CR>:AgNoLoc '(export) (?:.+ .+ <C-r>b[ (]\|.+ <C-r>b[ (]\|<C-r>b )'<CR>:if (line('$') == 1)<CR>bd<CR>endif<CR>
"current window
nnoremap gO lbve"by:AgNoLoc '(export) (?:.+ .+ <C-r>b[ (]\|.+ <C-r>b[ (]\|<C-r>b )'<CR>

" Search and replace
nnoremap <F2> lbve"by:call FileReplaceIt()<cr>
vnoremap <F2> "by:call FileReplaceIt()<cr>
nnoremap <F12> :call MassReplaceIt()<cr>
vnoremap <F4> :<C-u>call VisReplaceIt()<cr>


" Fix register copy/pasting
nnoremap <silent> DD "0dd:let @*=@0<cr>
vnoremap <silent> D "0d:let @*=@0<cr>
nnoremap d "_d
nnoremap dd "_dd
vnoremap d "_d
nnoremap s "_s
vnoremap s "_s
nnoremap c "_c
vnoremap c "_c
nnoremap x "_x
vnoremap x "_x
vnoremap p "*p
vnoremap P "0p

" Paste on new line
nnoremap ,p o<Esc>p
nnoremap ,P O<Esc>p

" Insert-Paste from * reg
inoremap <C-r> <C-r>*
" Insert-Paste from other register
inoremap <C-e> <C-r>

" Move tab left and right
nnoremap th :tabm -1<cr>
nnoremap tl :tabm +1<cr>

" Save session
map <F7> :call SaveSession()<cr>

" Load previous session
map <F5> :call OpenSession()<cr>

" Search for word under cursor
nmap )) lbve"by:Ag! <C-r>b<cr>
vmap )) "by:Ag! <C-r>b<cr>
"specify folder
nmap ) lbve"by:Ag! <C-r>b 
vmap ) "by:Ag! <C-r>b 

" Copy multiple words to register
nmap <Leader>8 lbve"ay
nmap <Leader>9 :let @a .= ', '<cr>lbve"Ay
nmap <Leader>0 "ap^\a

" Space to new line in vis selection
vmap K :<C-u>s@\%V @$%@g<cr>\b:s/$%/\r/g<cr>V`b=

" Indent correctly to the set mark(\a)
nmap <Leader>) V`a=

" Convert CamelCase/camelCase to NAMED_CONTANT
nmap <Leader>2 lbve:s#\%V\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<cr><C-o>veU
" Convert each NAME_LIKE_THIS to nameLikeThis in the current line.
nmap <Leader>3 lbve:s#\%V_*\(\u\)\(\u*\)#\1\L\2#g<cr><C-o>vu

"ALE
"jump on next error
map <Leader>f <Plug>(ale_next_wrap)
map <Leader>F <Plug>(ale_previous_wrap)
"enable/disable
map <Leader>~ :ALEDisable<CR>

"Turn off highlighting until next search
nnoremap ? :noh<CR>
" Seach the copied content in file
nmap // /\V<C-r>*<cr>

" Set marker
nnoremap \ m

" Move to the next word as the one under cursor
nmap m *
vmap m *
nmap M #
vmap M #

" Macro mappings
nmap <Leader>e @e
nmap <Leader>r @r
vmap <Leader>e :normal @e<CR>
vmap <Leader>r :normal @r<CR>

"Mundo (undo history) toggle
nnoremap <F1> :MundoToggle<CR>

"Silver searcher
nnoremap <F3> :Ag! -F<SPACE>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Center page when moving up or down
nnoremap <C-d> <C-d>z.
nnoremap <C-u> <C-u>z.

"Reload vimrc
nnoremap <Leader>` :so ~/.vimrc<CR>
""" MAPPINGS END
