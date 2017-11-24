""" COMMENTS"{{{
" (?!(?:badword|second|\*)) search for not one of these words/characters

" vim-table mode
" You can activate it with <leader>tm

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

" commentay.vim
" gcc - comment line (takes number as well)
" gc - toggle comment (takes motion i{ for example)

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
" <C-w> in command line deletes word backwards

"<leader>o - close all buffers except the one you're in

"Vimdiff
"<leader>1 - toggle vimdiff for vertsplit
"du - re-scan the files for differences
"do - diff obtain (2 windows)
"dp - diff put (2 windows)
"dl - get code from left (3 windows)
"dr - get code from right (3 windows)
"<leader>[ - next difference
"<leader>] - previous difference

"To enable Indent Guides use <leader>ig

"Folding
" zd - delete fold
" zE - delete all folds
" Z - toggle fold/ create fold
" zj/zk - move between folds

"Completion
"<C-x><C-l> line completion
"<C-x><C-f> filename completion
"<C-x><C-o> omnicompletion
"<C-n> normal completion
"<C-y> selected value and close completion
"<C-e> initila value and close completion

"Ctrl-p shortcuts
"<C-f> cycle between modes
"<C-d> search by filename only
"<C-z> mark mutliple files to be opened

"Tab close direction by default is to the right
"this is confusing since you open tabs to the right
"use TabClose() function instad of tabclose to solve this
""" COMMENTS"}}}

""" MISC"{{{
" Add pathogen execution on startup
execute pathogen#infect()
execute pathogen#helptags()

colorscheme gruvbox

"AG command
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
""" MISC"}}}

""" SET VALUES"{{{
" Fix lag in vim
set shell=bash
set lazyredraw
set nocursorcolumn
set synmaxcol=128
set re=1
" syntax sync minlines=128
" set colorcolumn=120  " slows alot

" Affects lag
set cursorline

" Common
set smartcase
set noignorecase
set noantialias
set scroll=10 " Set scroll lines
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup " dont make backups
set nowritebackup "dont make backups
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands
set clipboard=unnamed "Copy/paste to/from clipboard by default
set hlsearch "highlight matches
set diffopt+=vertical " vimdiff split direction
set sessionoptions=curdir,tabpages,winsize " save only this information in session
set nojoinspaces " Only one space when joining lines
set list listchars=tab:»·,trail:· "show trailing whitespace
set virtualedit=block " allow cursor to move where there is no text in v-block
set textwidth=120

" Folding
set foldmethod=manual "faster folds, created with zf
set foldlevelstart=0 "all folds folded initially

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

" Complete on the bottom of vim (:tabe /bla/ for example)
set wildmenu
set wildmode=longest:full,full

" insert completion
set completeopt=menuone,preview

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" For import aliases ( ../../../components => components)
set path=~/projects/entitlements/entitlements-web/app/js
set path+=~/projects/entitlements/entitlements-web/app/js/**
set path+=~/projects/entitlements/entitlements-web/**

"Silver searcher
if executable('ag')
    set grepprg=ag
endif

"vim-stay settings
set viewoptions=folds,cursor

" tags settings
set tags=./tags;
set statusline+=%{gutentags#statusline()}
""" SET VALUES"}}}

""" AUGROUP"{{{
augroup syntax
    au!

    "Indent Guides colors
    au VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=Red
    au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Yellow

    "Wrap character color
    au VimEnter,Colorscheme * :hi! NonText ctermfg=Red

    " Switch syntax for strange file endings
    au BufNewFile,BufRead *.ejs set filetype=html
    au BufNewFile,BufRead *.babelrc set filetype=json
    au BufRead,BufNewFile *.sass setfiletype sass
    au BufNewFile,BufRead *.eslintrc set filetype=json

    "ALE linting
    au BufNewFile,BufRead *.js ALEEnable
    au BufNewFile,BufRead *.json ALEEnable
    au BufNewFile,BufRead *.css ALEEnable
augroup END

augroup vimrcEx
    au!

    " Show characters over 120 columns
    autocmd BufEnter *.js highlight OverLength ctermbg=Red guibg=#592929
    autocmd BufEnter *.js match OverLength /\%121v.*/

    "Save on focus lost
    au FocusLost * :wa

    " Remove saved view session older than 5 days
    au VimLeavePre * CleanViewdir! 5

    " Set format options
    au BufEnter * set formatoptions=cq

    " Ask whether to save the session on exit
    au VimLeavePre * call SaveSession()

    " .vimrc folding
    au FileType vim set foldmethod=marker
augroup END
""" AUGROUP"}}}

""" GLOBAL"{{{
" Change NERDTree mappings
let g:NERDTreeMapOpenInTab='<C-t>'
let g:NERDTreeMapOpenInTabSilent='<C-r>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeWinSize=40
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['node_modules', '.git']

" Indent Guides settings
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

"Emmet settings
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx' } }
let g:user_emmet_leader_key='<C-z>' "<C-z>, to activate

"Mundo (undo history) settings
let g:mundo_width = 40
let g:mundo_preview_height = 25
let g:mundo_preview_bottom = 1
let g:mundo_close_on_revert = 1

" have jsx highlighting/indenting work in .js files as well
let g:jsx_ext_required = 0

" ALE configurations
let g:ale_linters = {'javascript': ['eslint'], 'css': ['stylelint'], 'json': ['jsonlint']}
let g:ale_fixers = {'javascript': ['eslint'], 'css': ['stylelint'], 'json': ['jsonlint']}
let g:ale_lint_on_enter = 1
let g:ale_enabled = 0
let g:ale_lint_on_text_changed = 'never'

"The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    let g:grep_cmd_opts = '--line-numbers --noheading'

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag --hidden %s -l -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0

    " Ctrlp looks in directory you opened vim in
    let g:ctrlp_working_path_mode = 0
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
let g:ag_prg = 'ag --column --nogroup --noheading'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_section_y = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme = 'gruvbox'
let g:airline_symbols.space = "\ua0"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Arrow for wrapped text
if has('linebreak')
    let &showbreak='⤷ '
endif

" Gutentags settings
let g:gutentags_project_root = ['package.json']
let g:gutentags_generate_on_empty_buffer = 1
""" GLOBAL"}}}

""" FUNCTIONS"{{{
function! TabClose()
  if winnr("$") == 1 && tabpagenr("$") > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
    tabclose | tabprev
  else
    q
  endif
endfunction

function! OnNoVarDefinition(type)
    if (line('$') == 1)
        if (a:type == 'tab')
            call TabClose()
        else
            bd
        endif
    endif
endfunction

function! GitCommit()
    call inputsave()
    let message = input('Message: ')
    call inputrestore()
    if message == ''
        let message = 'update'
    endif
    exec ':Gcommit -m "' . message . '"'
endfunction

function! MoveCurrentFile()
    let old_destination = expand('%:p:h')
    let filename = expand('%:t')
    call inputsave()
    let new_destination = input('New destination: ', expand('%:p:h'), 'file')
    call inputrestore()
    if new_destination != '' && new_destination != old_destination
        exec ':saveas ' . new_destination . '/' . filename
        exec ':silent !rm ' . old_destination . '/' . filename
        redraw!
    endif
endfunction

function! RenameCurrentFile()
    let old_name = expand('%')
    call inputsave()
    let new_name = input('New file name: ')
    call inputrestore()
    if new_name != '' && new_name != old_name
        if expand('%:e') != '' && new_name !~ '\.'
            exec ':saveas ' . expand('%:h'). '/' . new_name . '.' . expand('%:e')
        else
            exec ':saveas ' . expand('%:h'). '/' . new_name
        endif
        call delete(old_name)
        redraw!
        exec ':e!'
    endif
endfunction

function! SaveSession()
    let dirPath = fnamemodify('%', ':~:h:t')
    if expand('%:p') =~ "projects"
        let choice = confirm('Save Session ?',"&Yes\n&No", 1)
        if choice == 1
            execute 'mksession! ~/vim_session/'.dirPath
        endif
    endif
endfunction

function! OpenSession()
    let dirPath = fnamemodify('%', ':~:h:t')
    let file = '~/vim_session/'.dirPath
    if glob(file)!=#""
        execute 'source '.file
    endif
endfunction

function! FileReplaceIt(visual)
    let expression = @b
    if a:visual == 0
        call inputsave()
        let expression = input('Enter expression: ')
        call inputrestore()
    endif
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
""" FUNCTIONS"}}}

""" MAPPINGS"{{{
" Main leader Mappings
map <Space> <leader>
map <silent> <leader>q :qall<CR>
map <silent> <leader>w :update<CR>
map <silent> <leader>d :bd<CR>
map <silent> <leader>t :call TabClose()<CR>

"Folding mappings
"Fold all
nnoremap zm zM
"Unfold all
nnoremap zn zR
"open/close fold
nnoremap Z za
"fold visual selection
vnoremap Z zf

"Close insert mode
imap jk <Esc>

"NERDTree
map <F9> :NERDTreeFind<CR><C-W>=
map <F10> :NERDTreeToggle<CR><C-W>=

"X to increment
nnoremap X <C-a>

"r to redo instead of C-r
nnoremap r <C-r>

" Get off my lawn
nnoremap <Left>     :echoerr "Use h"<CR>
nnoremap <Right>    :echoerr "Use l"<CR>
nnoremap <Up>       :echoerr "Use k"<CR>
nnoremap <Down>     :echoerr "Use j"<CR>
nnoremap gt         :echoerr "use H or L"<CR>

" Copy whole file contents
map <leader>v gg^vGg_y

"Vimdiff
"diff 2 buffers in vertical split
nmap <leader>1 :call ToggleDiff()<cr>
"close every buffer except the one you're in
nmap <leader>o :only<CR>
nmap <leader>[ ]cz.
nmap <leader>] [cz.
nnoremap du :diffupdate<CR>
nnoremap dh :diffget //2<CR>
nnoremap dl :diffget //3<CR>

"Git (vim-fugitive) mappings
nmap <leader>gs :Gstatus<CR>
nmap <leader>gl :Git log --pretty=oneline -10<CR>
nmap <leader>gd <CR>:Gdiff<CR>
nmap <leader>gc :call GitCommit()<CR>

" Navigations between tabs
nnoremap H gT
nnoremap L gt

" Copy from *
inoremap <C-e> <Esc>:set paste<cr>a<C-r>*<Esc>:set nopaste<cr>a

" Yank till the end of the line
nnoremap Y yg_

" Screw that newline character
vnoremap $ g_

" Go to file under cursor
"current window
nnoremap go gf
"current new tab
nnoremap gf <c-w>gf
"vertical split
nnoremap gF :vertical wincmd f<CR>

" Go to definition made easier for JS files using Ag
"current new tab

" (?!(?:badword|second|\*)) search for not one of these words/characters
nnoremap <silent> gj lbve"by:tabe<CR>:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>:call OnNoVarDefinition('tab')<CR>
"vertical split
nnoremap <silent> gJ lbve"by:vnew<CR>:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>:call OnNoVarDefinition('buf')<CR>
"current window
nnoremap gO lbve"by:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>

" Search and replace
nnoremap <F2> :call FileReplaceIt(0)<cr>
vnoremap <F2> "by:call FileReplaceIt(1)<cr>
nnoremap <F12> :call MassReplaceIt()<cr>
vnoremap <F4> :<C-u>call VisReplaceIt()<cr>


" Fix register copy/pasting
nnoremap DD "*dd
nnoremap D "*d
vnoremap D "*d
nnoremap d "_d
nnoremap dd "_dd
vnoremap d "_d
nnoremap s "_s
vnoremap s "_s
nnoremap c "_c
vnoremap c "_c
nnoremap x "_x
vnoremap x "_x
vnoremap p "_c<Esc>:set paste<cr>a<C-r>*<Esc>:set nopaste<cr>


" Paste on new line
nnoremap ,p o<Esc>p
nnoremap ,P O<Esc>p

" Move tab left and right
nnoremap th :tabm -1<cr>
nnoremap tl :tabm +1<cr>

" Save session
map <silent> <F7> :call SaveSession()<cr>

" Load previous session
map <silent> <F5> :call OpenSession()<cr>

" Search for word under cursor
nmap )) lbve"by:Ag! <C-r>b<cr>
vmap )) "by:Ag! <C-r>b<cr>
"specify folder
nmap ) lbve"by:Ag! <C-r>b
vmap ) "by:Ag! <C-r>b

" Copy multiple words to register
nmap <leader>8 lbve"ay
nmap <leader>9 :let @a .= ', '<cr>lbve"Ay
nmap <leader>0 "ap^\a

" Space to new line in vis selection
nmap K \b:s@ @\r@g<CR>V`b=:noh<CR>
vmap K :<C-u>s@\%V @$%@g<cr>\b:s/$%/\r/g<cr>V`b=:noh<CR>

" Indent correctly to the set mark(\a)
nmap <leader>) V`a=

" Convert CamelCase/camelCase to NAMED_CONTANT
nmap <leader>2 lbve:s#\%V\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<cr><C-o>veU
" Convert each NAME_LIKE_THIS to nameLikeThis in the current line.
nmap <leader>3 lbve:s#\%V_*\(\u\)\(\u*\)#\1\L\2#g<cr><C-o>vu

"ALE
"jump on next error
map <leader>an <Plug>(ale_next_wrap)
map <leader>aN <Plug>(ale_previous_wrap)
"fix errors automatically
map <leader>af :ALEFix<CR>
"enable/disable
map <leader>ae :ALEEnable<CR>
map <leader>ad :ALEDisable<CR>

"Turn off highlighting until next search
nnoremap <silent> ? :noh<CR>
" Seach the copied content in file
nmap / /\V
nnoremap // :let @/='<C-r>*'<cr>n
vmap / /\V
vnoremap // "by:let @/='<C-r>b'<cr>n

" Set marker
nnoremap \ m

" Move to the next word as the one under cursor
nmap m *
vmap m *
nmap M #
vmap M #

" Macro mappings
" @*<CR> to apply macro in * for everyline in visual selection
vnoremap @ :normal @

" Mundo (undo history) toggle
nnoremap <F1> :MundoToggle<CR>

" Silver searcher
nnoremap <F3> :Ag! -F<SPACE>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Center page when moving up or down
nnoremap <C-d> <C-d>z.
nnoremap <C-u> <C-u>z.

" vim-stay remove files
nmap <leader>C :CleanViewdir!<CR>

" File manipulation "
cnoremap <expr> %% expand('%:h').'/'
" Open file for editing "
nmap <leader>fe :e %%
nmap <leader>fv :vsplit %%
nmap <leader>ft :tabe %%
" Rename current file "
nmap <leader>fr :call RenameCurrentFile()<cr>
" Move current file "
nmap <leader>fm :call MoveCurrentFile()<cr>
" Delete current file "
nmap <silent> <leader>fd :call delete(expand('%')) \| bdelete!<CR>

" Auto pairs
" ino ", "
" ino " ""<left>
" ino ', '
" ino ' ''<left>
" ino `, `
" ino ` ``<left>
" ino (, (
" ino ( ()<left>
" ino (<CR> (<CR>)<ESC>O
" ino [, [
" ino [ []<left>
" ino [<CR> [<CR>]<ESC>O
" ino {, {
" ino { {}<left>
" ino {<space> {  }<left><left>
" ino {<CR> {<CR>}<ESC>O
""" MAPPINGS"}}}
