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

" Relative line numbers
set number relativenumber

" Disable double spaces after punctuation
set nojoinspaces

" ====== KEYBINDINGS =====

" Set leader
let mapleader = "\<Space>"

" Markown/pandoc bindings
command RenderPdf execute "!mkdir -p out && pandoc -d defaults.yml -o out/%:r.pdf %"
command ViewPdf silent execute "!zathura out/%:r.pdf & disown"
autocmd FileType markdown nnoremap <buffer> W :w<CR> :RenderPdf<CR><CR>

" Python/ipynb bindings
autocmd FileType python nnoremap <buffer> W :w<CR> :silent !qutebrowser :reload<CR> :redraw!<CR>
autocmd FileType python nnoremap <buffer> <Leader>q :!python $(echo % \| sed 's/ipynb$/py/')<CR>

" Move around splits
noremap <silent> <Leader><Right> <c-w>l
noremap <silent> <Leader><Left> <c-w>h
noremap <silent> <Leader><Up> <c-w>k
noremap <silent> <Leader><Down> <c-w>j

" Map Enter and Shift-Enter to insert newlines without entering edit mode
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>

" Map move line up/down around
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==

" Open fzf
nnoremap <silent> <Leader><Backspace> :Files<CR>
noremap <silent> <Leader>. :Rg<CR>

" Open/close NERDTree
nnoremap <silent> <Backspace> :NERDTreeFocus<CR> 
autocmd FileType nerdtree nnoremap <buffer> <silent> <Backspace> :NERDTreeClose<CR>

" Cycle open buffers
nnoremap <silent> <tab> :BufMRUNext<CR>
nnoremap <silent> <S-tab> :BufMRUPrev<CR>

" Jump list
nnoremap <silent> <Leader>v <C-i>
nnoremap <silent> <Leader>b <C-o>

" ====== PLUGINS (vim-plug) ======
filetype plugin on

call plug#begin("~/.vim/plugged")

Plug 'Yggdroot/indentLine'
Plug 'dhruvasagar/vim-table-mode'
Plug 'bhigginsuk/jupytext.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mildred/vim-bufmru'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-python/python-syntax'

call plug#end()

" --- PLUGIN airline ---
let g:airline_theme = 'codedark'
let g:airline_section_z = '%p%% %#__accent_bold#l:%l/%l%#__restore__# c:%v r:%{strlen(@")}'

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_filetype_ovirrides = { 'minibufexpl': ['minibufexplorerrrr', ''] }



" --- PLUGIN jupytext ---
let g:jupytext_fmt = "c"


" --- PLUGIN black ---
" configure black to run on python file save
autocmd bufwritepre *.py silent! execute ':black'

" --- PLUGIN vim-code-dark ---
colorscheme codedark

" --- PLUGIN python-syntax ---
" enable more complex python syntax highlighting with vim-python/python-syntax
let g:python_highlight_all = 1


" --- PLUGIN nerdtree ---
let g:NERDTreeQuitOnOpen = 1

" --- PLUGIN coc.nvim ---
let g:coc_global_extensions = [
    \'coc-pyright',
    \'coc-rust-analyzer',
    \'coc-json',
    \'coc-sh'
    \]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
 inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" My coc.nvim additions:

" Show signature help manually
inoremap <silent><expr> <F2> CocActionAsync('showSignatureHelp')

" Sort imports on Python file save
autocmd BufWritePre *.py,*.go silent! :OR


" --- PLUGIN ALE ---
"  MUST BE AT THE BOTTOM OF THE FILE
"  Else other plugins clear the highlight groups somehow
let g:ale_linters_explicit = 1
let g:ale_linters = {
	\ 'tex': ['chktex'],
	\ 'c': ['gcc'],
	\ 'lisp': ['sbcl --script']
\}

" Set signs/colours (:hi to see all highlight groups)
let g:ale_sign_error = "✘"
highlight link ALEErrorSign ErrorMsg
highlight link ALEError ErrorMsg

let g:ale_sign_warning = "⚠"
highlight link ALEWarningSign WarningMsg
highlight link ALEWarning ErrorMsg

let g:ale_sign_style_error = "⚐"
highlight link ALEStyleErrorSign ErrorMsg
highlight link ALEStyleError ErrorMsg

let g:ale_sign_style_warning = "⚐"
highlight link ALEStyleWarningSign WarningMsg
highlight link ALEStyleWarning WarningMsg

let g:ale_sign_info = "ℹ"
highlight link ALEInfo Todo

" --- PLUGIN indentLine ---
let g:indentLine_char = '|'


