" ===== MISC =====

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Disable compatible mode
set nocp

" Auto change directory to file location
autocmd VimEnter * silent! lcd %:p:h

" Enable line numbers
:set number

" Disable viewport wrapping
:set nowrap

" Set copy/paste to use system clipboard
:set clipboard=unnamedplus

" Allow buffer switching with unsaved changes
:set hidden

" Reduce updatetime (useful for vim-gitgutter)
:set updatetime=100

" Set search to use case sensitivity only when caps in search term
:set ignorecase
:set smartcase

" Set sign column to always show (so it doesn't pop in and out depending on whether
" there's signs)
:set signcolumn=yes

" Highlight searches
:set hlsearch

" Show searches incrementally
:set incsearch

" Set tab size
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set expandtab

" Set side scrolling to work 'normally'
set sidescroll=1

" Set highlighting for trailing whitespace
highlight link ExtraWhitespace Error
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Set textwidth (should only be used for comments or certain file types)
set textwidth=88

" Set comment formatting options
set formatoptions=cro

" Enable automatic newlines after 90 chars for some file types
augroup TextWidthTypes
	autocmd!
	autocmd FileType tex,plaintex,mail,markdown,text set formatoptions+=t
augroup END

autocmd FileType mail,markdown,text set spell

" Run ctags on C file changes
autocmd BufWritePost *.c,*.h silent! !ctags . &

" Relative line numbers
set number relativenumber

" Disable double spaces after punctuation
set nojoinspaces

" ====== KEYBINDINGS =====

" Set leader
let mapleader = "\<Space>"

" LaTeX and BibTeX mappings and commands
command BuildLaTeX execute "!PDF_FILE=$(echo % \| sed 's/tex$/pdf/') && mkdir -p out && pdflatex --output-directory=out %"
command BuildBibLaTeX execute "!biber --input-directory=out --output-directory=out $(echo % \| sed -E 's/\.(tex\|bib)$//')"
command ViewLaTeX silent execute "!zathura out/$(echo % \| sed 's/tex$/pdf/') & disown"
command SpellCheckLaTeX execute "!aspell --lang=en --mode=tex --home-dir=. --personal=spelling.txt check %"
autocmd FileType tex,plaintex nnoremap <buffer> <silent> W :w<CR> :SpellCheckLaTeX<CR> :BuildLaTeX <CR><CR> :e!<CR> :redraw!<CR>
autocmd FileType tex,plaintex nnoremap <buffer> <silent> B :w<CR> :BuildBibLaTeX<CR><CR> :e!<CR> :redraw!<CR>

" Python/ipynb bindings
autocmd FileType python nnoremap <buffer> W :w<CR> :silent !qutebrowser :reload<CR> :redraw!<CR>
autocmd FileType python nnoremap <buffer> <Leader>q :!python $(echo % \| sed 's/ipynb$/py/')<CR>

" Move around splits
nnoremap <silent> <Leader><Right> <c-w>l
nnoremap <silent> <Leader><Left> <c-w>h
nnoremap <silent> <Leader><Up> <c-w>k
nnoremap <silent> <Leader><Down> <c-w>j

" Map Enter and Shift-Enter to insert newlines without entering edit mode
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>

" Map move line up/down around
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==

" Open fzf
nnoremap <silent> <Leader>, :Files<CR>
noremap <silent> <Leader>. :Rg<CR>

" Open/close NERDTree
nnoremap <silent> <Backspace> :NERDTreeFocus<CR>
autocmd FileType nerdtree nnoremap <buffer> <silent> <Backspace> :NERDTreeClose<CR>

" Display open buffers
" nnoremap <Leader><tab> :call feedkeys(":b \<Tab>", "tn")<CR>

" Cycle open buffers
nnoremap <silent> <tab> :BufMRUNext<CR>
nnoremap <silent> <S-tab> :BufMRUPrev<CR>

" Jump list
nnoremap <silent> <C-k> <C-i>
nnoremap <silent> <C-b> <C-o>

" ====== PLUGINS (vim-plug) ======
filetype plugin on

call plug#begin("~/.vim/plugged")

Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'fisadev/vim-isort'
Plug 'goerz/jupytext.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-python/python-syntax'
Plug 'preservim/nerdtree'
Plug 'mildred/vim-bufmru'

call plug#end()

" --- PLUGIN airline ---
let g:airline_theme = 'codedark'
let g:airline_section_z = '%p%% %#__accent_bold#L:%l/%L%#__restore__# C:%v R:%{strlen(@")}'

" Enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_filetype_ovirrides = { 'minibufexpl': ['MiniBufExplorerrrr', ''] }

" --- PLUGIN ALE ---
let g:ale_linters_explicit = 1
let g:ale_linters = {
	\ 'python': ['mypy', 'flake8'],
	\ 'tex': ['chktex'],
	\ 'c': ['gcc'],
	\ 'lisp': ['sbcl --script']
\}

let g:ale_sign_error = "ER"
let g:ale_sign_warning = "WA"
let g:ale_sign_info = "IN"
let g:ale_sign_style_error = "SE"
let g:ale_sign_style_warning = "SW"

" Set sign highlighting
highlight link ALEErrorSign Error
highlight link ALEStyleErrorSign Error
highlight link ALEWarningSign WarningMsg
highlight link ALEStyleWarningSign Todo

" Set highlighting (:hi to see all avail)
highlight link ALEError Error
highlight link ALEWarning Error
highlight link ALEInfo Todo
highlight link ALEStyleError Error
highlight link ALEStyleWarning Error

" --- PLUGIN isort ---
" Run on Python file save
autocmd BufWritePre *.py silent! execute ':Isort'

" --- PLUGIN jupytext ---
let g:jupytext_fmt = "py"

" --- PLUGIN black ---
" Configure Black to run on Python file save
autocmd BufWritePre *.py silent! execute ':Black'

" --- PLUGIN vim-code-dark ---
colorscheme codedark

" --- PLUGIN python-syntax ---
" Enable more complex python syntax highlighting with vim-python/python-syntax
let g:python_highlight_all = 1

" --- PLUGIN jedi-vim ---
" Turn off docstring popup during completion
" (stop nauseating jumping when opening windows like
" jedi-vim docstring window)
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal splitbelow

" --- PLUGIN NERDTree ---
let g:NERDTreeQuitOnOpen = 1
