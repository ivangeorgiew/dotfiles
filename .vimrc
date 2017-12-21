"COMMENTS region
" (?!(?:badword|second|\*)) search for not one of these words/characters
" ; to repeat f/t (, to reverse it)
" C-g/C-t to go to next match while / searching

" Macro
" qe...q (e can be any letter)
" qE...q to append (E can be any letter)
" :let @e='<c-r><c-r>e then edit and append '<CR>

"Emmet
"to use type <c-z>,

"Mundo (undo history)
"press V for vimdiff

"Gstatus (vim-fugitive) commands in vim
" [ ] - move between files
" - - adds/removes file to commit
" U - removes file changes
" dp - show changes to uncommited files
" D - open file with Gdiff
" p - stash -p

" commentary.vim
" gcc - comment line (takes number as well)

"Increment and Decrement numbers commands
"X to increment, <C-x> to decrement

" Mappings for vim-surround (* = [',",{,tag,...])
" ys* - add surrounds for word
" S* - add surrounds motion
" cs* - change surrounds
" ds* - delete surrounds
" S* - add surrounds in visual mode

" Go back to previous location <C-o>
" Go to next location<C-i>

" :e! to reload file
" <C-w> in command line deletes word backwards

"<leader>o - close all buffers except the one you're in

"Vimdiff
"<leader>1 - toggle vimdiff for vertsplit
"du - re-scan the files for differences
"do - diff obtain (2 windows)
"dp - diff put (2 windows)
"dh - get code from left (3 windows)
"dl - get code from right (3 windows)
"<leader>[ - next difference
"<leader>] - previous difference

"To enable Indent Guides use <leader>ig

"Completion
"<C-x><C-l> line completion
"<C-x><C-f> filename completion
"<C-x><C-o> omnicompletion
"<C-n> normal completion
"<C-y> selected value and close completion
"<C-e> initial value and close completion

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

" EasyClip - Built-in fixes for incorrect actions
" Automatically indents - if not correct use <leader>ff
" r(motion) - replace with * buffer
" "ar(motion) - replace with 'a' buffer
" C-f/C-n - after paste choose previous or next yank

" Convert words
" snake_case (crs),
" MixedCase (crm),
" camelCase (crc),
" snake_case (crs),
" UPPER_CASE (cru),
" dash-case (cr-),
" dot.case (cr.),
" space case (cr<space>),
" Title Case (crt)

" Subvert words
" :%S/old_word{,s}/new_word{,s}/gc

" auto-pairs
" <C-&> toggle auto-pairs
" There are alot more settings in the github page
" deleting the first character of a pair deletes the whole pair
" space and enter add niceness
" pressing twice the symbol doest add two pairs (YAY)
" don't add closing pair when needed

" Folding
" custom markers for compatibility with WebStorm
" to leave non-empty comments upon fold deletion - change parameter 0 to 1 in mappings DeleteFold and DeleteAllFolds
" zd - delete fold
" zD - delete all folds
" Z - toggle fold || create fold(vis selection)
" zj/zk - move between folds
"COMMENTS endregion

"MISC region
" Add pathogen execution on startup
execute pathogen#infect()
execute pathogen#helptags()

colorscheme gruvbox
"MISC endregion

"SET region
" Fix lag in vim
set shell=bash
set lazyredraw
set nocursorcolumn
set synmaxcol=500
set re=1
" syntax sync minlines=128
" set colorcolumn=120  " slows alot

" Affects lag
set cursorline

" Common
set smartcase
set noignorecase
set noantialias
set scroll=10                              " Set scroll lines
set nocompatible                           " Use Vim settings, rather then Vi settings
set nobackup                               " dont make backups
set nowritebackup                          " dont make backups
set noswapfile                             " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set showcmd                                " display incomplete commands
set autowrite                              " Automatically :write before running commands
set clipboard=unnamed                      " Copy/paste to/from clipboard by default
set sessionoptions=curdir,tabpages,winsize " save only this information in session
set nojoinspaces                           " Only one space when joining lines
set list listchars=tab:»·,trail:·          " show trailing whitespace
set virtualedit=block                      " allow cursor to move where there is no text in v-block
set breakindent                            " wrapped line continues on the same indent level
set timeoutlen=500                         " waittime for second mapping
set viminfo='20,s100,h,f0,n~/.vim/.viminfo " file to store all the registers
set nohlsearch                             " hightlight search
set wrapscan                               " incsearch after end of file

" Folding
set foldmethod=marker           " faster folds, created with Z
set foldlevelstart=0            " all folds folded initially
set foldmarker=region,endregion " markers for folding

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
set completeopt=menu,menuone,longest,preview
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
"SET endregion

"AUGROUP region
" augroup vimrc-incsearch-highlight
"     au!
"     au CmdlineEnter /,\? :set hlsearch
"     au CmdlineLeave /,\? :set nohlsearch
" augroup END

augroup syntax
    au!

    ""Indent Guides colors
    "au VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=Red
    "au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Yellow

    "Wrap character color
    au VimEnter,Colorscheme * :hi! NonText ctermfg=Red

    " Switch syntax for strange file endings
    au BufNewFile,BufRead *.ejs set filetype=html
    au BufNewFile,BufRead *.babelrc set filetype=json
    au BufRead,BufNewFile *.sass setfiletype sass
    au BufNewFile,BufRead *.eslintrc set filetype=json
augroup END

augroup UltiSnips
    au!

    au! User UltiSnipsEnterFirstSnippet
    au User UltiSnipsEnterFirstSnippet call autocomplete#setup_mappings()
    au! User UltiSnipsExitLastSnippet
    au User UltiSnipsExitLastSnippet call autocomplete#teardown_mappings()
augroup END

augroup vimrcEx
    au!

    " Show characters over 120 columns
    au BufEnter *.js highlight OverLength ctermbg=Red guibg=#592929
    au BufEnter *.js match OverLength /\%121v.*/

    " vim-stay Remove saved .vim/view files older than 5 days
    au VimLeavePre * CleanViewdir! 2

    " Set format options
    au BufEnter * set formatoptions=cq

    " Ask whether to save the session on exit
    au VimLeavePre * call SaveSession()
augroup END
"AUGROUP endregion

"SETTINGS region
" Leader
let g:mapleader = ' '

" variable for ToggleWrapscan function
let g:wrapscanVariable = 1

" Change NERDTree mappings
let g:NERDTreeMapOpenInTab='<C-t>'
let g:NERDTreeMapOpenInTabSilent='<C-r>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeWinSize=40
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['node_modules', '.git', '.DS_Store']

" Indent Guides settings
" let g:indent_guides_guide_size = 1
" let g:indent_guides_auto_colors = 0

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
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0

"The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Custom ctlp mapping
    " let g:ctrlp_map = '<C-p>'
    " Use Ag over Grep
    let g:grep_cmd_opts = '--line-numbers --noheading'

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_cmd='CtrlP :pwd'
    let g:ctrlp_user_command = 'ag --hidden %s -l -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
let g:ag_prg = 'ag --column --nogroup --noheading --case-sensitive'

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
let g:ycm_key_list_stop_completion = ['<C-y>']
" completions include
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" remove preview window
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" enable ycm only in those filetypes
" let g:ycm_filetype_whitelist = { 'javascript.jsx': 1, 'css': 1, 'scss': 1, 'json': 1, 'cucumber': 1 }
" remove semantic competion in javascript
let g:ycm_filetype_specific_completion_to_disable = { 'javascript': 1 }
" etc
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_complete_in_comments = 1
let g:ycm_cache_omnifunc = 1
let g:ycm_use_ultisnips_completer = 0
let g:ycm_max_num_candidates = 10
let g:ycm_max_num_identifier_candidates = 5
" disable console logs
let g:ycm_show_diagnostics_ui = 0
" Start vim faster
" let g:ycm_start_autocmd = 'CursorHold,CursorHoldI'

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

" EasyClip settings
let g:EasyClipAutoFormat = 1
let g:EasyClipAlwaysMoveCursorToEndOfPaste = 1
let g:EasyClipPreserveCursorPositionAfterYank = 1
let g:EasyClipUseSubstituteDefaults = 0
let g:EasyClipUseCutDefaults = 0
let g:EasyClipUsePasteToggleDefaults = 0

" Rooter
let g:rooter_patterns = ['pom.xml']
let g:rooter_silent_chdir = 1

" auto-pairs settings
let g:AutoPairsShortcutToggle = '<C-7>'
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsCenterLine = 0

" gruvbox
let g:gruvbox_bold = 0
let g:gruvbox_contrast_dark = 'medium'
"SETTINGS endregion

"FUNCTIONS region
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
        let expression = input('Enter expression:')
        call inputrestore()
    endif
    call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute '%sno@'.expression.'@'.replacement.'@gc'
endfunction

function! VisReplaceIt()
    call inputsave()
    let expression = input('Enter expression:')
    call inputrestore()
    call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute "%sno@\\%V".expression."@".replacement."@gc"
endfunction

function! MassReplaceIt()
    call inputsave()
    let expression = input('Enter expression:')
    call inputrestore()
    call inputsave()
    let replacement = input('Enter replacement:')
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

function! ToggleWrapscan()
    if g:wrapscanVariable == 0
        let g:wrapscanVariable = 1
        execute "set wrapscan"
        echo 'Wrapscan Enabled'
    else
        let g:wrapscanVariable = 0
        execute "set nowrapscan"
        echo 'Wrapscan Disabled'
    endif
endfunction

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

function! AddMarker(line, position)
    let string = ""
    let comments = split(&l:commentstring, '%s')
    let markers = split(substitute(&l:foldmarker, ' ', '', 'g'), ',')
    let lineNumber = getline(a:line) !~ comments[0] && a:position == 'close' ? a:line + 1 : a:line
    let oldLine = getline(lineNumber)
    let lineText = oldLine
    let lineText = substitute(lineText, "^.*" . escape(comments[0], '/\^$.*~[]&') . " \\=", "", "")
    let string .= substitute(comments[0], " ", "", "") . ' '
    let string .= a:position == 'close' ? markers[1] : markers[0]
    if oldLine !~ comments[0]
        if a:position == 'open'
            call inputsave()
            let b:foldAddedComment = input('Enter comment:', '')
            call inputrestore()
        endif
        let string .= ' ' . b:foldAddedComment
    endif
    if len(comments) > 1 &&  lineText !~ '\w\+'
        let string .= ' ' . comments[1]
    endif
    if a:position == 'open'
        if oldLine !~ comments[0]
            call setline(lineNumber, string)
            call append(lineNumber, oldLine)
        else
            call setline(lineNumber, string . ' ' . lineText)
        endif
    else
        if oldLine !~ comments[0]
            call append(lineNumber, string)
        else
            call setline(lineNumber, string . ' ' . lineText)
        endif
    endif
endfunction

function! MakeFold() range
    let first_line = a:firstline
    let last_line = a:lastline
    if first_line == last_line | return | endif
    call AddMarker(first_line, 'open')
    call AddMarker(last_line, 'close')
endfunction

function! DeleteFold(leaveComments)
    let comments = split(&l:commentstring, '%s')
    let markers = split(substitute(&l:foldmarker, ' ', '', 'g'), ',')

    let first_line = search(comments[0] . '.*' . markers[0] . '.*', "ncWb")
    let firstText = substitute(getline(first_line), ' ' . markers[0], '', 'g')
    if firstText =~ '\w\+' && a:leaveComments == 1
        call setline(first_line, firstText)
    else
        call search(getline(first_line), "cWb")
        execute ":d"
    endif

    let last_line = search(comments[0] . '.*' . markers[1] . '.*', "ncW")
    let lastText = substitute(getline(last_line), ' ' . markers[1], '', 'g')
    if lastText =~ '\w\+' && a:leaveComments == 1
        call setline(last_line, lastText)
    else
        call search(getline(last_line), "cW")
        execute ":d"
    endif
endfunction

function! DeleteAllFolds(leaveComments)
    let comments = split(&l:commentstring, '%s')
    let markers = split(substitute(&l:foldmarker, ' ', '', 'g'), ',')

    while search(comments[0] . ' ' . markers[0] . '.*', "c") > 0
        call DeleteFold(a:leaveComments)
    endwhile
endfunction

function! IndentWithI()
    if len(getline('.')) == 0 && empty(&buftype)
        return "\"_cc"
    else
        return "i"
    endif
endfunction
"FUNCTIONS endregion

"MAPPINGS region
" Main leader Mappings
noremap <silent> <leader>q :qall<CR>
noremap <silent> <leader>w :update<CR>
noremap <silent> <leader>d :bd<CR>
noremap <silent> <leader>t :tabclose<CR>

" indent everything
nnoremap <leader>I ggVG=

" Folding mappings
" Fold all
nnoremap zm zM
"Unfold all
nnoremap zn zR
"open/close fold
nnoremap Z za
"fold visual selection
vnoremap <silent> Z :call MakeFold()<CR>zc==
"delete fold
nnoremap <silent> zd zo$:call DeleteFold(0)<CR>^
"delete all folds
nnoremap <silent> zD zR:call DeleteAllFolds(0)<CR>

"NERDTree
noremap <F9> :NERDTreeFind<CR><C-W>=
noremap <F10> :NERDTreeToggle<CR><C-W>=

"X to increment
nnoremap X <C-a>

" Get off my lawn
nnoremap <Left>     :echoerr "Use h"<CR>
nnoremap <Right>    :echoerr "Use l"<CR>
nnoremap <Up>       :echoerr "Use k"<CR>
nnoremap <Down>     :echoerr "Use j"<CR>
nnoremap gt         :echoerr "use H or L"<CR>
nnoremap gT         :echoerr "use H or L"<CR>

"Vimdiff
"diff 2 buffers in vertical split
nnoremap <leader>1 :call ToggleDiff()<cr>
"close every buffer except the one you're in
nnoremap <leader>o :only<CR>
nnoremap <leader>[ ]czz
nnoremap <leader>] [czz
nnoremap du :diffupdate<CR>
nnoremap dh :diffget //2<CR>
nnoremap dl :diffget //3<CR>

"Git (vim-fugitive) mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Git log --pretty=oneline -10<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gc :call GitCommit()<CR>
" show merge conflicts
nnoremap <leader>gm :Gmerge<CR>

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

" (?!(?:badword|second|\*)) search for not one of these words/characters
nnoremap <silent> gj lbve"by:tabe<CR>:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>:if (line('$') == 1)<CR>call TabClose()<CR>endif<CR>
"vertical split
nnoremap <silent> gJ lbve"by:vnew<CR>:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>:if (line('$') == 1)<CR>bd<CR>endif<CR>
"current window
nnoremap go lbve"by:AgNoLoc '^(export) (?:var\|let\|const\|function\|class)(?:\*\| \* \| \*\| )(<C-r>b )'<CR>

" Search and replace
nnoremap <F2> :call FileReplaceIt(0)<cr>
vnoremap <F2> "by:call FileReplaceIt(1)<cr>
vnoremap <F4> :<C-u>call VisReplaceIt()<cr>
nnoremap <F12> :call MassReplaceIt()<cr>

" EasyClip
" cut
nmap D <Plug>MoveMotionPlug
xmap D <Plug>MoveMotionXPlug
nmap DD <Plug>MoveMotionLinePlug
" replace
nmap <silent> r <plug>SubstituteOverMotionMap
xmap r <plug>XEasyClipPaste
nmap <silent> R <plug>SubstituteToEndOfLine
nmap rr <plug>SubstituteLine
" change yank buffer
nmap <C-F> <plug>EasyClipSwapPasteForward
" EasyClip autoformats on paste, turn it off after paste if incorrect
nmap <leader>ff <plug>EasyClipToggleFormattedPaste
" Copy from *
imap <C-e> <plug>EasyClipInsertModePaste
cmap <C-e> <plug>EasyClipCommandModePaste
" Paste content before or after line
" use EasyClip's p command (that is why its nmap and not nnoremap)
nmap ,p o<Esc>p
nmap ,P O<Esc>p

" jk to exit insertmode
inoremap jk <ESC>

" Move tab left and right
nnoremap th :tabm -1<cr>
nnoremap tl :tabm +1<cr>

" Save session
noremap <silent> <F7> :call SaveSession()<cr>

" Load previous session
noremap <silent> <F5> :call OpenSession()<cr>

" Search for word under cursor
nnoremap ) lbve"by:Ag! <C-r>b<cr>
vnoremap ) "by:Ag! "<C-r>b"<cr>

" Copy multiple words to register
nnoremap <silent> <leader>8 lbve"ay
nnoremap <silent> <leader>9 :let @a .= ', '<cr>lbve"Ay
nnoremap <silent> <leader>0 o<Esc>"ap==^ma

" Space to new line in vis selection
vnoremap K :<C-u>s@\%V @$%@g<cr>mb:s/$%/\r/g<cr>V`b=:noh<CR>
nnoremap K mb^v$:<C-u>s@\%V @$%@g<cr>mb:s/$%/\r/g<cr>V`b=:noh<CR>

" Indent correctly to already set mark(\a)
nnoremap <leader>) V`a=

"ALE
"jump on next error
nmap <leader>an <Plug>(ale_next_wrap)
nmap <leader>aN <Plug>(ale_previous_wrap)
"fix errors automatically
nnoremap <leader>af :ALEFix<CR>
"enable/disable
nnoremap <leader>ae :ALEEnable<CR>
nnoremap <leader>ad :ALEDisable<CR>

"Incsearch
nnoremap <silent><expr> ? (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
nnoremap / /\V
vnoremap / "by/<C-r>b<cr>n
nnoremap // /<C-r>*<cr>n

"Toggle wrapscan
nnoremap <silent> <leader>s :call ToggleWrapscan()<CR>

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
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Center page when moving to next search
nnoremap n nzz
nnoremap N Nzz

" File manipulation "
cnoremap <expr> %% expand('%:h').'/'
" Open file for editing "
nmap <leader>fe :e %%
nmap <leader>ft :tabe %%
nmap <leader>fs :sav! %%
nmap <leader>fv :vsplit %%
" Rename current file "
nnoremap <leader>fr :call RenameCurrentFile()<cr>
" Move current file "
nnoremap <leader>fm :call MoveCurrentFile()<cr>
" Delete current file "
nnoremap <silent> <leader>fd :call delete(expand('%')) \| bdelete!<CR>

" import-js mappings
nnoremap <silent> <leader>ia :ImportJSWord<CR>\|:w<CR>
nnoremap <silent> <leader>if :ImportJSFix<CR>\|:w<CR>
nnoremap <silent> <leader>iF :ImportJSGoto<CR>

" vim-stay
nnoremap <leader>cv :CleanViewdir!<CR>

" Repeat last macro if in a normal buffer.
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Make using Ctrl+C do the same as Escape, to trigger autocmd
inoremap <C-c> <Esc>

" tabular + vim-cucumber mapping
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" don't go to the end of line char
vnoremap $ g_

" dont enter insert mode on new line
nnoremap o o<Esc>
nnoremap O O<Esc>

"smart indent when entering insert mode with i on empty lines
nnoremap <expr> i IndentWithI()
"MAPPINGS endregion
