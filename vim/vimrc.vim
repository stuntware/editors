
" Behold the power of Vim!
set nocompatible


set history=50
set ruler
set showcmd
set incsearch

set showtabline=2
set laststatus=2
set cmdheight=2

set wildmenu
set wildmode=longest:full,full
set nomodeline

set nowrap
set number

set expandtab
set shiftwidth=4
set tabstop=8
set softtabstop=4
set autoindent                   
set shiftround                   
set textwidth=0

set completeopt=longest,menuone

set backspace=indent,eol,start

function! ShortHost()
    return  " • " . get(split(hostname(), '\.'), 0, hostname()) . " • "
endfunction

set statusline=\ \ \ %t\ %y%m\%r
set statusline+=%=%l\:%c\ %P\ of\ %L\  
set statusline+=%<%{ShortHost()}%*


if &t_Co > 2 || has("gui_running")
    colorscheme nebuladust
    syntax on
    set hlsearch
endif

map <silent><Leader><Tab> :call Switch()<CR>
map <silent> <Leader>t :tabnew<cr>
map <Leader>q :vsplit<CR>

function! Switch()
    
    let tc = tabpagenr('$')
    let bc = winbufnr(0)
    
    if ( bc > 0 )
        wincmd w
    endif
    if ( tc > 1 )
        tabnext
    endif

endfunction

if has("gui_running")  " Got GUI?

    "set guioptions-=T
    set guioptions-=L  
    set guioptions-=R
    set guioptions-=l
    set guioptions-=r
    set guioptions-=e 

    set columns=132
    set lines=40

    set cursorcolumn
    set cursorline
    au WinLeave * set nocursorline nocursorcolumn
    au WinEnter * set cursorline cursorcolumn

    set guifont=Andale\ Mono\ 12


    if has("gui_macvim")
        
        "A great combination for Macvim when OSX font smoothing betrays you.
        set guifont=Andale\ Mono:h16
        set noantialias
        
        set transparency=5 "Things are readable in the background, but muted enough not to distract.
        set fuoptions=maxvert,maxhorz "Full screen options
        set nobackup
        set noswapfile
        set lsp=3           " Line Pixel Spacing


    endif
    if has("gui_win32")
        set guifont=Consolas:h10
        set nobackup
        set noswapfile
    endif

    " Custom GUI Menus
    " Settings Menu
    menu Settings.Source\ vimrc  :source ~/.vimrc<cr>
    menu Settings.Edit\ vimrc    :ed ~/.vimrc<cr>
    menu Settings.Split\ vimrc   :sp ~/.vimrc<cr>
    menu Settings.Options        :options<cr>

    " Toggle Menu
    menu Toggle.Menu\ Bar     :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
    menu Toggle.Tool\ Bar     :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    
    amenu ToolBar.cs-button :colorscheme nebuladust<CR>
    amenu ToolBar.sy-button :so ~/.vim/after/syntax/objc.vim<CR>

endif  " end:Got GUI?


"set virtualedit=all
set autochdir

" Only do this part when compiled with support for autocommands.
" Factory stuff that works nice. aka: It ain't broke...
if has("autocmd")
    filetype plugin indent on

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
    au BufRead,BufNewFile *.swift set filetype=javascript
    au BufRead,BufNewFile *.cpp.txt set filetype=cpp
    au BufRead,BufNewFile *.h.txt set filetype=cpp
else
    set autoindent
endif

filetype plugin on


map <Leader><cr> :b 
map <Leader>a :call SyntaxAttr()<CR>

map <S-F4> ggVGg?  :syn on <CR>
map <F4> ggVGg?  :syn off <CR>
map <F2> :set ff=unix<CR><C-l>
map <S-F2> :set ff=dos<CR><C-l>


" Yeah, these maps are cheese.
"map <C-a> GVgg
map <S-F12> :source ~/.vimrc<cr>
map <C-F12> :sp ~/.vimrc<cr>
map <TAB> w
map <S-TAB> b
nnoremap <space> @q 

map <C-Down> zo
map <C-Up> zc
highlight Folded guibg=blue guifg=white
highlight FoldColumn guibg=blue guifg=white
"132 Column warning
"match ErrorMsg /\%>131v.\+/ 

"Audible bell has got to go!
set vb



