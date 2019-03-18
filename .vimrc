

"=========================================================================
" DesCRiption: 适合自己使用的vimrc文件，for Linux/Mac, GUI/Console
" Last Change: 2019年03月04日
" Version:     0.1
" Source:
"=========================================================================

" 加载插件配置文件
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

"-----------------------------------------------------------------
" 基础设置
"-----------------------------------------------------------------
if has('syntax') && !exists('g:syntax_on') | syntax enable | endif  " 开语法高亮
let g:python_highlight_all = 1           " 开启python的所有语法高亮，插件'hdima/python-syntax'
set showcmd                              " 右下角：n模式显示已输入命令；v模式显示选区范围
set showmode                             " 左下角的状态栏显示INSERT之类的字样
set nocompatible                         " 关闭 vi 兼容模式
colorscheme my_molokai                   " 设定配色方案, 其他备选  Monokai
set number                               " 显示行号
set cursorline                           " 突出显示当前行
set ruler                                " 打开状态栏标尺
set nobackup                             " 覆盖文件时不备份
set autochdir                            " 自动切换当前目录为当前文件所在的目录
set backupcopy=yes                       " 设置备份时的行为为覆盖
set ignorecase smartcase                 " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
" set nowrapscan                           " 禁止在搜索到文件两端时重新搜索
set incsearch                            " 输入搜索内容时就显示搜索结果
set hlsearch                             " 搜索时高亮显示被找到的文本
set noerrorbells                         " 关闭错误信息响铃
set novisualbell                         " 关闭使用可视响铃代替呼叫
set t_vb=                                " 置空错误铃声的终端代码
set showmatch                            " 插入括号时，短暂地跳转到匹配的对应括号
set matchtime=1                          " 短暂跳转到匹配括号的时间(单位秒)
set magic                                " 设置魔术
set hidden                               " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T                        " 隐藏工具栏
set guioptions-=m                        " 隐藏菜单栏
" set smartindent                          " 开启新行时使用智能自动缩进；适用C风格的语言，开启此选项，则以”#“开头的句子，无法用'>>'命令右缩进
set backspace=indent,eol,start           " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1                          " 设定命令行的行数为 1
set laststatus=2                         " 显示状态栏 (默认值为 1, 无法显示状态栏)
set timeout                              " mapping的时长限制
set timeoutlen=1000                      " 单位毫秒，默认值1000
set ttimeout                             " 收到键码串的时长限制，例如escape sequance
set ttimeoutlen=50                       " 察觉不到的小值，键码串必需50ms内收到，不然当断开处理
set nobackup                             " no backup files
set noswapfile                           " no swap(缓冲文件) files
set nowritebackup                        " only in case you don't want a backup file while editing
set noundofile                           " no undo files
au BufRead,BufNewFile * start            " 开vm即insert模式
au BufRead,BufNewFile * filetype detect  " 开vm即检查文件类型
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}3?\ %c:%l/%L%)\
                                         " 设置在状态行显示的信息
if has('mouse') | set mouse=a | endif    " 启用鼠标
noremap <C-n> :set invnumber<CR>|        " 开关行号

" if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " 插入模式改为细光标
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " 其他模式还是粗光标
" endif

map ᜪ <c-;>
map! ᜪ <c-;>
noremap <c-;> :|
inoremap <c-;> <c-o>:|                   " ctrl+; 开始命令模式
let mapleader = ','                      " 修改leader
"-----------------------------------------------------------------
" 折叠
"-----------------------------------------------------------------
set foldenable                           " 开始折叠
set foldmethod=syntax                    " 设置语法折叠
set foldcolumn=0                         " 设置折叠区域的宽度
setlocal foldlevel=1                     " 设置折叠层数为
" set foldclose=all                      " 设置为自动关闭折叠
" 用ctrl+=键来开关折叠
nnoremap <silent> <c-=> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <silent> <expr> <c-=> foldclosed(line('.')) < 0 ? 'zc' : 'zo'
inoremap <silent> <expr> <c-=> foldclosed(line('.')) < 0 ? '<c-o>zc' : '<c-o>zo'
" iterm2将 ctrl+= 映射成 ᜂ   vim再将其映射为<c-=>
map  ᜂ   <c-=>
map! ᜂ   <c-=>
"-----------------------------------------------------------------
" 路径设置
"-----------------------------------------------------------------
" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "windows"
    elseif has("unix")
        return "linux"
    endif
endfunction
" 用户目录变量$VIMFILES
if MySys() == "windows"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
    let $VIMFILES = $HOME.'/.vim'
endif
" 设定doc文档目录
let helptags=$VIMFILES.'/doc'
" 设置字体 以及中文支持
if has("win32")
    set guifont=Inconsolata:h12:cANSI
endif
"-----------------------------------------------------------------
" 配置多语言环境
if has("multi_byte")
    " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fileencoding=utf-8
    scriptencoding utf-8
    set fencs=utf-8,gbk
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
"-----------------------------------------------------------------
" 不同操作系统的文件格式下的换行符
            " dos     <CR> <NL>
            " unix    <NL>
            " mac     <CR>
set fileformats=unix,dos,mac
" 支持多种文件格式在vim中显示，进行自动检测:
"   全文无<NL>： 用mac格式
"   有<NL>,第一个 <NL>前有<CR>: 用DOS格式
"   有<NL>,第一个 <NL>前无<CR>: 用unix格式

" 用dos文件格式显示
nmap <leader>fd :set fileformat=dos<CR>
" 用unix文件格式显示
nmap <leader>fu :set fileformat=unix<CR>
"-----------------------------------------------------------------
" vim-airline   界面布局和配色
" 字体设置
set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h12
" 如果运行的不是GUI（即MacVim），才启用Airline的Powerline字符
if has('gui_running')
    " macvim 的滚动（scrollbar）条颜色不搭，关闭之
    set guioptions-=L
    set guioptions-=r
endif
let g:airline#extensions#tabline#enabled = 1      " 标签页栏美化
let g:airline#extensions#branch#enabled=1         " 显示 git 分支
" let g:airline#extensions#hunks#enabled=0
let g:airline_theme='badwolf'   " 'molokai'       ” 状态栏配色
let g:airline#extensions#tabline#show_buffers = 0 " 不显示已关tab的遗骸
let g:airline_powerline_fonts=1
"-----------------------------------------------------------------
"让vim记忆上次编辑的位置
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \   exe "normal g'\"" |
            \ endif
"-----------------------------------------------------------------
" help
nnoremap <c-h> :h<space>
vnoremap <c-h> :<c-u>h<space>
inoremap <c-h> <c-o>:h<space>
"-----------------------------------------------------------------
"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
" 关闭<c-b>按键，把它作为多种快捷键的leader
" nnoremap <expr> <esc> ''
" vnoremap <expr> <esc> ''
" inoremap <expr> <esc> ''

nnoremap <esc>.p :set filetype=python<CR>
vnoremap <esc>.p <esc>:set filetype=python<CR>gv
inoremap <esc>.p <c-o>:set filetype=python<cr>

nnoremap <esc>.c :set filetype=cpp<cr>
vnoremap <esc>.c <esc>:set filetype=cpp<cr>gv
inoremap <esc>.c <c-o>:set filetype=cpp<cr>

nnoremap <esc>.m :set filetype=matlab<cr>
vnoremap <esc>.m <esc>:set filetype=matlab<cr>gv
inoremap <esc>.m <c-o>:set filetype=matlab<cr>

nnoremap <esc>.s :set filetype=bash<cr>
vnoremap <esc>.s <esc>:set filetype=bash<cr>gv
inoremap <esc>.s <c-o>:set filetype=bash<cr>

nnoremap <esc>.0  :filetype detect<cr>
vnoremap <esc>.0  <esc>:filetype detect<cr>gv
inoremap <esc>.0  <c-o>:filetype detect<cr>
" i更多语言高亮：xhtml, css, javascript, php
"-----------------------------------------------------------------
" 语言专属设置
" 让 Tohtml 产生有 CSS 语法的 html
" syntax/2html.vim，可以用:runtime! syntax/2html.vim
let html_use_css=1
" 运行python代码
autocmd FileType python map <F12> :!python %<CR>
" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1
" 设置字典 ~/.vim/dict/文件的路径
autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
autocmd filetype php set dictionary=$VIMFILES/dict/php.dict



"=========================================================================
" 标签页、窗口、buffer操作
"=========================================================================
" 标签页
" alt+t 新开一空标签页
nnoremap  †   :tabnew<CR>
vnoremap  †   <esc>:tabnew<CR>v
inoremap  †   <c-o>:tabnew<CR>
" 开一个文件到新标签页
" <esc> alt+t
nnoremap <esc>†  :tabedit<space>
vnoremap <esc>†  <esc>:tabedit<space>
inoremap <esc>†  <c-o>:tabedit<space>
" shift+left 左一个标签页
nnoremap <S-Left> :tabprev<CR>
vnoremap <S-Left> <esc>:tabprev<CR>v
inoremap <S-Left> <c-o>:tabprev<CR>
" shift+right 右一个标签页
nnoremap <S-Right> :tabnext<CR>
vnoremap <S-Right> <esc>:tabnext<CR>v
inoremap <S-Right> <c-o>:tabnext<CR>
"-----------------------------------------------------------------
" alt  开文件
" alt+n  （需事先手动保存）关闭本buffer，并开一个新buffer
nnoremap  ᜩ  :bd\|enew<cr>
vnoremap  ᜩ  <esc>:bd\|enew<cr>
inoremap  ᜩ  <c-o>:bd\|enew<cr>
" <esc>ctrl+n  （需要事前手动保存）关闭本buffer，开一个文件到新buffer
nnoremap  <esc>ᜩ  :bd\|edit<space>
vnoremap  <esc>ᜩ  <esc>:bd\|edit<space>
inoremap  <esc>ᜩ  <c-o>:bd\|edit<space>
"-----------------------------------------------------------------
" ctrl+alt: buffer操作
"-----------------------------------------------------------------
" nnoremap ᜩ  :update<cr>:bd!|enew<cr>
" vnoremap ᜩ  <esc>:update<cr>:bd!|enew<cr>
" inoremap ᜩ  <c-o>:update<cr><c-o>:bd!|enew<cr>
" alt+ctrl+n  开一空白个新buffer
nnoremap ᜦ  :update<cr>:enew<cr>
vnoremap ᜦ  <esc>:update<cr>:enew<cr>
inoremap ᜦ  <c-o>:update<cr><c-o>:enew<cr>
" <esc>alt+crtl+n  开一个文件为新buffer
nnoremap <esc>ᜦ  :update<cr>:edit<space>
vnoremap <esc>ᜦ  <esc>:update<cr>:edit<space>
inoremap <esc>ᜦ  <c-o>:update<cr><c-o>:edit<space>
" alt+ctrl+b
nnoremap ᜧ  :update<cr>:buffers<cr>
vnoremap ᜧ  <esc>:update<cr>:buffers<cr>
inoremap ᜧ  <c-o>:update<cr><c-o>:buffers<cr>
" alt+ctrl+[
nnoremap ᜥ  :update<cr>:bnext<CR>
vnoremap ᜥ  <esc>:update<cr>:bnext<CR>
inoremap ᜥ  <c-o>:update<cr><c-o>:bnext<CR>
" alt+ctrl+]
nnoremap ᜣ :update<cr>:bprevious<CR>
vnoremap ᜣ <esc>:update<cr>:bprevious<CR>
inoremap ᜣ <c-o>:update<cr><c-o>:bprevious<CR>
" alt+ctrl+w 关闭当前buffer
nnoremap ᜨ :bd<CR>
vnoremap ᜨ <esc>:bd<CR>
inoremap ᜨ <c-o>:bd<CR>
"-----------------------------------------------------------------
" alt、ctrl+alt: 窗口操作
"-----------------------------------------------------------------
" 窗口分割
set splitright    " 默认开在右侧
" alt+\：垂直分割窗口
nnoremap « :vsp<cr>
vnoremap « <esc>:vsp<cr>v
inoremap «  <c-o>:vsp<cr>
" <esc> alt+\：垂直分割窗口 开文件
nnoremap <esc>« :vsp<space>
vnoremap <esc>« <esc>:vsp<space>
inoremap <esc>«  <c-o>:vsp<space>

set splitbelow  " 默认开在下边
" alt+shift+\：水平分割窗口
nnoremap » :sp<cr>
vnoremap » <esc>:sp<cr>v
inoremap » <c-o>:sp<cr>
" <esc> alt+shift+\：水平分割窗口  开文件
nnoremap <esc>» :sp<space>
vnoremap <esc>» <esc>:sp<space>
inoremap <esc>» <c-o>:sp<space>
"-----------------------------------------------------------------
" alt+Fn+上下左右：去往上下左右一个窗口
" alt+ctrl+left
map   ᜉ  <plug>(LWin)
map!   ᜉ <plug>(LWin)
noremap  <plug>(LWin)  <c-w>h
inoremap <plug>(LWin)  <c-o><c-w>h
    " " 普通终端
" noremap  <esc>[1;9H <c-w>h
" inoremap <esc>[1;9H <c-o><c-w>h
    " " tmux下
" noremap  <esc><esc>[1~ <c-w>h
" inoremap <esc><esc>[1~ <c-o><c-w>h
" alt+ctrl+right
map  ᜊ   <plug>(RWin)
map! ᜊ   <plug>(RWin)
noremap  <plug>(RWin)   <c-w>l
inoremap <plug>(RWin)   <c-o><c-w>l
" 普通终端
" noremap  <esc>[1;9F <c-w>l
" inoremap <esc>[1;9F <c-o><c-w>l
    " " tmux下
" noremap  <esc><esc>[4~ <c-w>l
" inoremap <esc><esc>[4~ <c-o><c-w>l
" alt+ctrl+up
map  ᜋ   <plug>(UWin)
map!  ᜋ  <plug>(UWin)
noremap  <plug>(UWin)  <c-w>k
inoremap <plug>(UWin)  <c-o><c-w>k
" noremap  <esc><esc>[5~ <c-w>k
" inoremap <esc><esc>[5~ <c-o><c-w>k
" alt+shift+doen
map   ᜌ    <plug>(DWin)
map!   ᜌ   <plug>(DWin)
noremap    <plug>(DWin)   <c-w>j
inoremap   <plug>(DWin)   <c-o><c-w>j
" noremap  <esc><esc>[6~ <c-w>j
" inoremap <esc><esc>[6~ <c-o><c-w>j
"-----------------------------------------------------------------
" 窗口尺寸
" 变宽：alt +
nnoremap <silent> ≠ :exe "vertical resize " . (winwidth(0) * 15/14)<CR>
vnoremap <silent> ≠ <esc>:exe "vertical resize " . (winwidth(0) * 15/14)<CR>gv
inoremap <silent> ≠ <c-o>:exe "vertical resize " . (winwidth(0) * 15/14)<CR>
" 变窄  alt -
nnoremap <silent> – :exe "vertical resize " . (winwidth(0) * 14/15)<CR>
vnoremap <silent> – <esc>:exe "vertical resize " . (winwidth(0) * 14/15)<CR>gv
inoremap <silent> – <c-o>:exe "vertical resize " . (winwidth(0) * 14/15)<CR>
" 变高  shift alt +
nnoremap <silent> ± :exe "resize " . (winheight(0) * 10/9)<CR>
vnoremap <silent> ± <esc>:exe "resize " . (winheight(0) * 10/9)<CR>gv
inoremap <silent> ± <c-o>:exe "resize " . (winheight(0) * 10/9)<CR>
" 变矮  shift alt -
nnoremap <silent> — :exe "resize " . (winheight(0) * 9/10)<CR>
vnoremap <silent> — <esc>:exe "resize " . (winheight(0) * 9/10)<CR>gv
inoremap <silent> — <c-o>:exe "resize " . (winheight(0) * 9/10)<CR>


"=========================================================================
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
"=========================================================================
" :ERDtree 打开NERD_tree         :NERDtreeClose    关闭NERD_tree
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
"-----------------------------------------------------------------
" ctrl+T tree 切换
noremap <c-t> :NERDTreeToggle<CR>
inoremap <c-t> <c-o>:NERDTreeToggle<CR>
let NERDTreeShowHidden=1             " 显示隐藏文件
let NERDTreeWinSize=25               " tree栏宽度
let NERDTreeMapOpenInTab='<ENTER>'   " 在tree中，回车将文件开新tab
"-----------------------------------------------------------------
let s:open_tree_when_open_file=0     " 开vim即开nerdtree
if s:open_tree_when_open_file
    autocmd VimEnter * NERDTree
    autocmd BufWinEnter * NERDTreeMirror
endif
" 进入一个tab，将光标从tree窗口移到文件窗口
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd VimEnter * wincmd p " 开vim或tab，默认进入右侧编辑区
" autocmd VimEnter,BufWinEnter * NERDTreeFind | wincmd p "进入vim时打开NERDTreeFind窗口
" 解决在mac下，tree栏目中每行首显示^G, 这是因为其vim 不支持conceal，更新vim使之支持即可
" let g:NERDTreeNodeDelimiter = "\u00a0"

"=========================================================================
" plugin - NERD_commenter.vim   注释代码用的
"=========================================================================
" let mapleader=","                " 把默认的leader从“\”改为“,”
" [count],cc 光标及以下count行逐行添加注释(7,cc)
" [count],cu 光标及以下count行逐行取消注释(7,cu)
" [count],cm 光标及以下count行尝试添加块注释(7,cm)
" [count],c【空格】 标及以下count行加或解注释(7,c【空格】)
" ,cA 在行尾插入 /* */,并且进入插入模式。 这个命令方便写注释。
" 注：count参数可选，无则默认为选中行或当前行
" -----------------------------------------------------------------
" 【数字】ctrl+/  所选区域加/解注释
" 【数字】缺省则注释所选区域
" 补" 缺省则注释光标及一下【数字】行

" iterm2 把键盘输入的 ctrl+/ 映射成<esc>/
" 这里在把 <esc>/ 映射成 vim中的<c-/>
map ᜀ  <c-/>
map! ᜀ  <c-/>

" function! NComment()
    " let firstLine = line("'<")
    " let lastLine = line("'>")
    " let theLine = getline('.')
    " if ( firstLine ==# lastLine ) && ( theLine =~ "^[ \t]*$" )
        " call feedkeys("\<Plug>NERDCommenterToggle$a")
    " else
        " call feedkeys("\<PLUG>NERDCommenterToggle")
    " endif
" endfunction
function! NComment()
    let l0=line('.')
    let c0=col('.')
    let theLine = getline('.')
    let len0=len(theLine)
    if ( theLine =~ "^[ \t]*$" )
        exe "silent normal! :call NERDComment('n', 'Toggle')\<CR>"
        startinsert
        normal! $
    else
        exe "silent normal! :call NERDComment('n', 'Toggle')\<CR>"
        let len1=len(getline('.'))
        call cursor(l0,len1-len0+c0)
    endif
endfunction

nnoremap <silent> <C-/> :call NComment()<cr>
" nmap <C-/> <Plug>NERDCommenterToggle

" function! VComment() range
    " let firstLine = line("'<")
    " let lastLine = line("'>")
    " let theLine = getline('.')
    " if ( firstLine ==# lastLine ) && ( theLine =~ "^[ \t]*$" )
        " call feedkeys("\<Esc>\<Plug>NERDCommenterToggle$a")
    " else
        " call feedkeys("gv\<PLUG>NERDCommenterTogglegv")
    " endif
" endfunction
function! VComment() range
    let firstLine = line("'<")
    let lastLine = line("'>")
    let theLine = getline('.')
    let [l1,c1]=getpos("'<")[1:2]
    let [l2,c2]=getpos("'>")[1:2]

    let len1=len(getline("'<"))
    let len2=len(getline("'>"))
    if ( firstLine ==# lastLine ) && ( theLine =~ "^[ \t]*$" )
        exe "silent normal! :call NERDComment('v', 'Toggle')\<CR>"
        startinsert
        normal! $
    else
        exe "silent normal! :call NERDComment('v', 'Toggle')\<CR>"
        let len1_=len(getline("'<"))
        let len2_=len(getline("'>"))
        call setpos("'<",[0,l1,len1_-len1+c1,0])
        call setpos("'>",[0,l2,len2_-len2+c2,0])
        normal! gv
    endif
endfunction
vnoremap <silent> <C-/> :call VComment()<cr>
" vmap <C-/> <Plug>NERDCommenterToggle<CR>gv

" function! IComment()
    " let firstLine = line("'<")
    " let lastLine = line("'>")
    " let theLine = getline('.')
    " if ( firstLine ==# lastLine ) && ( theLine =~ "^[ \t]*$" )
        " call feedkeys("\<Plug>NERDCommenterToggle$a")
    " else
        " call feedkeys("\<PLUG>NERDCommenterToggle")
        " call feedkeys("gi")
    " endif
" endfunction
" function! NERDComment(mode, type) range
function! IComment()
    let l0=line('.')
    let c0=col('.')
    let theLine = getline('.')
    let len0=len(theLine)
    if ( theLine =~ "^[ \t]*$" )
        exe "silent normal! :call NERDComment('n', 'Toggle')\<CR>"
        startinsert
        normal! $
    else
        exe "silent normal! :call NERDComment('n', 'Toggle')\<CR>"
        let len1=len(getline('.'))
        startinsert
        call cursor(l0,len1-len0+c0)
    endif
endfunction
inoremap <silent> <C-/> <c-o>:call IComment()<cr>
" imap <C-/> <ESC><Plug>NERDCommenterToggle$a

" -----------------------------------------------------------------
let NERDSpaceDelims=1              " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1          " 多行注释时样子更好看
" let g:NERDCommentEmptyLines = 1    " 允许注释空白行
let g:NERDToggleCheckAllLines = 1  " 当所选非空行皆被注释，toggle才解注，否则toggle加注

"=========================================================================
" 搜索
"=========================================================================
" 搜索 ctrl+f
nnoremap <C-f> :MarkClear<cr>i<c-o>:stopinsert<cr>/
vnoremap <C-f> "9y:MarkClear<cr><esc>/<c-r>9<cr>
inoremap <C-f> <c-o>:MarkClear<cr><c-o>/
" 下一个 ctrl+enter
nnoremap ᜫ  n
vnoremap ᜫ  <esc>n
inoremap ᜫ  <c-o>n
" 上一个 ctrl+shift+enter
nnoremap ᜬ   N
vnoremap ᜬ <esc>N
inoremap ᜬ  <c-o>N
" 关闭搜索的高亮 shift+ctrl+f
nnoremap <silent> ᜮ :silent! nohls<cr>
vnoremap <silent> ᜮ <esc>:silent! nohls<cr>v
inoremap <silent> ᜮ <c-o>:silent! nohls<cr>
" 放弃搜索，退出搜索框
cnoremap <silent> ᜮ <c-u><bs><esc>:silent! nohls<cr>gi

" ------------------------------------------------------------------------
" 目录下搜索
" vimgrep /匹配模式/[g][j] 要搜索的文件/范围 
" g：表示是否把每一行的多个匹配结果都加入
" j：表示是否搜索完后定位到第一个匹配位置

" vimgrep /pattern/ %           在当前打开文件中查找
" vimgrep /pattern/ *           在当前目录下查找所有
" vimgrep /pattern/ **          在当前目录及子目录下查找所有
" vimgrep /pattern/ *.c         查找当前目录下所有.c文件
" vimgrep /pattern/ **/*        只查找子目录

" :copen       显示所有搜索结果


" alt+f
nnoremap <plug>(VimGrep) :vimgrep //g **     \|"HELP\| * : under now dir\| ** : under now dir and subdirs\| *.c : .c files "\|<home><right><right><right><right><right><right><right><right><right>
nmap ƒ <plug>(VimGrep)
vmap ƒ <esc><plug>(VimGrep)
imap ƒ  <c-o><plug>(VimGrep)
" shift+alt+f  打开搜索列表
" 左键双击/回车即可在当前窗口显示此文件，光标进入该窗口
" 再要将光标回到搜索列表，可以鼠标点击进入下方列表窗口，
                            " 或ctrl+alt+down，或
                            " shift+alt+f
" alt+w 关闭列表窗口
nnoremap <silent> Ï :copen<cr>
vnoremap <silent> Ï <esc>:copen<cr>
inoremap <silent> Ï <c-o>:copen<cr>
" alt+enter 下一个
fun! CNext()
" 支持循环
    try
        cnext
    catch /E553/
        crewind
    endtry
endf
nnoremap <silent> ᜯ   :call CNext()<cr>
vnoremap <silent> ᜯ   <esc>:call CNext()<cr>
inoremap <silent> ᜯ   <c-o>:call CNext()<cr>
" shift+alt+enter 上一个
fun! CPrevious()
" 支持循环
    try
        cprevious
    catch /E553/
        clast
    endtry
endf
nnoremap <silent> ᜰ  :call CPrevious()<cr>
vnoremap <silent> ᜰ  <esc>:call CPrevious()<cr>
inoremap <silent> ᜰ  <c-o>:call CPrevious()<cr>
" ------------------------------------------------------------------------
" 同词高亮
" 双击选中一个词，高亮出全部相同的整词
noremap <plug>(2LEFTMOUSE) <2-leftMouse>
map <silent> <2-leftmouse> 1<Leader>m<plug>(2LEFTMOUSE)
imap <silent> <2-leftmouse> <c-o>1<Leader>m<c-o><plug>(2LEFTMOUSE)
" alt+l 选中一个词/放弃选中一个词
nnoremap ¬ viw
vnoremap ¬ <esc>viw
inoremap ¬ <c-o>viw
" 单击退出同词高亮
nnoremap <silent> <leftMouse> :silent MarkClear<cr><leftMouse>
vnoremap <silent> <leftMouse> <esc>:silent MarkClear<cr><leftMouse>
inoremap <silent> <leftMouse> <c-o>:silent MarkClear<cr><leftMouse>
" 同词高亮使用 :hi Search 返回的颜色
function! s:GetColor(color_type)
    exec 'redir => result | silent! hi '.a:color_type.' | redir END'
    let result=substitute(result, '\n' , '' , 'g')
    let result=substitute(result, a:color_type.'\s\+xxx\s\+', '','g')
    let result=substitute(result, '\s\+', "', '", 'g')
    let result=substitute(result, '=', "':'", 'g')
    let result="{'". result . "'}"
    return result
endfunction
" 更换mark.vim （插件）的默认色表
exec "let g:mwPalettes={'mypalette': [".s:GetColor('Search')."]}"
let g:mwDefaultHighlightingPalette = 'mypalette'

"=========================================================================
" 多光标
"=========================================================================
" 快捷键                                               mc：multiple cursor
" ------------------------------------------------------------------------
" 始模式       快捷键  末模式  功能
" ------------------------------------------------------------------------
" n            <C-d>   mc-v    选光标所在整词，之后<C-d>,<C-p>,<C-q>皆选整词
" v            <C-d>   mc-v    选下一相同文本（不必整词），之后<C-d>,<C-p>,<C-q>皆选文本（不必整词）
" n            <S-d>   mc-v    选光标所在整词，及全文诸相同整词
" v            <S-d>   mc-v    选全文诸文本（不必整词）之同被选者
" mc-v         <C-d>   mc-v    选下一个
" mc-v         <C-q>   mc-v    跳过这一个
" mc-v         <C-p>   mc-v    前一个
" v(选中多行)  <C-d>   mc-n    选中区起始光标之列，在诸行插入光标
" -----------------------------------------------------------------------
" 关系图                                后 前插入光标
"
" v多行--<C-d> --- 插入多光标--> mc-n --a、i--\
"                                  v↑↓v        >→ mc-i -- <esc> --> n
" v   --<C-d>、<S-d> --选文本--> mc-v --A、I--/
" n   --<C-d>、<S-d> --选整词/          后 前插入光标
"     选下一个 所有

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-d>'
" 在n模式，选择光所在整词，及全文与之相同的文本（不必整词）
let g:multi_cursor_select_all_word_key = '∂' " alt+d
let g:multi_cursor_start_key           = 'g<C-d>' " 按g松后，按立即按ctrl+d
let g:multi_cursor_select_all_key      = 'g∂' " 按g松后，立即按+alt+d
" 增选下一与之同的文本
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-q>'
let g:multi_cursor_quit_key            = '≈' " alt+x

"=========================================================================
" plug 'mg979/vim-visual-multi'
" 高性能多光标、多选区、正则表达式搜索、按住Shift+方向键选择
let g:VM_maps = {}
" ------------------------------------------------------------------------
"  进入多光标模式：
" v模式下，alt+a：将选中区域加入多光标选区
let g:VM_maps["Visual Add"]               = 'å'
" v模式下， <esc>alt+a 清空多光标选区，再将当前区域加入多光标选区
let g:VM_maps["Visual All"]               = '<esc>å'
" i/n 模式下，alt+a，光标所在区加一个多光标
let g:VM_maps["Add Cursor At Pos"]        = 'å'
" shift+ctrl+l: 选区变为多行光标，光标都在选区开头字符所在列
" FIXME 选区中有宽字符时会出错
let g:VM_maps["Visual Cursors"]           = 'ᜭ'
" i/n模式下
"   ctrl+d，选中光标所在词，继续按ctrl+d以增选整词
""       <c-q>：跳过一个
"       <c-x>: 清除这个光标
"   shift+ctrl+d 选中所有与光标所在词相同的整词
" v模式下
"   ctrl+d，增选与选区相同的文字，不必是整词
"   shift+ctrl+d，选中所有与选区相同的文字，不必是整词
" 上述按键按完后，都进入到多光标的n模式
" ------------------------------------------------------------------------
" 在多光标n模式下：
    "   S-Left/Right：左右移动选区边界
    "   o 切换在选区左还是右边界
    " p: 用剪切板替换各选区
    " c：清空当前各选区，加入插入模式
    " a: 选区后进入插入模式
    " i: 选区前进入插入模式
        " <esc>/<c-i>: 退出多光标i模式
        " <esc>/<c-'>: 退出多光标v模式
    " <esc>: 在多光标n模式，按它退出多光标模式
" ------------------------------------------------------------------------

let g:VM_maps['Find Under']         = '<plug>(FindUnder)'   " 增选下一个与本词相同的词
let g:VM_maps['Find Subword Under'] = '<plug>(FindUnder)'   " 增选下一个与选区相同的文字
let g:VM_maps["Select All"]               = '<plug>(SelectAll)'  " 全选
let g:VM_maps["Remove Region"]=         '<c-x>'     " 清除这个光标
let g:VM_maps['q Skip']               = '<c-q>'     " 跳过一个
" shift+ctrl+d： ᜤ
nmap <c-d> <plug>(FindUnder)
nmap  ᜤ   <plug>(SelectAll)
vmap <c-d> :<c-u>stopinsert<cr>gv<plug>(FindUnder)
vmap  ᜤ  :<c-u>stopinsert<cr>gv<plug>(FindUnder)<plug>(SelectAll)
imap <c-d> <esc><plug>(FindUnder)
imap ᜤ  <esc><plug>(SelectAll)


" let g:VM_maps["Start Regex Search"]       = '<plug>(RegExSearch)'
" let g:VM_maps["Visual Regex"]             = '<plug>(RegExSearch)'
" " 正则表达式搜索 shift+ctrl+f
" " fun RegExSearch()
    " " call feedkeys('r/')
" " endf
" vnoremap <plug>(") "
" nmap ᜮ  :MarkClear<cr><plug>(RegExSearch)
" " vmap ᜮ  <plug>(RegExSearch)
" vmap ᜮ  <plug>(")9y:MarkClear<cr><esc><plug>(RegExSearch)<c-r>9<cr>
" imap ᜮ  <c-o>:MarkClear<cr><c-o><plug>(RegExSearch)


" let g:VM_maps['c']               = ['c', '<BS>']     " 跳过一个
" let maps["Select Operator"][0]          = 'gs'
" let maps[":call vm#commands#regex_done()
" Add Cursor Down"][0]          = '<C-Down>'
" let maps["Add Cursor Up"][0]            = '<C-Up>'
let g:VM_maps["Visual Find"]              = ''
" let g:VM_maps["Select l"]           = '<S-Right>'       " start selecting left
" let g:VM_maps["Select h"]           = '<S-Left>'        " start selecting right

"=========================================================================
" 复制黏贴
" ------------------------------------------------------------------------
" 剪切
" 删去一行
" 不剪切换行符、和行首缩进
function! NCtrlX()
    let this_line = getline(".")
    if this_line =~ "^[ \t]*$"
        call feedkeys("\"_dd")
    else
        call feedkeys("^vg_d\"_dd")
    endif
endfunction
nnoremap <C-x> :call NCtrlX()<cr>
" nmap <C-x> ^vg_d"_dd
" vmap <C-x> d
" 选区末尾若有换行符，不剪切该换行符
function! VCtrlX() range
    if strlen(getline("'>"))<col("'>")
        let l1=line("'<'")
        let c1=col("'<'")
        let l2=line("'>'")
        let c2=col("'>'")
        call setpos("'<", [0, l1, c1, 0])
        call setpos("'>", [0, l2, c2-1, 0])
        normal! gvd$
    elseif strlen(getline("'>"))==col("'>")
        normal! gvd$
    else
        normal! gvd
    endif
    call system('timeout 0.1 nc localhost 8377 &', @")
endfunction
vnoremap <c-x> :call VCtrlX()<cr>

fun! EmptyLine()
    return getline(".")=~ "^[ \t]*$"
endf
imap <expr> <c-x> EmptyLine()? '<esc>"_ddi' : '<esc>^vg_d"_ddi'

" imap <c-x> <c-o>:stopinsert<cr>ddi
" imap <expr> <C-x> col('.')==1?'<esc>ddi':'<esc>dda'
" imap <C-x> <c-o>:stopinsert<cr>dda
" -----------------------------------------
" 复制
" 复制一行，带换行符
" nmap <C-c> ^vg_y
" 复制一行，不带换行符
noremap <c-c> mz^y$:call system('timeout 0.1 nc localhost 8377 &', @")<CR>`z
" 选区末尾若有换行符，不复制该换行符
function! VCtrlC() range
    if strlen(getline("'>"))<col("'>")
        let l1=line("'<'")
        let c1=col("'<'")
        let l2=line("'>'")
        let c2=col("'>'")
        call setpos("'<", [0, l1, c1, 0])
        call setpos("'>", [0, l2, c2-1, 0])
        normal! gvygv
        " normal! gvy$
    elseif strlen(getline("'>"))==col("'>")
        normal! gvygv
        " normal! gvy$
    else
        normal! gvygv
        " normal! gvy
    endif
    call system('timeout 0.1 nc localhost 8377 &', @")
endfunction
vnoremap <c-c> :call VCtrlC()<cr>

" vmap <expr> <C-c> (strlen(getline("'>"))<col("'>"))? ':call CCtrlC()<cr>' : 'y'
" imap <expr> <C-c> col('.')==1?'<esc>yyi':'<esc>yya'
" 选区末尾若有换行符，不复制该换行符
inoremap <c-c> <esc>^y$:call system('timeout 0.1 nc localhost 8377 &', @")<CR>gi
" imap <C-c> <c-o>:stopinsert<cr>yya

" -----------------------------------------
" 粘贴
nnoremap <C-v> :set paste<cr>O<right><left><C-r>"<esc>:set nopaste<cr>
" 选区末尾若有换行符，删除该换行符
function! VCtrlV() range
    if strlen(getline("'>"))<col("'>")
        let l1=line("'<'")
        let c1=col("'<'")
        let l2=line("'>'")
        let c2=col("'>'")
        call setpos("'<", [0, l1, c1, 0])
        call setpos("'>", [0, l2, c2-1, 0])
        normal! gv"_dp$
    elseif strlen(getline("'>"))==col("'>")
        normal! gv"_dp$
    else
        normal! gv"_dPl
    endif
endfunction
" 删除选区并替换为剪切板内容，不改变剪切板内容
vmap <c-v> :call VCtrlV()<cr>
vmap p :call VCtrlV()<cr>
" vnoremap p "_dP

" vnoremap <expr> <C-v> SelectOneChar()? '<esc>Pv<right><esc>' : '"_dPv<esc>"'
" vmap <C-v> <c-b>Pv<right>
" inoremap <C-v> <c-r>"
" inoremap <C-v> <C-o>:set paste<CR><C-R>"<C-o>:set nopaste<CR>
inoremap <C-v> <C-o>:set paste<CR><C-R>"<C-o>:set nopaste<CR>
""<C-o>:stopinsert<cr>:call ICtrlV()<cr>
" ------------------------------------------------------------------------
" 原文粘贴
" 在任何模式下，alt+v 开/关 原文粘贴（paste模式）
"   * cmd+V插入文字前，需开paste模式
"   * cmd+V插入文字后，需关paste模式
" paste模式下，进入插入模式，cmd+V可原文粘贴
"   * 不出现自动缩进
"   * 若受行为注释，所粘诸行不自动加注
set pastetoggle=√     " alt+v  开关原文黏贴模式
" ------------------------------------------------------------------------
" 从服务器vim剪/拷到笔记本剪切板
"   * 鼠标双击选词    鼠标双击选中一词，再按d(相当于cmd+x)/y(相当于cmd+c)
"   * 鼠标拉动选中    鼠标拉动选中一片(可跨页)，再按d(相当于cmd+x)/y(相当于cmd+c)
"   * visual选中      v,y复制、v,d剪切
"   * (数字)yy/dd     整(几)行复制/剪切
" 发送到笔记本的系统剪切板，但不清空vim的寄存器
" 上述操作选中都不会选到行号
vnoremap <silent> y y:call system('timeout 0.1 nc localhost 8377 &', @")<CR>
vnoremap <silent> d d:call system('timeout 0.1 nc localhost 8377 &', @")<CR>
nnoremap <silent> yy yy:call system('timeout 0.1 nc localhost 8377 &', @")<CR>
nnoremap <silent> dd dd:call system('timeout 0.1 nc localhost 8377 &', @")<CR>
" 全选发送到笔记本剪切板
" noremap <C-a> :%w !timeout 0.1 nc localhost 8377<CR><CR>
" ------------------------------------------------------------------------
" vim剪切板同步到本机系统剪切板
" set clipboard=unnamed     " 所有vim剪切板均与系统剪切板同步
" 注释掉则只同步"剪切板，对应y d dd yy c cc 操作
"
" vim --version | grep  clipboad
" 见+clipborad则为支持clipboard，见-clipboard则为不支持
" - 我的mac装了最新的vim后，支持cliboard，可复制到系统见其版
" - linux服务器上即便用`conda install -c conda-forge vim`,也不支持clipboard，或
"    是因为服务器没有显示设备
"    未解决复制到linux系统剪切板
"
" vnoremap y :w !pbcopy<CR><CR>
" nnoremap p :r !pbpaste<CR><CR>
" vnoremap "+y :w !pbcopy<CR><CR>
" nnoremap "+p :r !pbpaste<CR><CR>
" vnoremap y y:call system('xclip -selection clipboard', @")<cr>
" nnoremap p p:call system('xclip -selection clipboard -o', @")<cr>
" vnoremap y :w !xclip -selection clipboard<cr><cr>
" nnoremap p :r !xclip -selection clipboard -o<cr><cr>
" -----------------------------------------------------------------------
" 选中状态下 cmd + c 复制
"   * mac下command+V/C 复制黏贴有效
"   * mac访问linux服务器无效，因为command不是linux能识别的按键
" vnoremap <D-c> "+y
" nnoremap <D-v> "+p
" ------------------------------------------------------------------------
" 删除，不放入剪切板
" 选区末尾若有换行符，不剪切该换行符
function! VBS() range
    " try
        " undojoin
    " catch /^Vim\%((\a\+)\)\=:E790/
    " endtry
    " exe "normal! \<esc>i\<c-g>u\<c-o>:stopinsert\<cr>"
    if strlen(getline("'>"))<col("'>")
        let l1=line("'<'")
        let c1=col("'<'")
        let l2=line("'>'")
        let c2=col("'>'")
        call setpos("'<", [0, l1, c1, 0])
        call setpos("'>", [0, l2, c2-1, 0])
        normal! gv"_d$
    elseif strlen(getline("'>"))==col("'>")
        normal! gv"_d$
    else
        normal! gv"_d
    endif
endfunction
vmap <bs> :call VBS()<cr>
vmap <del> :call VBS()<cr>

nnoremap <backspace> i<backspace><c-o>:stopinsert<cr>
" nnoremap <S-backspace> :echo "test c-backspace"<cr>


" FIXME unable to work in visual, visual(insert), visual of multiple cursor
" wanted feature:
" * when the selected region ended with a <cr>, set <cr> beyond  the selection
" * when the selected region is deleted, put the cursor after the char before
" previous selected region, and end up in insert mode
" function! VC() range
    " " try
        " " undojoin
    " " catch /^Vim\%((\a\+)\)\=:E790/
    " " endtry
    " " exe "normal! \<esc>i\<c-g>u\<c-o>:stopinsert\<cr>"
    " if strlen(getline("'>"))<col("'>")
        " let l1=line("'<'")
        " let c1=col("'<'")
        " let l2=line("'>'")
        " let c2=col("'>'")
        " call setpos("'<", [0, l1, c1, 0])
        " call setpos("'>", [0, l2, c2-1, 0])
        " call feedkeys('gv"_c')
    " elseif strlen(getline("'>"))==col("'>")
        " call feedkeys('gv"_c')
    " else
        " call feedkeys("gv\<bs>i")
        " " exec "normal! gv\"_di"
    " endif
" endfunction
" " 删除选区，进入修改模式，不改变剪切板内容
vmap c :call VC()<cr>
" vnoremap c "_c

"=========================================================================
"缩进
" ------------------------------------------------------------------------
" 缩进设置
set shiftwidth=4                    " 设定 << 和 >> (缩进平移)命令移动时的宽度为 4
set softtabstop=4                   " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4                       " 设定 tab 长度为 4
set expandtab                       " 按tab 输入 tabstop 个空格
" 语言专属缩进设置
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType sh set tabstop=4 shiftwidth=4 softtabstop=4
" ------------------------------------------------------------------------
" 自动将转换为标准缩进（定义见 set tabstop=几，以及set expandtab还是 set noexpandtab ）
" 缩进转4个空格  :set ts=4 :set expandtab :%retab!
" 4个空格转缩进  :set ts=4 :set noexpandtab :%retab!
" :%retab! 转换所有 包括行头中尾的tab，:%retab 只转行头的
noremap rt :%retab!<CR>
inoremap <esc>rt <c-o>:%retab!<CR>
" ------------------------------------------------------------------------
" 空白字符显示
set list                            " 显示文中空白字符，如空格、\tab、换行符等
set listchars=tab:>-,space:·,trail:·,extends:→,precedes:←
" set listchars=tab:⤚- ,┄┄,trail:·  显示\t为">-",行尾多余的空白字符显示成"-"
" 更多见:help listchars
" 特殊符号见https://www.key-shortcut.com/en/writing-systems/35-symbols/arrows
" ------------------------------------------------------------------------
" 缩进平移
set shiftround       " 总是缩进到4格的倍数
" ctrl+] 右一个缩进
" nnoremap <expr> <c-]> ((col('.')==col('$')-1) ? '>>$': '>>'.&shiftwidth.'l')
nnoremap <expr> <c-]> ((col('.')==col('$')-1) ?
            \ 'v>gv<esc>$':
            \ 'v>gv<esc>'.&shiftwidth.'l')
fun VMoveRight() range
    let l1=line("'<")
    let c1=col("'<")
    let l2=line("'>")
    let c2=col("'>")
    normal! gv>gv
    call setpos("'<", [0, l1, c1+&shiftwidth, 0])
    call setpos("'>", [0, l2, c2+&shiftwidth, 0])
    normal! gv
endf
vnoremap <c-]> :call VMoveRight()<cr>
" vnoremap <c-]> >gv
" inoremap <c-]> <esc>v>gvva
inoremap <expr> <c-]> ((col('.')==col('$')) ?
            \ '<c-o>:stopinsert<cr>v>gv<esc>gi<c-o>$' :
            \ '<c-o>:stopinsert<cr>v>gv<esc>gi<c-o>'.&shiftwidth.'l')
" ctrl+[ 左一个缩进
" iterm2 把ctrl+[ 映射为 ᜁ
" 此处把 ᜁ 映射为如下
" 这是因为vim 中，<c-[> 和 <esc> 同键值
" nnoremap ᜁ   v<gvv
fun NMoveLeft()
    let l0=line(".")
    let c0=col(".")
    let [l0,c0]=MoveLeft_(l0,c0)
    normal! gv<gvv
    call setpos(".",[0,l0,c0,0])
endf
nnoremap  ᜁ  :call NMoveLeft()<cr>
" nnoremap <expr> ᜁ   ((getline('.')=~'^\s\+')?
                " \ (EmptyBefore()?
                " \ 'v<gv<esc>^':
                " \ ':call MoveLeft()<cr>'):
            " \ '')
" vnoremap ᜁ   <gv
" 行首有空白字符
function! EmptyStart_(l)
    return getline(a:l)=~'^\s\+'
endfunction
" l行,c字符之前（不含c）皆空白字符否
function! EmptyBefore_(l,c)
    return getline(a:l)[0:a:c-2]=~'^\s*$' &&  a:c != 1
endfunction
function! MoveLeft_(l,c)
    if !EmptyStart_(a:l)
        let c=a:c
    elseif EmptyBefore_(a:l,a:c)
        let c=matchend(getline("'<"),'^\s\+')+1-&shiftwidth
    else
        let c=a:c-&shiftwidth
    endif
    return [a:l,c]
endfunction
fun VMoveLeft() range
    let l1=line("'<")
    let c1=col("'<")
    let l2=line("'>")
    let c2=col("'>")
    let [l1,c1]=MoveLeft_(l1,c1)
    let [l2,c2]=MoveLeft_(l2,c2)
    normal! gv<gv
    call setpos("'<", [0, l1, c1, 0])
    call setpos("'>", [0, l2, c2, 0])
    normal! gv
endf
vnoremap  ᜁ  :call VMoveLeft()<cr>
" inoremap ᜁ   <esc>v<gvva

fun! IMoveLeft()
    let [l0,c0]=getpos(".")[1:2]
    let [l0,c0]=MoveLeft_(l0,c0)
    normal! gv<gv
    call setpos(".",[0,l0,c0,0])
    normal! v
endf
inoremap  ᜁ  <c-o>:call IMoveLeft()<cr>
" ------------------------------------------------------------------------
" 缩进线
let g:indentLine_char = '⎸'
let g:indentLine_color_term = 240 " 237
let g:indentLine_enabled = 1
" macOS 自带的vim无法显示缩进线
" 原因：macOS自带vim (`/usr/bin/vim`)无conceal功能，即`vim --version`
    " 返回中有 ”- conceal“,  而非"+ conceal"，故无法显示缩进线
" 需自己安装vim：
" * 安装vim
    " ```
    " brew install mercurial
    " brew install vim
    " ```
    " 安装到/opt/local/bin/vim
    " 此时`vim --version` 返回中有"+ conceal"，即有conceal功能
" * 改路径
    " 在.profile 加入
    " `export PATH=/usr/local/bin:$PATH`
"=========================================================================
fun! SelectOneChar()
    return ( line("'<") == line("'>") ) && ( virtcol("'<") == virtcol("'>") )
endf
" 撤销
" nnoremap <C-z> u
" vnoremap <expr> <c-z>  SelectOneChar()? '<esc>u': '<esc>ugv'
" imap <expr> <c-z>  pumvisible()?  '<esc>uua' : '<c-o>u'
nnoremap <c-z> g-
vnoremap <c-z> <esc>g-a
snoremap <c-z> <c-g><esc>g-a
" vnoremap <expr> <c-z>  SelectOneChar()? '<esc>g-': '<esc>g-gv'
inoremap <c-z> <esc>g-a

" imap <expr> <c-z>  pumvisible()?  '<esc>g-a' : '<c-o>u'
" 重做
" ctrl+shift+z  --- iterm2 --> <esc>[[z -- vim ---> 重做
map  ᜃ     <plug>(CtrlShiftZ)
map! ᜃ     <plug>(CtrlShiftZ)
" nnoremap <plug>CtrlShiftZ <c-r>
" vnoremap <expr> <plug>(CtrlShiftZ) SelectOneChar()? '<esc>:redo<cr>' : '<esc>:redo<cr>gv'
" inoremap <expr> <plug>(CtrlShiftZ)  pumvisible()?  '<esc>:redo<cr>' : '<c-o><c-r>'
nnoremap <plug>(CtrlShiftZ) g+
vnoremap <plug>(CtrlShiftZ) <esc>g+a
snoremap <plug>(CtrlShiftZ) <c-g><esc>g+a
" vnoremap <expr> <plug>(CtrlShiftZ) SelectOneChar()? '<esc>g+' : '<esc>g+gv'
inoremap <plug>(CtrlShiftZ) <esc>g+a
" ------------------------------------------------------------------------
" 使得undo粒度变细：凡在非空白字符后输入空格或tab、在非空行输入换行，
" 皆用<C-G>u添加一个undo的节点
function! StrIdx(str,idx)
    return nr2char(char2nr(a:str[a:idx:]))
endfunction
" 获得光标前一个字符（以utf8字符计）
function! GetCharBeforeCursor()
    let l=getline('.')
    let c=col('.')
    if c != col('$')-1
        call cursor(l,c-1)
    endif
    let char = StrIdx(getline('.'),col('.')-1)
    if c == 1
        let char = ''
    endif
    call cursor(l,c)
    return char
endfunction
" 最终的空格、tab、换行
fun! SetUndoableSpaceChar()
        " 光标所在行中，光标前一字符，不是空格和tab，则标记undo节点
    inoremap <expr> <Space> (GetCharBeforeCursor()!~"^[ \t]$"?
        \ '<C-g>u<space>':'<space>')
    inoremap <expr> <plug>(TAB) (GetCharBeforeCursor() !~ "^[ \t]$"?
        \ '<C-g>u<tab>' : '<tab>')
    " 光标所在行非皆空格、TAB，则标记undo节点
    inoremap <expr> <plug>(CR) (getline('.') !~ "^[ \t]*$"?
        \ '<c-g>u<cr>' : '<cr>')
endf
fun! UnsetUndoableSpaceChar()
        " 光标所在行中，光标前一字符，不是空格和tab，则标记undo节点
    inoremap <Space> <space>
    inoremap <plug>(TAB) <tab>
    " 光标所在行非皆空格、TAB，则标记undo节点
    inoremap <plug>(CR) <cr>
endf
call SetUndoableSpaceChar()

" ------------------------------------------------------------------------
" (几) alt+z : 前往前（几回）光标位置
nnoremap Ω  <C-o>
vnoremap Ω <esc><C-o>v
inoremap Ω <esc><C-o>a
" (几) alt+shift+z : 前往后（几回）光标位置
nnoremap ¸ <C-i>
vnoremap ¸ <esc><C-i>v
inoremap ¸ <esc><C-i>a

"=========================================================================
" 自动补全
" ------------------------------------------------------------------------
" 方案一：YouCompleteMe + UltiSnips + SuperTab
" YouCompleteMe 实时自动补全
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口

let g:ycm_global_ycm_extra_conf = '~/.vim/data/ycm/.ycm_extra_conf.py'
" 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 开启基于tag的补全，可以在这之后添加需要的标签路径
let g:ycm_collect_identifiers_from_tags_files=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 输入第2个字符开始补全
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;
let g:ycm_key_invoke_completion = '<M-;>'
let g:ycm_key_list_stop_completion = [ "<cr>"]
" ------------------------------------------------------------------------
" ultisnips 代码片断，被自动整合到YCM列表里里
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-e>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" 默认加载代码段的文件夹：UltiSnips，即.vim下任意名为UltiSnips的文件夹下任意层
" 的.snippets文件：
    " 用户自定义的代码段在 ~/.vim/UltiSnips
    " vim-snippets 的在.vim/plugged/{vim-snippets, UltiSnips}
" 手动添加其他目录
" let g:UltiSnipsSnippetDirectories = ['其他代码段目录', 'UltiSnips' ]
"
" 导入代码段后，tab前往下一个变量，s-tab前往上一个变量
" ------------------------------------------------------------------------
" 解决YCM (默认快捷键 tab, s-tab) 和 ultisnips 冲突
" TCM 列表展开时，按Tab向下移，S-Tab向上移
"   到了snippets条目时，Tab插入 snippets
" TCM 列表未展开时，按Tab 导入 snippet
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
" SuperTab 插件
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabMappingTabManual = '<c-j>'

" ------------------------------------------------------------------------
" 方案二 NeoComplCache.vim    自动补全插件
" 暂时不删除，留待YCM无法编译时用
" let g:AutoComplPop_NotEnableAtStartup = 1
" let g:NeoComplCache_EnableAtStartup = 1
" let g:NeoComplCache_SmartCase = 1
" let g:NeoComplCache_TagsAutoUpdate = 1
" let g:NeoComplCache_EnableInfo = 1
" let g:NeoComplCache_EnableCamelCaseCompletion = 1
" let g:NeoComplCache_MinSyntaxLength = 3
" let g:NeoComplCache_EnableSkipCompletion = 1
" let g:NeoComplCache_SkipInputTime = '0.5'
" let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" " snippets expand key
" inoremap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
" snoremap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

" ------------------------------------------------------------------------
" 方案三：vim自带的<c-n>补全 需要以下按键映射
" YCM 不需要用，但兼容之，故保留，以免YCM编译不成功用不了，可以用Vim自带补全

set complete-=i                          " 不补全当前文件所在文件夹下的诸文件、及被导入文件
set completeopt=menuone,longest,preview

function! Expandable()
" 光标不在行首   且光标前一字为字母/_/.   且未展开补全菜单，则返回1，否则0
    return (! pumvisible()) && GetCharBeforeCursor() =~ "^[a-zA-Z_.]$"
endfunction

imap <expr> <TAB> Expandable()?'<c-n>':'<plug>(TAB)'
imap <expr> <CR> pumvisible()?"\<C-Y>":"\<plug>(CR)"
imap <expr> <PageDown> pumvisible() ? "\<PageDown>":"\<plug>(PageDown)"
imap <expr> <PageUp> pumvisible() ? "\<PageUp>":"\<plug>(PageUp)"
" imap <expr> <PageDown> pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<plug>(PageDown)"
" imap <expr> <PageUp> pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<plug>(PageUp)"
" 停止补全 并删除待补全的词汇
" inoremap <expr> <C-U> pumvisible()?"\<C-E>":"\<C-U>"

" ------------------------------------------------------------------------
" `:`命令模式按tab出现选项提示
" 一按tab出补全列表，按右/左键或<tab>/<S-tab>移动选项
set wildmenu                     " 开启语义补全
set wildmode=list:longest,full   " 补全方式


"=========================================================================
" 快速跳转
" ------------------------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,] " 支持左右跨行移动
" 光标自动位于页中
" auto insertleave,cursormoved * normal! zz
" ------------------------------------------------------------------------
" 短距离上下移动
" 上滚一行
noremap <S-u> <C-y>
" 下滚一行
noremap <S-d> <C-e>
"上翻半页  up
noremap <S-Up> <C-u>0
inoremap <S-Up> <c-o><C-u><c-o>0
" 下翻半页  down
noremap <S-Down> <C-d>$
inoremap <S-Down> <c-o><C-d><c-o>$
" ------------------------------------------------------------------------
" 长距离上下移动
" 上翻一页
" noremap <PageUp> z^0
" inoremap <plug>(PageUp) <c-o>z^<c-o>0
noremap <expr> <PageUp> (line('w$')-line('w0')+1<=2*line('.')?
    \ '<C-U>0<c-u>0':'<c-u>0')
inoremap <expr> <plug>(PageUp) (line('w$')-line('w0')+1<=2*line('.')?
    \ '<c-o><C-U><c-o>0<c-o><c-u><c-o>0':'<c-o><c-u><c-o>0')

" function! PageUp()
    " " call feedkeys("gv")
    " try
        " call feedkeys("gv\<S-up>")
        " call feedkeys("\<S-up>")
    " endtry
    " call feedkeys("0")
" endfunction
" nnoremap <PageUp> :call PageUp()<cr>
" vnoremap <PageUp> :<c-u>call PageUp()<cr>
" nnoremap <PageUp> <C-b>H0
" inoremap <PageUp> <c-o><C-b><c-o>H<c-o>0
" 下翻一页
noremap <expr> <PageDown> (line('w$')-line('w0')+1<=2*(line('$')-line('.')+1)?
    \ '<C-d>$<c-d>$':'<c-d>$')
inoremap <expr> <plug>(PageDown) ((line('w$')-line('w0')+1<=2*(line('$')-line('.')+1))?
    \ '<c-o><C-d><c-o>$<c-o><c-d><c-o>$':'<c-o><c-d><c-o>$')

" noremap <PageDown> z+$
" inoremap <plug>(PageDown) <C-o>z+<C-o>$
" noremap <PageDown> <c-f>$
" inoremap <PageDown> <c-o><C-f><C-o>$
" 去文件头
noremap <S-C-Up> gg
inoremap <S-C-Up> <c-o>gg
" 去文件尾巴
noremap <S-C-Down> <S-g>$
inoremap <S-C-Down> <c-o><S-g><C-o>$
" ------------------------------------------------------------------------
" 左右移动
" " 左走一词
" noremap <S-Left> gE
" inoremap <S-Left> <left><c-o>gE<right>
" " 右走一词
" noremap <S-Right> E
" inoremap <S-Right> <c-o>E<right>

if has('nvim')
    map <M-b> <M-left>
    map! <M-b> <M-left>
    map <M-f> <M-right>
    map! <M-f> <M-right>
else
    map <esc>b <M-left>
    map! <esc>b <M-left>
    map <esc>f <M-right>
    map! <esc>f <M-right>
endif

" alt+left => <esc>b 左移一词
noremap  <M-left>  gE
inoremap  <M-left>  <left><c-o>gE<right>
cnoremap  <M-left>  <s-left>
" alt+right => <esc>f 右移一词
noremap  <M-right>   E
inoremap  <M-right>   <c-o>E<right>
cnoremap  <M-right>   <s-right>

" 光标前皆字符，且不在行首
function! EmptyBefore()
    return getline('.')[0:col('.')-2]=~'^\s*$' && col('.') != 1
    " || col('.')==1
endfunction
" function! EmptyBeforeAndThis()
    " return getline('.')[0:col('.')-1]=~'^\s*$'
    " " && getline('.')[col('.')-1]=~'^\S$'
" endfunction
" 去行头 Fn+Left,
    " 亦可 alt+shift+left --- iterm2 --->  Home
noremap <expr>  <Home> EmptyBefore()? '0' : '^'
inoremap <expr> <Home> EmptyBefore()? '<c-o>0' : '<c-o>^'
" 去行尾 Fn+Right
" 亦可 alt+shift+Right --- iterm2 --->  End
noremap <End> $
inoremap <End> <c-o>$
" noremap <expr> <End> EmptyBeforeAndThis()? '^' : '$'
" inoremap <expr> <End> EmptyBeforeAndThis()? '<c-o>^' : '<c-o>$'

map <Esc>OH <Home>
map! <Esc>OH <Home>
map <Esc>OF <End>
map! <Esc>OF <End>
" tmux 外，Home、End键
map <Esc>[H <Home>
map! <Esc>[H <Home>
map <Esc>[F <End>
map! <Esc>[F <End>
" 在tmux下，home的key code是^[[1~，END的 key code 是^[[4~
map <ESC>[1~    <Home>
map! <ESC>[1~    <Home>
map <ESC>[4~    <End>
map! <ESC>[4~    <End>
map  <kHome> <Home>
map! <kHome> <Home>
map  <kEnd> <End>
map! <kEnd> <End>

" 在item2下，设置
" shift+alt+left -> <esc>[1~
" shift+alt+right -> <esc>[4~

" alt+up 光标移动到页顶
" map <esc>[1;9A <A-up>
" map! <esc>[1;9A <A-up>
map ᜅ  <A-up>
map! ᜅ  <A-up>
noremap <A-up> H
inoremap <A-up> <c-o>H
" alt+down 光标移动到页底
" map <esc>[1;9B <A-down>
" map! <esc>[1;9B <A-down>
map ᜆ   <A-down>
map! ᜆ   <A-down>
noremap <A-down> L
inoremap <A-down> <c-o>L
" alt+m   光标移动到页中
noremap µ M
inoremap µ <c-o>M

" alt+shift+up 所在行置页预
" map <esc>[1;10A <A-S-up>
" map! <esc>[1;10A <A-S-up>
map ᜇ  <A-S-up>
map! ᜇ  <A-S-up>
noremap <A-S-up> zt
inoremap <A-S-up> <c-o>zt
" alt+shift+down 所在行至页底
" map <esc>[1;10B <A-S-down>
" map! <esc>[1;10B <A-S-down>
map ᜈ   <A-S-down>
map! ᜈ   <A-S-down>
noremap <A-S-down> zb
inoremap <A-S-down> <c-o>zb
" alt+shift+m 所在行置页中
noremap Â zz
inoremap Â <c-o>zz
" ------------------------------------------------------------------------
" Vim Gitgutter : 它会在 Vim 的行号列旁显示 git diff 的差异标记
" alt+[ 去前一个修改的块之间跳转
nmap ᜠ [c
vmap ᜠ <esc>[c
imap ᜠ <c-o>[c
" alt+] 去后一个修改的块之间跳转
nmap ᜡ  ]c
vmap ᜡ  <esc>]c
imap ᜡ  <c-o>]c
" 开关gitgutter
noremap  <Leader>g :GitGutterToggle<CR>
inoremap  <esc>g <c-o>:GitGutterToggle<CR>

"========================================================================
" 选择
" 选中一行，含行尾换行符
nnoremap <c-l> 0v$
vnoremap <c-l> <esc>0v$
inoremap <c-l> <c-o>0<C-o>v$
" 全选
nnoremap <C-a> ggv<S-g>$
vnoremap <C-a> <esc>ggv<s-g>$
inoremap <C-a> <c-o>gg<c-o>v<S-g>$
"========================================================================
" 这些删除每做一次，，故可一步步撤销
" 删除
" alt+del 删除前一个词
if has('nvim')
    nmap <M-BS> <plug>(DeleteWordBefore)
    imap <M-BS> <plug>(DeleteWordBefore)
    cmap <M-BS> <plug>(DeleteWordBefore)
else
    nmap <esc><bs> <plug>(DeleteWordBefore)
    imap <esc><bs> <plug>(DeleteWordBefore)
    cmap <esc><bs> <plug>(DeleteWordBefore)
endif
nnoremap <expr> <plug>(DeleteWordBefore) (col('.')==1)? 'i<c-g>u<bs><c-o>:stopinsert<cr>' : 'a<c-g>u<esc>vb"_d'
" nnoremap <expr> <plug>(DeleteWordBefore) (col('.')==1)? 'i<bs><c-o>:stopinsert<cr>' : ' <left>vb"_d'
inoremap <expr> <plug>(DeleteWordBefore) (col('.')==1)? '<c-g>u<bs>' : '<c-g>u<left><c-o>vb"_d'
" inoremap <expr> <plug>(DeleteWordBefore) (col('.')==1)? '<bs>' : '<left><c-o>vb"_d'
cnoremap <plug>(DeleteWordBefore) <c-w>
" alt+fn+del 删除后一个词
if has('nvim')
    nmap <M-d> <plug>(DeleteWordAfter)
    imap <M-d> <plug>(DeleteWordAfter)
    cmap <M-d> <plug>(DeleteWordAfter)
else
    nmap <esc>d <plug>(DeleteWordAfter)
    imap <esc>d <plug>(DeleteWordAfter)
    cmap <esc>d <plug>(DeleteWordAfter)
endif
nnoremap <expr> <plug>(DeleteWordAfter) ((col('.')==col('$')-1)? 'a<c-g>u<del><c-o>:stopinsert<cr>' : 'a<c-g>u<esc>ve"_d')
inoremap <expr> <plug>(DeleteWordAfter) (col('.')==col('$'))? '<del>' : '<c-g>u<C-o>ve"_d'
cnoremap <expr> <plug>(DeleteWordAfter) ''
" cnoremap <plug>(DeleteWordAfter) <S-right><c-w>  " FIXME 这样写不行，还不知道怎么写
" alt+shift+del 删除光标前的整行
nmap <c-u> <plug>(DeleteLineBefore)
imap <c-u> <plug>(DeleteLineBefore)
cmap <c-u> <plug>(DeleteLineBefore)
nnoremap <expr> <plug>(DeleteLineBefore) (col('.')==1) ? 'i<c-g>u<bs><c-o>:stopinsert<cr>' : 'a<c-g>u<esc><left>v0"_d'
inoremap <expr> <plug>(DeleteLineBefore) (col('.')==1) ? '<c-g>u<bs>' :'<c-g>u<left><c-o>v0"_d'
cnoremap <plug>(DeleteLineBefore) <c-u>
" alt+shift+fn+del 删除光标 后的整行
nmap <c-k> <plug>(DeleteLineAfter)
imap <c-k> <plug>(DeleteLineAfter)
cmap <c-k> <plug>(DeleteLineAfter)
nnoremap <expr> <plug>(DeleteLineAfter) (col('.')>=col('$')-1)? 'a<c-g>u<del><c-o>:stopinsert<cr>' : 'a<c-g>u<esc>v$h"_d'
" FIXME 在multiple-cursor下，撤销会出bug
inoremap <expr> <plug>(DeleteLineAfter) (col('.')==col('$'))? '<c-g>u<del>' : '<c-g>u<c-o>v$<left>"_d'
" FIXME 在multiple-cursor下，撤销会出bug
cnoremap <expr> <plug>(DeleteLineAfter) ''
" cnorempa: FIXME 还不知道怎么写
" shift+del 删除
" 或 ctrl+l整行选中，backspace删除
nmap  <c-e><c-u>   <plug>(DeleteLine)
imap   <c-e><c-u>  <plug>(DeleteLine)
" cmap <c-e><c-u> <plug>DeleteLine
nnoremap <plug>(DeleteLine) a<c-g>u<esc>0v$"_d
inoremap <plug>(DeleteLine) <c-g>u<c-o>0<C-o>v$"_d
" cnoremap <plug>(DeleteLine) <c-e><c-u>

"=========================================================================
" ctrl+s保存
autocmd BufWritePre * :%s/\s\+$//e  " 保存时自动删除行尾空格

function! UpDate()
    let l=line('.')
    let c=col('.')
    update
    call cursor(l,c)
    nohls
endfunction
nnoremap <silent> <C-S> :call UpDate()<cr>:echo "saved"<cr>
vnoremap <silent> <C-S> <esc>:call UpDate()<cr>:echo "saved"<cr>
inoremap <silent> <C-S> <c-o>:call UpDate()<cr><c-o>:echo "saved"<cr>
" <esc>ctrl+s 存为
nnoremap  <esc><c-s>  :update<space>
vnoremap  <esc><c-s>  <esc>:update<space>
inoremap  <esc><c-s>  <c-o>:update<space>
" ctrl+r 文件改名
function! s:rename_file(new_file_path)
  execute 'saveas ' . a:new_file_path
  call delete(expand('#:p'))
  bd #
endfunction

command! -nargs=1 -complete=file Rename call <SID>rename_file(<f-args>)
nnoremap <c-r>  :Rename<space>
vnoremap <c-r>  <esc>:Rename<space>
inoremap <c-r> <c-o>:Rename<space>
" ------------------------------------------------------------------------
" 退出
" 若 本tab非tree窗口数目多于1，或为0（即只有tree窗口），则:q退出窗口
" 否则若 tab数>1，则关闭此tab
" 否则若 有tree窗口，则关闭tree窗口，再:q退出本窗口
" 否则，直接:q退出窗口
function! TreeWindowNumber()
    if exists('g:NERDTree')
        return g:NERDTree.IsOpen()
    else
        return 0
    endif
endfunction

nnoremap <expr> <C-w> ((winnr('$')-TreeWindowNumber()) != 1 ? ':q<cr>' :
\ (tabpagenr() > 1 ? ':tabclose<cr>' :
\ (TreeWindowNumber()? ':NERDTreeToggle<CR>:q<CR>' : ':q<CR>'
\ )))
vnoremap <expr> <C-w> ((winnr('$')-TreeWindowNumber())!= 1?'<esc>:q<cr>':
\ (tabpagenr() > 1 ? '<esc>:tabclose<cr>' :
\ (TreeWindowNumber()? '<esc>:NERDTreeToggle<CR>:q<CR>': '<esc>:q<CR>'
\ )))
inoremap <expr> <C-w> ((winnr('$')-TreeWindowNumber())!=1?'<c-o>:q<cr>':
\ (tabpagenr() > 1 ? '<c-o>:tabclose<cr>' :
\ (TreeWindowNumber()?'<c-o>:NERDTreeToggle<CR><c-o>:q<CR>': '<c-o>:q<CR>'
\ )))

" vim程序退出
" shift+ctrl+w
nnoremap ᜐ   :qa<cr>
vnoremap ᜐ   <esc>:qa<cr>
inoremap  ᜐ   <c-o>:qa<cr>
" alt+w 退出窗口
nnoremap ∑ :q<cr>
vnoremap ∑ <esc>:q<cr>
inoremap ∑ <c-o>:q<cr>
" alt+shitf+w 退出标签页
nnoremap <expr> „ tabpagenr() > 1 ? ':tabclose<cr>' : ':qa<cr>'
vnoremap <expr> „ tabpagenr() > 1 ? '<esc>:tabclose<cr>' : '<esc>:qa<cr>'
inoremap <expr> „ tabpagenr() > 1 ? '<c-o>:tabclose<cr>' : '<c-o>:qa<cr>'
" ------------------------------------------------------------------------
" 进出visual模式: ctrl+'
vnoremap ᜏ <esc>
inoremap ᜏ <c-o>v
nnoremap ᜏ v
" 进出插入模式：ctrl+i
inoremap ᜎ <C-o>:stopinsert<cr>
nnoremap ᜎ  i
" 退出命令模式，进入insert模式
cnoremap ᜎ  <c-u><bs><esc>a

" noremap <esc> <NOP>
" inoremap <esc> <NOP>

"=========================================================================
" ctrl+p：模糊搜索当前目录及其子目录下的所有文件
" ------------------------------------------------------------------------
" 教程
" ------------------------------------------------------------------------
" 进入ctrlp模式
" - `C-P`或者`:CtrlP (起始目录)`: 在查找文件模式下调用CtrlP
" - `:CtrlPBuffer`或`:CtrlPMRU`: 在查找缓冲区调用CtrlP或者查找MRU文件模式
" - `<esc>` `<c-b>` `<c-w>` `alt+w`: 都可以退出ctrlp模式
" ------------------------------------------------------------------------
" 进入ctrlp模式后
" 模式
" - `<S-Left>`、`<S-right>`: 左、右移动切换模式(文件 file/最近打开的文件 MRU/ctrlp打开的历史 buff)
" - `<c-f>`: 开关到仅文件名搜索而不是完整路径搜索
" - `<c-r>`: 开关切换到正则表达式模式
" 选择
" - `Up`、`Down`:　在文件列表中上下移动
" - `<c-z>`:　勾选/勾除记多个文件
" 更新
" - `<F5>`: 清除当前目录的缓存以获取新文件，删除已删除的文件并应用新的忽略选项
" - `<F7>`：
    " - MRU下直接按它清空所有文件
    " - MRU下先`<c-z>`勾选文件在按它清之
    " - buffer下按它清除所在行的文件
" - `<c-z>`,`<c-s-z>`:　撤销、重做于ctrlp中
" 打开命令
" - `<A-C-N>`、`<A-t>`、`<A-S-\>`、`<A-\>`(即`<cr>`): 开在本窗口（现在的文件就关了）、新Tab、横分屏、竖分屏
" - `<c-o>`：打开，ctrlp会问你用上述哪种方法打开
" 输入路径
" - `<s-tab>`：开关输入栏
" - `tab`: 自动补全
" - `left`、`right`：在自己输入的path中左右移动光标
" - `<c-\>`：输入栏在光标处插入内容，会弹出选项，问从系统剪切板插入啥
" - `..` 回车，上走一级目录，n个`.`后回车，上走n-1个目录
" - 标记文件后，输`:number`，不回车，按打开命令，会打开并跳到指定行数
" - 输入[父目录/父目录/]新文件名，`<c-n>` ，创建一个新文件及其父目录
    " - 默认是绝对路径，相对路径请用`./`开头
    " - 但貌似不能创建文件夹
" - 对比文件：勾选多个文件
    " - 输入`:diffthis`，不回车，按打开命令（通常竖分屏） /或按`<c-o>`来竖分屏
    " - 或直接输入`<C-d>`，竖分屏
" ------------------------------------------------------------------------
" 文档：https://github.com/hyliang96/ctrlp.vim/blob/master/doc/ctrlp.cnx
" 帮助
" - `:help ctrlp-options`: 获取帮助文档
" - `:help ctrlp-mappings`：按键帮助
" - `:help ctrlp-commands`：获取ctrlp命令的帮助
" ------------------------------------------------------------------------
nnoremap <c-p> :CtrlP<cr>
vnoremap <c-p> <esc>:CtrlP<cr>
inoremap <c-p> <esc>:CtrlP<cr>
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
" 设置过滤不进行查找的后缀名
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
" " Use a custom file listing command
" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
" follow .gitignore
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
let g:ctrlp_show_hidden=1
let g:ctrlp_exit_to_insert=1   " 退出ctrlp则进入insert模式
" 用户覆盖默认快捷键
let g:ctrlp_prompt_mappings = {
\ 'PrtHistory(1)':        ['<c-z>'],
\ 'PrtHistory(-1)':       ['ᜃ'],
\ 'CreateNewFile()':      ['<c-n>'],
\ 'ToggleType(1)':        ['<S-right>'],
\ 'ToggleType(-1)':       ['<S-left>'],
\ 'AcceptSelection("h")': ['»','<c-h>'],
\ 'AcceptSelection("v")': ['«','<c-v>','<cr>'],
\ 'AcceptSelection("e")': ['ᜦ','<2-LeftMouse>'],
\ 'ToggleByFname()':      ['<c-f>'],
\ 'ToggleRegex()':        ['<c-r>'],
\ 'PrtCurLeft()':         ['<left>'],
\ 'PrtCurRight()':        ['<right>'],
\ 'MarkToOpen()':         ['<c-l>'],
\ 'PrtDeleteWord()':      ['<esc><BS>'],
\ 'PrtCurStart()':        ['<c-a>','<esc>[1~'],
\ 'PrtCurEnd()':          ['<c-e>','<esc>[4~'],
\ 'PrtClear()':           ['<c-u>','<c-u><c-k>'],
\ 'PrtExit()':    ['<esc>', 'ᜎ ','<c-w>','∑'],
\ 'DiffOpen("\<c-o>")':   ['<c-d>'],
\ }
" ------------------------------------------------------------------------
"  ctrlp 的插件
let g:ctrlp_extensions = ['funky']
" funky: 函数的模糊搜索
" alt+p 进入当前文件的函数列表搜索
nnoremap π :CtrlPFunky<Cr>
inoremap π <esc>:CtrlPFunky<Cr>
" alt+shif+p 搜索当前光标下单词对应的函数
nnoremap ∏ :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
inoremap ∏ <esc>:execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_matchtype = 'path'
"=========================================================================
" 括号补全
" Plug 'Raimondi/delimitMate'
au FileType python let b:delimitMate_nesting_quotes = ['"']
" ------------------------------------------------------------------------
" 彩色括号对
" 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown', 'RoyalBlue3'],
    \ ['Darkblue', 'SeaGreen3'],
    \ ['darkgray', 'DarkOrchid3'],
    \ ['darkgreen', 'firebrick3'],
    \ ['darkcyan', 'RoyalBlue3'],
    \ ['darkred', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown', 'firebrick3'],
    \ ['gray', 'RoyalBlue3'],
    \ ['black', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue', 'firebrick3'],
    \ ['darkgreen', 'RoyalBlue3'],
    \ ['darkcyan', 'SeaGreen3'],
    \ ['darkred', 'DarkOrchid3'],
    \ ['red', 'firebrick3'],
    \ ]
let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle      " Toggle it on/off
au Syntax * RainbowParenthesesLoadRound     " (), the default when toggling
au Syntax * RainbowParenthesesLoadSquare    " []
au Syntax * RainbowParenthesesLoadBraces    " {}
au Syntax * RainbowParenthesesLoadChevrons  " <>
" ------------------------------------------------------------------------
" 快速给词加环绕符号,例如单引号/双引号/括号/成对标签等
"'tpope/vim-surround'
vmap ' S'
vmap " S"
vmap < S<
vmap ( S(
vmap [ S[
vmap { gS{
"=========================================================================
" 格式化
" Don't use Ex mode, use Q for formatting 格式化
map Q gq

"=========================================================================
" 编译报错
" alt+e+alt+e: 显示报错列表
nnoremap ᜢᜢ :cl<CR>
vnoremap ᜢᜢ <ESC>:cl<CR>
inoremap ᜢᜢ <c-o>:cl<CR>
" alt+e+alt+]: 下一条报错
nnoremap ᜢᜡ  :cn<CR>
vnoremap ᜢᜡ <ESC>:cn<CR>
inoremap ᜢᜡ <C-o>:cn<CR>
" alt+e+[: 前一条报错
nnoremap ᜢᜠ  :cp<CR>
vnoremap ᜢᜠ <ESC>:cp<CR>
inoremap ᜢᜠ <c-o>:cp<CR>
" alt+e+alt+<cr>:  显示详细错误信息
nnoremap ᜢᜣ :cc<CR>
vnoremap ᜢᜣ <ESC>:cc<CR>
inoremap ᜢᜣ <c-o>:cc<CR>

"=========================================================================
" 关闭 vimscript的换行号自动缩进三个tab的特性
" inoremap \ <space><backspace>\

"========================================================================="
" 实用小函数
function! DebugPrint(str)
    redir >> debug_output | silent! echo a:str | redir END
endfunction
" 分割线
inoremap <esc>=  =========================================================================
inoremap <esc>-  -------------------------------------------------------------------------

"=========================================================================
" this machine config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif




"=========================================================================
" 待装插件
"-------------------------------------------------------------------------
" plugin - DoxygenToolkit.vim  由注释生成文档，并且能够快速生成函数标准注释
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
noremap <leader>da :DoxAuthor<CR>
noremap <leader>df :Dox<CR>
noremap <leader>db :DoxBlock<CR>
noremap <leader>dc a /*  */<LEFT><LEFT><LEFT>
"-------------------------------------------------------------------------
" plugin – checksyntax.vim    JavaScript常见语法错误检查
" 默认快捷方式为 F5
let g:checksyntax_auto = 0 " 不自动检查
"-------------------------------------------------------------------------
" Plug ’vim-scripts/taglist.vim‘
" taglist插件，详见https://www.jianshu.com/p/923aec861af3
if MySys() == "windows"                " 设定windows系统中ctags程序的位置
    let Tlist_Ctags_Cmd = '"'.$VIMRUNTIME.'/ctags.exe"'
elseif MySys() == "linux"              " 设定windows系统中ctags程序的位置
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Show_One_File = 1            " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         " 在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close=1       " 自动折叠当前非编辑文件的方法列表
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1



" =========================================================================
" 上文参考资料
" =========================================================================
" DesCRiption: 适合自己使用的vimrc文件，for Linux/Windows, GUI/Console
" Last Change: 2010年08月02日 15时13分
" Version:     1.80
" Source: http://www.cnblogs.com/zourrou/archive/2011/04/16/2018493.html
" =========================================================================

"=========================================================================
" vim-sublime - A minimal Sublime Text - like vim experience bundle
"               http://github.com/grigio/vim-sublime
" Best view with a 256 color terminal and Powerline fonts
" Updated by Dorian Neto (https://github.com/dorianneto)"
"=========================================================================
"
