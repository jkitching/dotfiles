" -------- General --------------------------------------------------------

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set grepprg=grep\ -nH\ $*
set mouse=a
filetype plugin indent on

" visual options
set number
syntax on
colorscheme ron
set t_Co=8 " disable 256-color support

" set searching
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Enter> :nohlsearch<Bar>:echo<CR>

" W writes with sudo privileges
command W w !sudo tee % > /dev/null

" return to last line and character in file when opened
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" insert date
iab dts <C-R>=strftime("%c")<CR>

" automatically give executable permissions if file begins with #!
" and contains '/bin/' in the path
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile>

" -------- Prolog --------------------------------------------------------

"autocmd BufNewFile,BufRead ~/school/cs312/*.pl set filetype=prolog
"autocmd BufNewFile,BufRead ~/school/cs312/*/*.pl set filetype=prolog

" -------- Haskell -------------------------------------------------------

autocmd BufRead,BufNewFile *.hs,*.lhs set tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent

" -------- Python --------------------------------------------------------

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufRead,BufNewFile *.py,*.html set tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.py,*.html set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class  
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

command! -nargs=1 Tab call s:SetTabs('<args>')
function s:SetTabs(width)
  exec "set tabstop=" . a:width
  exec "set shiftwidth=" . a:width
  exec "set softtabstop=" . a:width
  exec "set expandtab"
endfunction

autocmd BufReadPost *.php,*.module,*.install,*.theme,*.test set syntax=php filetype=php
autocmd BufReadPost *.php,*.module,*.install,*.theme,*.test Tab 2

set tags+=$HOME/.vim/tags/python.ctags

"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF

" -------- LaTeX --------------------------------------------------------

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
au BufEnter *.tex set autowrite "Save before making PDF"
let g:tex_flavor = 'latex'
let g:Tex_ViewRule_dvi = 'evince'
let g:Tex_ViewRule_ps = 'evince'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,ps,pdf'
let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -t letter -o $*.ps $*.dvi'
let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi'
"let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'

" -------- ctags/taglist --------------------------------------------------------

" don't show variables for php!
let tlist_php_settings = 'php;c:class;f:function'
" let Tlist_Sort_Type = "name"
:nmap <F3> :TlistToggle<cr>
" allow file to be open without saving
set hidden

" tab options
nmap <C-H> :tabprev<CR>
nmap <C-L> :tabnext<CR>
