set nocompatible
set smartindent

set expandtab " convert tabs to spaces
set shiftwidth=4 " four spaces for a tab
set tabstop=4 

autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql

let mapleader=","

call pathogen#helptags()
call pathogen#infect()
syntax on
filetype plugin indent on


colorscheme jellybeans

set showcmd
autocmd BufEnter * silent! lcd %:p:h

set hlsearch
set incsearch

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " close Vim if NerdTree is the only one window


set backupdir=./.vim/backup,/tmp
set directory=./.vim/backup,/tmp

nnoremap <F5> :GundoToggle<CR>

hi Folded ctermfg=brown guifg=brown

hi User1 ctermbg=gray ctermfg=black guibg=gray guifg=black
hi User2 ctermbg=green ctermfg=gray guibg=green guifg=gray
hi User3 ctermbg=brown ctermfg=gray guibg=brown guifg=gray
hi User4 ctermbg=cyan ctermfg=gray guibg=cyan guifg=gray

set statusline=
set statusline +=%2*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
set statusline +=%1*\ %<%F%*            "full path
set statusline +=%1*%m%*                "modified flag
set statusline +=%1*%=%4*\ %l\ %*             "current line
set statusline +=%1*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%3*\ %P\ %*
"set statusline +=%2*0x%04B\ %*          "character under cursor

set laststatus=2

hi StatusLine ctermbg=1 ctermfg=15

autocmd FileType python set omnifunc=pythoncomplete#Complete


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" " Indent if we're at the beginning of a line. Else, do completion.
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


""""""""""""""""
" Folding
""""""""""""""""

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevel=20
    setl foldlevelstart=20
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,python,js normal zR

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
map <C-t> :TagbarToggle<CR>


let g:syntastic_python_checkers = ['flake8']

autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<CR>
