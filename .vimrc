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

" commentary.vim
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

" YouCompleteMe
" <C-space> - semantic completion
" <C-w> - remove word
" <C-y> - accept completion
""" COMMENTS"}}}

""" MISC"{{{
" Add pathogen execution on startup
execute pathogen#infect()
execute pathogen#helptags()

colorscheme gruvbox
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
set completeopt=longest,menuone,preview
set complete=.,t

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" In order for gf to work with import aliases ( ../../../components => components)
set path=~/projects/entitlements/entitlements-web/app/js
set path+=~/projects/entitlements/entitlements-web/app/js/**
set path+=~/projects/entitlements/entitlements-web/**

"Silver searcher
if executable('ag')
    set grepprg=ag
endif

"Vimdiff options
set diffopt+=vertical,iwhite " vimdiff split direction and ignore whitespace

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

augroup UltiSnips
    autocmd!
    autocmd! User UltiSnipsEnterFirstSnippet
    autocmd User UltiSnipsEnterFirstSnippet call autocomplete#setup_mappings()
    autocmd! User UltiSnipsExitLastSnippet
    autocmd User UltiSnipsExitLastSnippet call autocomplete#teardown_mappings()
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
" Leader
let g:mapleader = ' '

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
" let g:airline_section_y = ''
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

" YouCompleteMe settings
" keys
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
" completions include
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" remove preview window
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" etc
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_cache_omnifunc = 1
" Disable unhelpful semantic completions.
let g:ycm_filetype_specific_completion_to_disable = { 'gitcommit': 1 }

" UltiSnips
" keys
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
" directory
let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = ['ultisnips']
" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']
" needed for functions
""" GLOBAL"}}}

""" FUNCTIONS"{{{
function! TabClose()
  if winnr("$") == 1 && tabpagenr("$") > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
    tabclose | tabprev
  else
    q
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
            execute 'mksession! ~/.vim/session/'.dirPath
        endif
    endif
endfunction

function! OpenSession()
    let dirPath = fnamemodify('%', ':~:h:t')
    let file = '~/.vim/session/'.dirPath
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
    execute "%s@\\%V".expression."@".replacement."@gc"
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
nnoremap <silent> <leader>q :qall<CR>
nnoremap <silent> <leader>w :update<CR>
nnoremap <silent> <leader>d :bd<CR>
nnoremap <silent> <leader>t :call TabClose()<CR>

" indent everything
nnoremap <leader>I ggVG=
" select everything
nnoremap <leader>G ggVG

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
inoremap jk <Esc>

"NERDTree
noremap <F9> :NERDTreeFind<CR><C-W>=
noremap <F10> :NERDTreeToggle<CR><C-W>=

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
nnoremap gT         :echoerr "use H or L"<CR>

" Copy whole file contents
nnoremap <leader>v gg^vGg_y

"Vimdiff
"diff 2 buffers in vertical split
nnoremap <leader>1 :call ToggleDiff()<cr>
"close every buffer except the one you're in
nnoremap <leader>o :only<CR>
nnoremap <leader>[ ]cz.
nnoremap <leader>] [cz.
nnoremap du :diffupdate<CR>
nnoremap dh :diffget //2<CR>
nnoremap dl :diffget //3<CR>

"Git (vim-fugitive) mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Git log --pretty=oneline -10<CR>
nnoremap <leader>gw :Gwrite<CR>
"use only for merge conflicts
nmap <leader>gd <CR>:Gdiff<CR>
nnoremap <leader>gc :call GitCommit()<CR>

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
"current new tab
nnoremap gf <c-w>gf
"vertical split
nnoremap gF :vertical wincmd f<CR>
"current window
nnoremap gO gf

" Go to definition made easier for JS files using Ag
"current new tab

" (?!(?:badword|second|\*)) search for not one of these words/characters
nnoremap <silent> gj lbve"by:tabe<CR>:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>:if (line('$') == 1)<CR>call TabClose()<CR>endif<CR>
"vertical split
nnoremap <silent> gJ lbve"by:vnew<CR>:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>:if (line('$') == 1)<CR>bd<CR>endif<CR>
"current window
nnoremap go lbve"by:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>

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
noremap <silent> <F7> :call SaveSession()<cr>

" Load previous session
noremap <silent> <F5> :call OpenSession()<cr>

" Search for word under cursor
nnoremap ) lbve"by:Ag! <C-r>b<cr>
vnoremap ) "by:Ag! <C-r>b<cr>

" Copy multiple words to register
nnoremap <leader>8 lbve"ay
nnoremap <leader>9 :let @a .= ', '<cr>lbve"Ay
nnoremap <leader>0 "ap^ma

" Space to new line in vis selection
vnoremap K :<C-u>s@\%V @$%@g<cr>mb:s/$%/\r/g<cr>V`b=:noh<CR>
nnoremap K mb^v$:<C-u>s@\%V @$%@g<cr>mb:s/$%/\r/g<cr>V`b=:noh<CR>

" Indent correctly to the set mark(\a)
nnoremap <leader>) V`a=

" Convert CamelCase/camelCase to NAMED_CONTANT
nnoremap <leader>2 lbve:s#\%V\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<cr><C-o>veU
" Convert each NAME_LIKE_THIS to nameLikeThis in the current line.
nnoremap <leader>3 lbve:s#\%V_*\(\u\)\(\u*\)#\1\L\2#g<cr><C-o>vu

"ALE
"jump on next error
nmap <leader>an <Plug>(ale_next_wrap)
nmap <leader>aN <Plug>(ale_previous_wrap)
"fix errors automatically
nnoremap <leader>af :ALEFix<CR>
"enable/disable
nnoremap <leader>ae :ALEEnable<CR>
nnoremap <leader>ad :ALEDisable<CR>

"Turn off highlighting until next search
nnoremap <silent> ? :noh<CR>
" Seach the copied content in file
nnoremap / /\V
nnoremap // :let @/='<C-r>*'<cr>n
vnoremap / /\V
vnoremap // "by:let @/='<C-r>b'<cr>n

" Set marker
nnoremap \ m

" Move to the next word as the one under cursor
nnoremap m *
vnoremap m *
nnoremap M #
vnoremap M #

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

" File manipulation "
cnoremap <expr> %% expand('%:h').'/'
" Open file for editing "
nmap <leader>fe :e %%
nmap <leader>fv :vsplit %%
nmap <leader>ft :tabe %%
" Rename current file "
nnoremap <leader>fr :call RenameCurrentFile()<cr>
" Move current file "
nnoremap <leader>fm :call MoveCurrentFile()<cr>
" Delete current file "
nnoremap <silent> <leader>fd :call delete(expand('%')) \| bdelete!<CR>

" Auto pairs
ino ", "
ino " ""<left>
ino ', '
ino ' ''<left>
ino `, `
ino ` ``<left>
ino (, (
ino ( ()<left>
ino (<CR> (<CR>)<ESC>O
ino [, [
ino [ []<left>
ino [<CR> [<CR>]<ESC>O
ino {, {
ino { {}<left>
ino {<space> {  }<left><left>
ino {<CR> {<CR>}<ESC>O
""" MAPPINGS"}}}
