" === Fonts ===
" You Nedd: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
" === Mapping keys and command ===
" \q  Close Buffer
" \ed File manager
" \ef File manager (Floating window)
" gd Goto Definition
" gb GoBack
" \ff Global Variables, Functions, etc..
" :GV Nice Git logs viewer
" === Fzf ===
" \sf File Search
" \sm File History
" \sb Open Buffers
" Search files by keywords
" :Rg keywords
" === snippets ===
" ctrl+l for trigger snippet expand
" ctrl+j for jump to next placeholder

" ==========================================
" ============  * Environment *  ==============
" ==========================================
" China Speed, Only work in china.
let g:china_speed = 1
if g:china_speed
	let $china=1
endif

" Use Coc Development Kit
" https://github.com/neoclide/coc.nvim
" https://github.com/weirongxu/coc-explorer
" https://github.com/iamcco/coc-diagnostic
" https://github.com/neoclide/coc-snippets
let g:coc_kit = 1

" ##### Detect System And Version
if has("win32unix")
	let g:OS#name = "unix"
	let g:OS#unix = 1
	let g:OS#win = 0
	let g:OS#mac = 0
elseif has("win32") || has("win32unix")
	let g:OS#name = "win"
	let g:OS#win = 1
	let g:OS#mac = 0
	let g:OS#unix = 0
elseif has("mac")
	let g:OS#name = "mac"
	let g:OS#mac = 1
	let g:OS#win = 0
	let g:OS#unix = 0
elseif has("unix")
	let g:OS#name = "unix"
	let g:OS#unix = 1
	let g:OS#win = 0
	let g:OS#mac = 0
endif
if has("gui_running") || exists('g:GuiLoaded')
	let g:OS#gui = 1
else
	let g:OS#gui = 0
endif
if has('nvim')
	let g:OS#nvim = 1
else
	let g:OS#nvim = 0
endif

" ##### Init Base Path Variable
if g:OS#win
	behave mswin
	let $VIMFILES = $VIM
	source $VIMRUNTIME/mswin.vim
elseif g:OS#unix
	let $VIM = $HOME
	let $VIMFILES = '~/.config/nvim'
elseif g:OS#mac
	let $VIM = $HOME
	let $VIMFILES = $HOME.'/.config/nvim'
endif



" ======================================
" ============  * Base *  ==============
" ======================================

" ##### ENCODING
set encoding=utf-8
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936
"set termencoding=utf-8

" ##### File Format
set ff=unix

" ##### Disable UTF-8 BOM
set nobomb

" ##### Auto File Type Detect
filetype on
" Highlight for MD file.
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *.MD set filetype=markdown

filetype indent on           " Auto Indent
filetype plugin on           " Auto Plugin
filetype plugin indent on    " Auto Indent
set autoindent
"set expandtab
set tabstop=4 " Tab
set shiftwidth=4
set smarttab
" indent for golang
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

set nobackup
set noswapfile
set writebackup

set number
if g:OS#gui
	set mouse=a
endif
set numberwidth=5
set laststatus=2
set shortmess=atI
set cursorline " Highlight Cursor Line
set guioptions-=T " Hide Tool bar
set showmatch " Highlight symbol
set incsearch " Search Real-time
set hlsearch  " Highlight Search
set list
set listchars=tab:-->,trail:-
set termguicolors
"set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme slate
syntax enable
syntax on
" ctrl+] _" to ": _
imap <C-]> <C-o>a:<space>
" ctrl+[ _" to ", _
imap <C-\> <C-o>a,<space>
" \c to copy the visual selection to the system clipboard
vnoremap <Leader>c "+y
" \v to paste the content of the system clipboard
nnoremap <Leader>v "+p
nnoremap <Leader>te :tabnew<CR>
nnoremap <Leader>tn :tabNext<CR>
nnoremap <Leader>tq :tabclose<CR>
tnoremap <C-q> <C-\><C-n>
" \q close buffer
nmap <Leader>q :bd<CR>
" gb go back
nmap <silent> gb <C-o>

" gvim font
if !g:OS#nvim
	if g:OS#win
		set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
	endif
	set guifont=FiraCode_Nerd_Font_Mono:h12:W500:cANSI:qDRAFT
endif

function UIInit()
	call PlugConfUIInit()

	" neovim-qt font
	if g:OS#nvim
		if exists(':Guifont')
			execute ":Guifont! FiraCode Nerd Font:h13"
			execute ":GuiTabline 0"
			execute ":GuiPopupmenu 0"
		endif 
	endif
endfunction

if g:OS#nvim
	autocmd! UIEnter * call UIInit()
else
	autocmd! VimEnter * call UIInit()
endif


" ==========================================
" ============  * Advanced *  ==============
" ==========================================

" ============  * Plugin *  ==============
function PlugDef()
	Plug 'mhinz/vim-startify'
	Plug 'psliwka/vim-smoothie'
	" colorscheme
	Plug 'hzchirs/vim-material'
	Plug 'tyrannicaltoucan/vim-deep-space'
	" statusline/tabline plugin
	Plug 'itchyny/lightline.vim'

	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'ryanoasis/vim-devicons' " File icons

	"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

	Plug 'easymotion/vim-easymotion' " Fast move cursor
	" Fuzzy finder
	Plug 'geekjam/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'geekjam/rg', { 'do': { -> rg#install() }}

	Plug 'sheerun/vim-polyglot' "Programming syntax highlight pack
	Plug 'ap/vim-css-color' "css color display

	" === Git Plugin ===
	Plug 'tpope/vim-fugitive' " Base Git support
	Plug 'junegunn/gv.vim' " Nice git logs plugin
	" File Git status
	if has('nvim') || has('patch-8.0.902')
		Plug 'mhinz/vim-signify'
	else
		Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
	endif

	" Auto closing plugin
	Plug 'Raimondi/delimitMate'
	Plug 'gregsexton/MatchTag'

	" Last Edit Line
	Plug 'farmergreg/vim-lastplace'

	Plug 'tomtom/tcomment_vim'

	Plug 'honza/vim-snippets'
	if g:coc_kit
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
	endif
endfunction

function ThemeConf(timer)
	let theme = 'vim-material'
	let nightTheme = 'deep-space'
	let g:material_style='palenight'
	let hr = (str2nr(strftime('%H')))
	if hr > 18 || hr < 7
		let theme = 'deep-space'
	endif

	if g:colors_name != theme
		if theme == 'vim-material'
			colorscheme vim-material
		else
			colorscheme deep-space
		endif
	endif
endfunction

function PlugConf()
	" colorscheme config
	try
		call ThemeConf(0)
		if exists('*timer_start')
			call timer_start(10000, 'ThemeConf', {"repeat": -1})
		endif
	catch /^Vim\%((\a\+)\)\=:E185/
		"other
	endtry

	" syntax highlight config
	let g:go_highlight_functions = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_variable_assignments = 1
	let g:go_highlight_variable_declarations = 1

	" indent guides config
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_guide_size = 1
	let g:indent_guides_exclude_filetypes = ['help', 'coc-explorer', 'startify', 'fzf']
	map <F11> :w<cr>:IndentGuidesEnable<cr>

	" lightline config
	let g:lightline = {}
	let g:lightline.colorscheme="wombat"
	let g:lightline.active = {'left': [['mode', 'paste'], ['gitstatus', 'readonly', 'filename', 'modified']]}
	let g:lightline["component_function"] = { 'gitstatus': 'GitStatus'}
	let g:lightline#bufferline#enable_devicons = 1
	function GitStatus()
		let status = FugitiveStatusline()
		return status
	endfunction

	" fzf config
	" disable preview window
	let g:fzf_preview_window = ''
	let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.6 } }
	noremap <leader>sf :Files<CR>
	noremap <leader>sm :History<CR>
	noremap <leader>sb :Buffers<CR>

	"easymotion config
	nmap s <Plug>(easymotion-overwin-f2)
endfunction

function PlugConfUIInit()
	if exists('g:coc_enabled')
		call CocConf()
	endif
endfunction

function CheckGoInstall()
	if !executable('gopls')
		echo 'Installing go-tools -> gopls..'
		silent exec "!go get golang.org/x/tools/gopls@latest"
		if executable('gopls')
			echo 'Install complete.'
		else
			echoerr 'Install Faild.'
		endif
	endif

	if !executable('goreturns')
		echo 'Installing go-tools -> goreturns..'
		silent exec "!go get github.com/sqs/goreturns"
		if executable('goreturns')
			echo 'Install complete.'
		else
			echoerr 'Install Faild.'
		endif
	endif

	if !executable('golangci-lint')
		echo 'Installing go-tools -> golangci-lint..'
		if g:OS#win
			let tempfile=tempname().".ps1"
			silent exec "!powershell -NoProfile -Command chcp 65001;Invoke-WebRequest https://raw.githubusercontent.com/geekjam/Scripts/master/golangci-lint.ps1 -OutFile ".tempfile
			silent exec "!powershell -NoProfile -File ".tempfile
		else
			let tempfile=tempname().".sh"
			silent exec "!curl -L -o ".tempfile." https://raw.githubusercontent.com/geekjam/Scripts/master/golangci-lint.sh"
			silent exec "!sh ".tempfile
		endif
		if executable('golangci-lint')
			echo 'Install complete.'
		else
			echoerr 'Install Faild.'
		endif
	endif
endfunction

function CocConf()
	" ===  * Coc.Nvim *  ===
	call CheckGoInstall()
	let g:coc_global_extensions = ['coc-json', 'coc-explorer', 'coc-diagnostic', 'coc-snippets']

	" coc explorer
	let g:coc_explorer_global_presets={}
	let g:coc_explorer_global_presets['floating']={'position': 'floating','open-action-strategy': 'sourceWindow'}
	let g:coc_explorer_global_presets['simplify']={'file-child-template': '[git] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1] [filename omitCenter 1]'}
	autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
	nmap <Leader>ed :CocCommand explorer --preset simplify<CR>
	nmap <Leader>ef :CocCommand explorer --preset floating<CR>

	" coc user config
	let g:coc_user_config = {}
	" coc-snippets
	let g:coc_user_config['snippets.ultisnips.enable'] = v:false
	" Use <C-l> for trigger snippet expand
	imap <C-l> <Plug>(coc-snippets-expand)

	" coc-explorer
	let g:coc_user_config['explorer.icon.enableNerdfont'] = v:true
	let g:coc_user_config['explorer.keyMappings'] = {"<cr>": ["expandable?", ["expanded?", "collapse", "expand"], "open"]}
	" coc-diagnostic
	let g:coc_user_config['diagnostic-languageserver.filetypes'] = { 'go': "golangci-lint" }
	let g:coc_user_config['diagnostic-languageserver.formatters'] = { 'goreturns': { "command": "goreturns", "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"] } }
	let g:coc_user_config['diagnostic-languageserver.formatFiletypes'] = { 'go': "goreturns" }
	let g:coc_user_config['coc.preferences.formatOnSaveFiletypes'] = [ 'go' ]
	" coc languageserver golang
	let g:coc_user_config['languageserver'] = {'golang':{}}
	let g:coc_user_config['languageserver']['golang']={}
	let g:coc_user_config['languageserver']['golang']['command']='gopls'
	let g:coc_user_config['languageserver']['golang']['rootPatterns']=["go.mod", ".vim/", ".git/", ".hg/"]
	let g:coc_user_config['languageserver']['golang']['filetypes']=["go"]
	let g:coc_user_config['languageserver']['golang']['initializationOptions']={"completeUnimported": v:true}

	"TextEdit might fail if hidden is not set.
	set hidden
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300
	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	if has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif

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

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
	if exists('*complete_info')
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	" Use K to show documentation in preview window.
	nnoremap <silent> D :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>') 
		else
			call CocAction('doHover')
		endif
	endfunction
	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Mappings using CoCList:
	" Show all diagnostics.
	nnoremap <silent> <Leader>el  :<C-u>CocList diagnostics<cr>
	" Find symbol of current document.
	nnoremap <silent> <Leader>ff  :<C-u>CocList outline<cr>
endfunction

function PlugInstalledDo()
	if exists(":CocUpdate")
		execute ":bd"
		call CocConf()
		echo
		execute ":redraw!"
		echo 'Installing coc-extensions..'
		execute ":CocStart"
	endif
endfunction

" ============  * Plugin Loader *  ==============
" ##### Plugin Save Path Variable
let $PLUGPATH = $VIMFILES.'/plugged/'
if g:OS#win
	let $PLUGPATH = $VIMFILES.'\plugged\'
endif

" ##### Plugin Install Check Path
let $VIMPLUG_CHECKPATH = $PLUGPATH.'vim-plug/plug.vim'
if g:OS#win
	let $VIMPLUG_CHECKPATH = $PLUGPATH.'vim-plug\plug.vim'
endif

let vimplug_readme=expand($VIMPLUG_CHECKPATH)
if filereadable(vimplug_readme)
	let g:PlugInit = 1
else
	let g:PlugInit = 0
endif

function PlugInit()
	if g:OS#win
		source $VIMFILES\plugged\vim-plug\plug.vim
	else
		source $VIMFILES/plugged/vim-plug/plug.vim
	endif
	if g:china_speed
		"let g:plug_url_format = 'https://git::@github.com.cnpmjs.org/%s.git'
		let g:plug_url_format = 'https://git::@hub.fastgit.org/%s.git'
	endif
	call plug#begin($PLUGPATH)
	call PlugDef()
	call plug#end()
endfunction

if g:PlugInit
	call PlugInit()
	call PlugConf()
endif

function s:vimPlugInstall()
	echo "Installing Vim-Plug..."
	if g:OS#win
		silent exec "!mkdir" . " " . $PLUGPATH
	else
		silent exec "!mkdir" . " -p " . $PLUGPATH
	endif
	if executable('git')
		if g:china_speed
			silent exec "!git clone --depth 1 https://hub.fastgit.org/junegunn/vim-plug" . " " .  $PLUGPATH.'vim-plug'
			"silent exec "!git clone --depth 1 https://github.com.cnpmjs.org/junegunn/vim-plug" . " " .  $PLUGPATH.'vim-plug'
		else
			silent exec "!git clone --depth 1 https://github.com/junegunn/vim-plug" . " " .  $PLUGPATH.'vim-plug'
		endif
		echo
	endif
	echo "Installing plugins.."
	call PlugInit()
	execute ":PlugInstall --sync | call PlugInstalledDo()"
endfunction

if !exists(':PlugInstall')
	command! -nargs=0 -bar PlugInstall  call s:vimPlugInstall()
endif
