set nocompatible
filetype off

"------------------------------------------------------------------------------
"                 ⭐ ⭐ ⭐ ⭐ Plugin Management ⭐ ⭐ ⭐ ⭐
"------------------------------------------------------------------------------
" set the runtime path to include Vim-Plug and initialize
call plug#begin('~/.vim/plugged')

" ⭐ Plugins that make vim sane
Plug 'tpope/vim-sensible', { 'commit': '2d60332fa5b2b1ea346864245569df426052865a' }
Plug 'tpope/vim-dispatch', { 'commit': '47729b7831421f20fa40a7d5b3e9b928faf18e75' }

" ⭐ Enhance Look and feel of vim
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline', { 'commit': 'b790fd212088c0c882f16416f07cbd6035882028' }
Plug 'scrooloose/nerdtree', { 'commit': '35953042fbf5535a7e905b52a6973c3f7f8a5536' }
Plug 'Yggdroot/indentLine', { 'commit': '4e4964d148f552bdec8c4271ed94d77eaa6c7543' }

" ⭐ Add useful key mappings and text objects to vim
Plug 'tpope/vim-unimpaired', { 'commit': '4afeced83cb6bf32ba508fd57ad7dc45c96478f3' }
Plug 'kana/vim-textobj-user', { 'commit': 'e231b65797b5765b3ee862d71077e9bd56f3ca3e' }
Plug 'kana/vim-textobj-indent', { 'commit': 'deb76867c302f933c8f21753806cbf2d8461b548' } " ai/ii
Plug 'gilligan/textobj-gitgutter', { 'commit': '4bcaa031fea6cb080e4824e75522273e6090f1b6' } " ah/ih
Plug 'bps/vim-textobj-python', { 'commit': '585c76d58f1a9c458c87471b072c9ad9eb159ae2' } " functions:ad/id, classes: ac/ic
Plug 'glts/vim-textobj-indblock', { 'commit': 'fe7031cb8cebe7ede82234fedb4959f51ad98fd7' } " ao/io
Plug 'Julian/vim-textobj-brace', { 'commit': 'b936fbd99e16dcc6e4d62d5e81a73d9ad37fd576' } " aj/ij
Plug 'thinca/vim-textobj-between', { 'commit': 'b4986c108a6c335d9619fc035b8c0d3f6f0b8183' } " af{char}/if{char}
Plug 'easymotion/vim-easymotion', { 'commit': '1a0244c90c3ff46219cf9597bb13662be4232407' }

" ⭐ Make it easier to find things in vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " NOTE: This will also install it on our CLI path"
Plug 'junegunn/fzf.vim', { 'commit': 'ce82e10630830bc37a50f706cc3b7216d24e5009' }
Plug 'mhinz/vim-grepper', { 'commit': '04d659c9e0a57e0c3e989069601d2a98df0386c4' }

" ⭐ Plugins that help with project specific editor config
Plug 'tpope/vim-projectionist', { 'commit': '3fbebc9bb611209218d3fb8e91e340e4b2f0e56b' }
Plug 'sgur/vim-editorconfig', { 'commit': '46f506fd2c31331aada4969c50c2b140c990f003' }

" ⭐ Plugins adding conveniences for common text editing tasks
Plug 'bronson/vim-trailing-whitespace', { 'commit': '4c596548216b7c19971f8fc94e38ef1a2b55fee6' }
Plug 'scrooloose/nerdcommenter', { 'commit': 'e679d8a34193d1ac93b98ed792cdde7c9b1104a1' }
Plug 'AndrewRadev/splitjoin.vim', { 'commit': '122e6702f9d75de64f320328f54d7408c28ff432' }
Plug 'cohama/lexima.vim', { 'commit': '85cfff9f7d16bd1ad76fcfedca6ab4982af6ba9d' }

" ⭐ Plugins giving polyglot completion, linting and testing support
Plug 'Valloric/YouCompleteMe', { 'commit': 'c209cdbbfcc90c9ab8fa078beb2fe668743b4d0e' }
Plug 'SirVer/ultisnips', { 'commit': '6fdc3647f72e0a1f321ea6bd092ecd01f7c187ba' }
Plug 'honza/vim-snippets', { 'commit': '62f46770378ab899f40c334de264ccd64dc2db57' }
Plug 'tpope/vim-endwise', { 'commit': '1f76f7a1aebac3510c0f6c7f28be5572ea56d19c' }
Plug 'w0rp/ale', { 'commit': 'c49ea1a5e336f9b9e31a8de362b42f33aa79eb95' }
Plug 'janko-m/vim-test', {  'commit': '062c489781c995f7e81103fec8a3c07bd2ff1f4b' }

" ⭐ Plugins to integrate git
Plug 'airblade/vim-gitgutter', { 'commit': 'c4301f9a103ac1429d05131e7debdac5eb6c4c23' }
Plug 'tpope/vim-fugitive', { 'commit': 'cde670ee81e4fd0945e97111d08a901788c3922b' }

" ⭐ Plugins to integrate python
Plug 'Konfekt/FastFold', { 'commit': '720b30fefdde2a4a55cf5a950ce12a069f625e30' }
Plug 'tmhedberg/SimpylFold', { 'commit': 'aa0371d9d708388f3ba385ccc67a7504586a20d9' }
Plug 'vim-scripts/indentpython.vim', { 'commit': '6aaddfde21fe9e7acbe448b92b3cbb67f2fe1fc1' }

" ⭐ Plugins to improve working with csv
Plug 'chrisbra/csv.vim', { 'commit': '14eb57c0e781daac16608216de11a8443bf0b4e9' }

" ⭐ Plugins to improve working with Markdown
Plug 'itspriddle/vim-marked', { 'commit': 'cbafedda5e9fdb21bff0d6c8946678882ad70fc0' }

call plug#end()
"------------------------------------------------------------------------------
" Enable syntax highlighting
let python_highlight_all=1
syntax enable

"------------------------------------------------------------
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (See mappings below to turn off highlighting)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


" Tell vim to lazily redraw the screen
:set lazyredraw

" Enable spell checking
"set spell spelllang=en_us

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
"

"----------------------------------------------------------
" Use the system clipboard
set clipboard=unnamed

"----------------------------------------------------------
" Enable Folding
set foldmethod=indent
set foldlevel=99

"---------------------------------------------------------
" PEP 8 indentation
au BufNewFile,BufRead *.py:
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" For full stack development
au BufNewFile,BufRead *.js,*.html,*.css:
    \ set tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

"----------------------------------------------------------
" Flag Bad Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"----------------------------------------------------------
" Tell AutoComplete (YCM) to go away when we're done with it
let g:ycm_autoclose_preview_window_after_completion=1
"----------------------------------------------------------
" PyMode Config
"----------------------------------------------------------
let g:pymode_rope_rename_bind = '<C-c>rr'

"----------------------------------------------------------
" Color Shceme
color dracula
" Highlight the current line
set cursorline

"----------------------------------------------------------
" ALE Settings
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'python': ['flake8', 'mypy', 'pylint']
\ }
let g:ale_fixers = {
\ 'python': ['isort', 'black'],
\ }
let g:ale_python_flake8_executable = 'poetry'
let g:ale_python_mypy_executable = 'poetry'
let g:ale_python_pylint_executable = 'poetry'
let g:ale_python_isort_executable = 'poetry'
let g:ale_python_black_executable = 'poetry'

"----------------------------------------------------------
" Configuration for vim-test
let test#strategy = "dispatch"


"-----------------------------------------------------------
" Customize How we Browse Files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1

"-----------------------------------------------------------
" Customize Grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']

"=============================================================================
"
"                  📍  📍  📍  📍  MAPPINGS 📍  📍  📍  📍
"
"=============================================================================

" First we set our leader key to the spacebar because it doesn't do anything
" useful by default in vim
let mapleader=' '
nnoremap <Space> <Nop>

"                        ---------------------------
"                        📍 NAVIGATION AND 🔎 SEARCH
"
"   NB: All mappings for navigating and finding stuff should begin with the
"       Ctrl key or using a two key g* operator.
"
"   Why: In vim, there are already a ton of predified maps built in. For
"   example, <C-V> starts visual block mode. Therefore we should only
"   override the Ctrl key mappings for esoteric keystrokes that we are
"   unlikely to ever want.

" Move between buffer splits with home Ctrl+hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use Fuzzy Finder to quickly bring up files
nnoremap <C-p> :<C-u>FZF<CR>
" Use vim-fzz to quickly bring up all sorts of things



" Find all instances of the current word using grepper
nnoremap g* :Grepper -cword -noprompt<CR><CR>
" An operator that you can follow with a motion
nmap gs <plug>(GrepperOperator)
" Find all instances of the current selection
xmap gs <plug>(GrepperOperator)
" Turn off search highlighting
nnoremap gh :set hlsearch!<CR>
" Toggle Listchars
nnoremap gl :set list!<CR>

" Navigate to definitions using Ctrl g
nnoremap <C-g>  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Toggle NERDTree with Ctrl n
nnoremap <C-n> :NERDTreeToggle<CR>

" Show Fugitive git status with Ctrl-s
nnoremap <C-s> :Gstatus<CR>

"                          -----------------------
"                          ➡️  Next and ⬅️  Previous
"
" Map stuff to call ALE like unimpaired does
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"                         -------------------------
"                         🤖 Automatic Formatting 📝
"
" NB: Mappings that modify text should have affinity for the <Leader> key as a
"     prefix.
"

" While in visual mode, repeat last change mad on every line in the current
" selection
xnoremap . :norm.<CR>

" Fix trailing whitespace
nnoremap <Leader>fw :FixWhitespace<CR>

"                ----------------------------------------------
"                "🤖 Automatic commpletiopn and snippets ⚡️ ✂️
"
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"                              ------------------
"                              ✏️  Text Objects ☑️ 
"

" Prevent bps/vim-textobj-python from conflicting with the vim-textobj-between
let g:textobj_python_no_default_key_mappings = 1
call textobj#user#map('python', {
      \   'class': {
      \     'select-a': '<buffer>ac',
      \     'select-i': '<buffer>ic',
      \     'move-n': '<buffer>]pc',
      \     'move-p': '<buffer>[pc',
      \   },
      \   'function': {
      \     'select-a': '<buffer>ad',
      \     'select-i': '<buffer>id',
      \     'move-n': '<buffer>]pd',
      \     'move-p': '<buffer>[pd',
      \   }
      \ })
