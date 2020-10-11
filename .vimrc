" 문법 하이라이트
if has("syntax")
    syntax on
endif


set t_Co=256					" iTerm2 supports 256 color mode.
set showmode                    " always show what mode we're currently editing in

" Tap space
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab 					" ts, sts, sw 값을 참조하여, 탭과 백스페이스의 동작 보조
set expandtab 					" Tab을 space로 변환

set nobackup					" 백업 파일 만들지 않음
set nu							" Line number
set history=1000				" vi 편집기록 기억갯수 .viminfo에 기록
set autoindent					" 자동 들여쓰기
set cindent						" C 프로그래밍용 자동 들여쓰기
set smartindent					"
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

set title                       " change the terminal's title

set laststatus=2 " Status 출력 (0: 출력 안함, 1: 창이 2개이상일 때 출력, 2: 항상출력)
set showmatch " 괄호 매칭

set t_Co=256            		" iTerm2 supports 256 color mode.

" Search
set hlsearch " 검색할 때 매칭되는 문자열 하이라이트
set incsearch " Incremental search 칠 때마다 그 단어에 맞게 검색
set smartcase " 검색 시 대소문자 구분
set ignorecase " 검색 시 대소문자 무시

" Clipboard copy
set clipboard=unnamedplus

set ruler " 현재 커서 위치의 줄번호와 행번호 출력한다.

" 인코딩 파일을 수동으로 설정
set fileencodings=utf8,euc-kr

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
" ==============================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'valloric/youcompleteme'

call vundle#end()
" ==============================================================
filetype plugin indent on

