" 문법 하이라이트
if has("syntax")
    syntax on
endif


set t_Co=256					" iTerm2 supports 256 color mode.
set showmode                    " always show what mode we're currently editing in

" Tap space
set tabstop=4
set softtabstop=4
set shiftwidth=4                " 자동 들여쓰기 4칸
set smarttab 					" ts, sts, sw 값을 참조하여, 탭과 백스페이스의 동작 보조
set expandtab 					" Tab을 space로 변환
set wrap        
set nobackup					" 백업 파일 만들지 않음
set nu							" Line number
set ruler                       " 현재 커서 위치의 줄번호와 행번호 출력한다.
set history=1000				" vi 편집기록 기억갯수 .viminfo에 기록
set autoindent					" 자동 들여쓰기
set cindent						" C 프로그래밍용 자동 들여쓰기
set smartindent					" 
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set nobackup                    " backup 파일 만들지 않음
set noswapfile
set title                       " change the terminal's title
set laststatus=2                " Status 출력 (0: 출력 안함, 1: 창이 2개이상일 때 출력, 2: 항상출력)
set showmatch                   " 괄호 매칭

set t_Co=256            		" iTerm2 supports 256 color mode.

" Search
set hlsearch " 검색할 때 매칭되는 문자열 하이라이트
set incsearch " Incremental search 칠 때마다 그 단어에 맞게 검색
set smartcase " 검색 시 대소문자 구분
set ignorecase " 검색 시 대소문자 무시
set nowrapscan " 검색할 때 문서의 끝에서 처음으로 안 돌아감

" Clipboard copy
" https://rampart81.github.io/post/vim-clipboard-share/
set clipboard=unnamedplus
set mouse=a                     " vim에서 마우스 사용

" Cursur shape in vim mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

" 인코딩 파일을 수동으로 설정
set fileencodings=utf8,euc-kr
set encoding=utf-8

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" Python Tab
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

" Vundle
set nocompatible				" 기존 vi와 호환하지 않음
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
" ==============================================================
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fisadev/vim-isort' 
Plugin 'preservim/nerdtree'
Plugin 'psf/black'
Plugin 'dracula/vim', { 'name': 'dracula' }
" ==============================================================
call vundle#end()
filetype plugin indent on

"" YCM
"let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <C-g> :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion = ['j']
let g:ycm_key_list_previous_completion=['k']

let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filetype_blacklist = {}


"" Black
" default
"let g:black_fast=0
"let g:black_linelength=88
"let g:black_skip_string_normalizatio=0
"let g:black_virtualenv="~/.vim/black"

"" Isort
let g:vim_isort_map = ''
let g:vim_isort_config_overrides = {
    \ 'include_trailing_comma': 1, 
    \ 'multi_line_output': 3}

"" NerdTree
"autocmd vimenter * NERDTree " vim 열 때 같이 Nerd open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " 닫아서 Nerd만 남을 경우 같이 닫음
map <C-n> :NERDTreeToggle<CR>

""" formatting on save
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.py execute ':Isort'

"" FZF with vim
nnoremap <silent> <C-f> :FZF<CR>
colorscheme dracula
