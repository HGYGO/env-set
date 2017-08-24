
let mapleader=","

filetype plugin on

"Add plugins ############ {{{
set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')
" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'file:///~/.vim/bundle/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
Plugin 'mru.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/ListToggle'
"Plugin 'SirVer/ultisnips'
Plugin 'majutsushi/tagbar'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bronson/vim-trailing-whitespace'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-session'
"Plugin 'wting/gitsessions.vim'
"Plugin 'ToruIwashita/git-switcher.vim'
Plugin 'vim-scripts/a.vim'

call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
filetype plugin on
"}}}
"TabLine ##################### {{{
set showtabline=2
set tabline=%!MyTabLine()

function! MyTabLine()
	let s = ''
	let a = 0
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			if a == 0
				let s .= '%#TabLineFill1#'
				let a = 1
			else
				let s .= '%#TabLineFill2#'
				let a = 0
			endif
		endif
		let s .= '%' . (i + 1) . 'T'
		let s .= ' %{MyShortTabLabel(' . (i + 1) . ')} '
	endfor

	let s .= '%#TabLineOther#%T'
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999Xclose'
	endif
	return s
endfunction

function! MyShortTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  "let label = '<'
  let label = bufname (buflist[tabpagewinnr (a:n) -1])
  "let label .= '>'
  if getbufvar(buflist[tabpagewinnr (a:n) -1], '&modified')
	let label .= '[+]'
  endif
  let filename = fnamemodify (label, ':t')
  return filename
endfunction

"function! MyTabLabel(n)
  "let buflist = tabpagebuflist(a:n)
  "let winnr = tabpagewinnr(a:n)
  "return bufname(buflist[winnr - 1])
"endfunction


"  TabLineFill  tab pages line, where there are no labels
hi TabLineFill1 term=bold
hi TabLineFill1 ctermfg=white ctermbg=DarkMagenta
hi TabLineFill1 guifg=#777777

hi TabLineFill2 term=none
hi TabLineFill2 ctermfg=white ctermbg=DarkCyan
hi TabLineFill2 guifg=#777777
"  TabLineSel   tab pages line, active tab page label
hi TabLineSel term=inverse
"hi TabLineSel term=none
hi TabLineSel cterm=none ctermfg=yellow "ctermbg=White
"hi TabLineSel ctermfg=yellow
hi TabLineSel gui=none guifg=yellow guibg=Black

hi TabLineOther term=none
hi TabLineOther ctermfg=black ctermbg=black
hi TabLineOther guifg=#777777


"}}}
"NERDTree ##################### {{{
"========= NERDTree.vim =========
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=20
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=0			"0:remain opening, 1:close
let g:NERDChristmasTree=1
let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', 'tags', 'GPATH', 'GRTAGS', 'GTAGS']

let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeChDirMode=1
"let NERDTreeQuitOnOpen=1
"let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
nmap  <leader>f :NERDTreeFind<cr>
"*************NERD_tree****************
map  <F3>   :NERDTreeToggle<cr>
"map <F3> <plug>NERDTreeMirrorToggle<CR>
"autocmd vimenter * NERDTree
"autocmd vimenter * NERDTreeTabsToggle
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif

let g:nerdtree_tabs_autoclose = 1
"}}}
"NERD_commenter.vim ##################### {{{
let g:NERDShutUp=1
let w:location=0
"}}}
"MRU.vim ##################### {{{
"let MRU_Include_Files = '\.c$\|\.h$|\.cpp'
let MRU_Window_Height = 15
let MRU_Use_Current_Window = 0
let MRU_Auto_Close = 1
let MRU_Max_Menu_Entries = 20
nmap <leader>m :MRU<cr>
"}}}
"YouCompleteMe #####################{{{
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '<CR>'	
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? '<C-n>' : '<Down>'
inoremap <expr> <Up>       pumvisible() ? '<C-p>' : '<Up>'
inoremap <expr> <PageDown> pumvisible() ? '<PageDown><C-p><C-n>' : '<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '<PageUp><C-p><C-n>' : '<PageUp>'

let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_confirm_extra_conf=1 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全

"force recomile with syntastic
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	
"nnoremap <leader>lo :lopen<CR>	'open locationlist
"nnoremap <leader>lc :lclose<CR>	'close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"跳转到定义处
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"}}}
"listToggle ##################### {{{
"let g:lt_location_list_toggle_map = '<leader>l'
"let g:lt_quickfix_list_toggle_map = '<leader>q'
"let g:lt_height = 10
"}}}
"CopyAndPaste ##################### {{{
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>yy "+yy
nmap <leader>yw "+yw
nmap <leader>dd "+dd
nmap <leader>p "+p
nmap yw yiw
nmap <S-P> viwpyw
"nmap <C-S-P> pkdd
nmap <leader>q/ :Grep <C-R>=expand("<cword>")<cr> % <cr>
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"}}}
"TagBar ##################### {{{
" \tb 打开tagbar窗口
nmap <F2> :TagbarToggle<CR>
let g:tagbar_autofocus = 0
let g:tagbar_left = 1
let g:tagbar_width = 25
let g:tagbar_sort = 0
"autocmd VimEnter * nested :TagbarOpen
"}}}
"pvim-powerline ##################### {{{
let g:Powerline_symbols = 'unicode'
"}}}
"vim-indent-guides ##################### {{{
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
"}}}
"ultisnips ##################### {{{
" If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"定义存放代码片段的文件夹.vim/snippets下，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories=["snippets", "bundle/ultisnips/UltiSnips"]
"}}}
"vim-trailing-whitespace ##################### {{{
map <leader><space> :FixWhitespace<cr>
"}}}
"rdnetto/YCM-Generator ##################### {{{
":YcmGenerateConfig or :CCGenerateConfig
"}}}
"
" SET GNU_GLOBAL {{{1

nmap <leader>sa :cs add cscope.out<cr>
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sii :cs find i %<cr>
"nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>

"To enable C+S, Add "stty -ixon" to ~/.bashrc
nmap <C-s> ,ss
nmap <C-g> ,sg
nmap <C-c> ,sc
"nmap <C-s> :silent call setqflist([])<cr>,ss:NERDTreeClose<cr>:copen 15<cr><c-w>k<c-o><c-w>j
"nmap <C-g> :silent call setqflist([])<cr>,sg:NERDTreeClose<cr>:copen 15<cr><c-w>k<c-o><c-w>j
"nmap <C-c> :silent call setqflist([])<cr>,sc:NERDTreeClose<cr>:copen 15<cr><c-w>k<c-o><c-w>j
"nmap <C-t> ,st

cmap ,ss cs find s
cmap ,sg cs find g
cmap ,sc cs find c
cmap ,st cs find t
cmap ,se cs find e
cmap ,sf cs find f
cmap ,si cs find i
"cmap ,sd cs find d

"Close Quickwindow
nmap <leader>ccl :ccl<CR>
nmap <F4> :ccl<CR>


" settings of cscope.
" I use GNU global instead cscope because global is faster.
"set cscopetag
"set cscopeprg=/usr/local/bin/gtags-cscope
"set csprg=/usr/local/bin/gtags-cscope
"set cscopequickfix=c-,d-,e-,f-,g-,i-,s-,t-
set cscopequickfix=t-
"nmap <silent> <leader>j <ESC>:cstag <c-r><c-w><CR>
"nmap <silent> <leader>g <ESC>:lcs f c <c-r><c-w><cr>:lw<cr>
"nmap <silent> <leader>s <ESC>:lcs f s <c-r><c-w><cr>:lw<cr>
"command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
let g:GtagsCscope_Auto_Load=1
let g:GtagsCscope_Keep_Alive=1
let g:GtagsCscope_Absolute_Path=1
"let g:Gtags_Auto_Update=1
"let g:Gtags_OpenQuickfixWindow=1
let g:Gtags_No_Auto_Jump=1
let g:Gtags_Close_When_Single=0
"au VimEnter * call VimEnterCallback()
"au VimEnter * call AddGtags()
"call AddGtags()
"au BufAdd *.c,*.cpp,*.h call FindGtags(expand('<afile>'))

"au BufWritePost *.c,*.cpp,*.h call UpdateGtags(expand('<afile>'))
"map <silent><F12> :call UpdateGtags(expand('<afile>'))

function! UpdateGtags(f)
	let dir = fnamemodify(a:f, ':p:h')
	exe 'silent !cd ' . dir . ' && gtags --single-update % &> /dev/null &'
endfunction


"}}}

"gitsessions.vim ################# {{{

"let g:gitsessions_disable_auto_load = 1
let g:gitsessions_use_cache = 0

function! s:SaveSession()
	execute 'tabdo TagbarClose'
	execute 'NERDTreeTabsClose'
	execute 'GitSessionSave'
endfunction

function! RemoveSession()
	if v:this_session == ''
		echo "No need to remove session file"
		return
	endif
	let s:ssname = v:this_session
	let s:ssname .= ".open"
	echom "move" v:this_session "to" s:ssname
	silent call rename(v:this_session, s:ssname)
endfunction

function! RecoverSession()
	if v:this_session == ''
		echo "No session opened"
		return
	endif
	let s:ssname = v:this_session
	let s:ssname .= ".open"
	echo "move" s:ssname "to" v:this_session
	call rename(s:ssname, v:this_session)
	execute 'sync'
	"execute 'rename' s:ssname v:this_session
endfunction

function! LeaveSession()
	if v:this_session == ''
		echo "No session opened"
		return
	endif
	"call RecoverSession()
	execute 'tabdo TagbarClose'
	execute 'NERDTreeTabsClose'
	"need to comment this line from gitsession.vim
	call g:GitSessionUpdate()
endfunction

map <leader>gss :tabdo TagbarClose<CR>:NERDTreeTabsClose<CR>:GitSessionSave<CR>
map <leader>gsl :GitSessionLoad<cr>
map <leader>gsd :GitSessionDelete<cr>

autocmd! SessionLoadPost * :call RemoveSession()
autocmd! VimLeavePre * :call RecoverSession()
autocmd VimLeave * :call LeaveSession()

"}}}

"******************************************
"Special Setting

vnoremap <space> :
nnoremap <space> :

" Switching between buffers.
nmap <S-h> <C-W>h
nmap <S-l> <C-W>l
"nnoremap <C-k> <C-W>k
"nnoremap <C-j> <C-W>j
"inoremap <C-h> <Esc><C-W>h
"inoremap <C-j> <Esc><C-W>j
"inoremap <C-k> <Esc><C-W>k
"inoremap <C-l> <Esc><C-W>l

nmap <C-h> :tabp<cr>
"imap <C-left> <ESC>:tabp<cr>
nmap <C-l> :tabn<cr>
"imap <C-right> <ESC>:tabn<cr>

"Remember the last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


nmap <leader>ec :source ~/.vimrc<cr>
nmap <leader>ee :tabnew ~/.vimrc<cr>

"General Settings ##################### {{{
set   autoindent
set   autoread
set   autowrite
set   background=dark
set   backspace=indent,eol,start "allow backspace over everything in insert mode
set   nobackup
set   cindent
set   cinoptions=:0
set   cursorline  "show cursor line
set   completeopt=longest,menuone
set   noexpandtab
set   fileencodings=utf-8,gb2312,gbk,gb18030,ucs-bom,utf-8,prc
set   fileformat=unix
set   foldenable
set   foldmethod=marker
set   guioptions-=T
set   guioptions-=m
set   guioptions-=r
set   guioptions-=l
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   hlsearch

set   ignorecase
set   incsearch "do incremental search
set   laststatus=2
set   mouse=a "enable mouse
set   ttymouse=sgr
set   number  "show line number
set   pumheight=10
set   ruler  "show the cursor position all the time
set   scrolloff=5
set   shiftwidth=4
set   showcmd
set   smartindent
set   smartcase
set   tabstop=4
set   termencoding=utf-8
"set   textwidth=80
set   ww=h,l
"set   wildignore=*.bak,*.o,*.e,*~
"set   wildmenu
"set   wildmode=list:longest,full
"set   nowrap
set   autochdir
"set   hid
"
"set   smarttab
"set   wildmode=list:longest
"set   backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set   directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
""set   guitablabel=%t

syntax on

"}}}




