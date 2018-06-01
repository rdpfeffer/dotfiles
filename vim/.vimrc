set nocompatible
filetype off
 
"-----------------------------------------------------------
" Plugin Management

" set the runtime path to include Vim-Plug and initialize 
call plug#begin('~/.vim/plugged')

" Use sensible defaults within vim
Plug 'tpope/vim-sensible', { 'commit': '2d60332fa5b2b1ea346864245569df426052865a' }

" Plugins to enhance VIM
Plug 'jnurmine/Zenburn', { 'commit': '2cacfcb222d9db34a8d1a13bb8bb814f039b98cd' }
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/', 'commit': 'a5dd717ac44223160ff84b13a1513e5a88615292' }
Plug 'scrooloose/nerdtree', { 'commit': '35953042fbf5535a7e905b52a6973c3f7f8a5536' }
Plug 'scrooloose/nerdcommenter', { 'commit': 'e679d8a34193d1ac93b98ed792cdde7c9b1104a1' }
Plug 'kien/ctrlp.vim', { 'commit': '564176f01d7f3f7f8ab452ff4e1f5314de7b0981' }

" Plugins giving completion and highlighting support
Plug 'Valloric/YouCompleteMe', { 'commit': 'e5b28f5c32fd34ebe05a8658e9e4c0d9ce831581' }
Plug 'vim-syntastic/syntastic', { 'commit': 'd17b98cff364730af34fd853fbbe4fbbae226a3d' }

" Plugins to integrate git
Plug 'airblade/vim-gitgutter', { 'commit': 'c4301f9a103ac1429d05131e7debdac5eb6c4c23' }
Plug 'tpope/vim-fugitive', { 'commit': 'cde670ee81e4fd0945e97111d08a901788c3922b' }

" Plugins to integrate python
Plug 'Konfekt/FastFold', { 'commit': '720b30fefdde2a4a55cf5a950ce12a069f625e30' }
Plug 'tmhedberg/SimpylFold', { 'commit': 'aa0371d9d708388f3ba385ccc67a7504586a20d9' }
Plug 'vim-scripts/indentpython.vim', { 'commit': '6aaddfde21fe9e7acbe448b92b3cbb67f2fe1fc1' }
Plug 'python-mode/python-mode', { 'branch': 'develop', 'commit': 'a92bfa476467822e5723edb689cb1e80c13da52d' }
Plug 'nvie/vim-flake8', { 'commit': '91818a7d5f5a0af5139e9adfedc9d00fa963e699' }

" Plugins to improve working with csv
Plug 'chrisbra/csv.vim', { 'commit': '14eb57c0e781daac16608216de11a8443bf0b4e9' }

" Plugins to improve working with Markdown 
Plug 'itspriddle/vim-marked', { 'commit': 'cbafedda5e9fdb21bff0d6c8946678882ad70fc0' }

call plug#end()
" Enable syntax highlighting
let python_highlight_all=1
syntax enable
 
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
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
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
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

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"----------------------------------------------------------
" Repeat last change mad on every line in the current
" selection
xnoremap . :norm.<CR>
"----------------------------------------------------------
" Enable Folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
"nnoremap <space> za
" Uncomment the following line if you want to see docstrings for folded code
" let g:SimpylFold_docstring_preview=1

"---------------------------------------------------------
" PEP 8 indentation
au BufNewFile,BufRead *.py:
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
" For full stack development
au BufNewFile,BufRead *.js, *.html, *.css:
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

"----------------------------------------------------------
" Flag Bad Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"----------------------------------------------------------
" Tell AutoComplete (YCM) to go away when we're done with it
let g:ycm_autoclose_preview_window_after_completion=1
"----------------------------------------------------------
" Map <leader>g to YCM's goto function 
let mapleader = ','
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"----------------------------------------------------------
" PyMode Config
"----------------------------------------------------------
let g:pymode_rope_rename_bind = '<C-c>rr'

"----------------------------------------------------------
" Color Shceme
colorscheme zenburn
" Set the color and show the cursor line in bold
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

"----------------------------------------------------------
" Syntastic Settings

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"-----------------------------------------------------------
" Customize How we Browse Files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1
" Start Nerdtree on startup!
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
