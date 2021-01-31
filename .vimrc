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
nnoremap <silent> <Leader><Backspace> :Files<CR>
noremap <silent> <Leader>. :Rg<CR>

" Open/close NERDTree
nnoremap <silent> <Backspace> :NERDTreeFocus<CR> 
autocmd FileType nerdtree nnoremap <buffer> <silent> <Backspace> :NERDTreeClose<CR>

" Cycle open buffers
nnoremap <silent> <tab> :BufMRUNext<CR>
nnoremap <silent> <S-tab> :BufMRUPrev<CR>

" Jump list
nnoremap <silent> <C-k> <C-i>
nnoremap <silent> <C-b> <C-o>

" ====== PLUGINS (vim-plug) ======
filetype plugin on

call plug#begin("~/.vim/plugged")

Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'goerz/jupytext.vim'
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

" --- plugin airline ---
let g:airline_theme = 'codedark'
let g:airline_section_z = '%p%% %#__accent_bold#l:%l/%l%#__restore__# c:%v r:%{strlen(@")}'

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_filetype_ovirrides = { 'minibufexpl': ['minibufexplorerrrr', ''] }



" --- plugin jupytext ---
let g:jupytext_fmt = "py"

" --- plugin black ---
" configure black to run on python file save
autocmd bufwritepre *.py silent! execute ':black'

" --- plugin vim-code-dark ---
colorscheme codedark

" --- plugin python-syntax ---
" enable more complex python syntax highlighting with vim-python/python-syntax
let g:python_highlight_all = 1


" --- plugin nerdtree ---
let g:NERDTreeQuitOnOpen = 1

" --- plugin coc.nvim ---
let g:coc_global_extensions = [
    \'coc-pyright',
    \'coc-rust-analyzer',
    \]

" use tab for trigger completion with characters ahead and navigate.
" note: use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ <sid>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" make <cr> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" use `[g` and `]g` to navigate diagnostics
" use `:cocdiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)

" goto code navigation.
nmap <silent> <leader>d <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" use k to show documentation in preview window.
nnoremap <silent> k :call <sid>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('dohover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight the symbol and its references when holding the cursor.
autocmd cursorhold * silent call CocActionAsync('highlight')

" symbol renaming.
nmap <leader>r <plug>(coc-rename)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s).
  autocmd filetype typescript,json setl formatexpr=cocaction('formatselected')
  " update signature help on jump placeholder.
  autocmd user cocjumpplaceholder call CocActionAsync('showsignaturehelp')
augroup end

" applying codeaction to the selected region.
" example: `<leader>aap` for current paragraph
xmap <leader>a  <plug>(coc-codeaction-selected)
nmap <leader>a  <plug>(coc-codeaction-selected)

" remap keys for applying codeaction to the current buffer.
nmap <leader>ac  <plug>(coc-codeaction)
" apply autofix to problem on the current line.
nmap <leader>qf  <plug>(coc-fix-current)

" map function and class text objects
" note: requires 'textdocument.documentsymbol' support from the language server.
xmap if <plug>(coc-funcobj-i)
omap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap af <plug>(coc-funcobj-a)
xmap ic <plug>(coc-classobj-i)
omap ic <plug>(coc-classobj-i)
xmap ac <plug>(coc-classobj-a)
omap ac <plug>(coc-classobj-a)

" remap <c-f> and <c-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
"  nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
"  inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
"  inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<left>"
"  vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
"  vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
"endif

" use ctrl-s for selections ranges.
" requires 'textdocument/selectionrange' support of language server.
nmap <silent> <c-s> <plug>(coc-range-select)
xmap <silent> <c-s> <plug>(coc-range-select)

" add `:format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" add `:fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" add `:or` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" add (neo)vim's native statusline support.
" note: please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" mappings for coclist
" show all diagnostics.
nnoremap <silent><nowait> <space>a  :<c-u>coclist diagnostics<cr>
" manage extensions.
nnoremap <silent><nowait> <space>e  :<c-u>coclist extensions<cr>
" show commands.
nnoremap <silent><nowait> <space>c  :<c-u>coclist commands<cr>
" find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Run on Python file save
autocmd BufWritePre *.py silent! :OR


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
