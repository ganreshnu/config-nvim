hi clear Normal
set bg&

hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "simple"

highlight VertSplit		term=NONE cterm=NONE ctermfg=NONE ctermbg=DarkGrey gui=NONE guifg=NONE guibg=DarkGrey
highlight LineNrAbove	term=NONE cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight LineNr			term=NONE cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE
highlight LineNrBelow	term=NONE cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight NonText			term=NONE cterm=NONE ctermfg=White ctermbg=NONE gui=None guifg=White guibg=NONE
highlight PMenu			term=NONE cterm=NONE ctermfg=NONE ctermbg=DarkMagenta gui=None guifg=NONE guibg=DarkMagenta
highlight Search			term=NONE cterm=NONE ctermfg=Black ctermbg=DarkYellow gui=None guifg=NONE guibg=DarkYellow
highlight StatusLine		term=reverse cterm=NONE ctermfg=Black ctermbg=LightGrey gui=NONE guifg=NONE guibg=LightGrey
highlight StatusLineNC	term=NONE cterm=NONE ctermfg=NONE ctermbg=DarkGrey gui=NONE guifg=NONE guibg=DarkGrey


" begin the highlighting
highlight Comment			term=italic cterm=italic ctermfg=Grey ctermbg=NONE gui=italic guifg=Grey guibg=NONE
highlight Constant		term=NONE cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE
highlight Special			term=NONE cterm=NONE ctermfg=White ctermbg=NONE gui=NONE guifg=White guibg=NONE
highlight Identifier		term=bold cterm=bold ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
highlight Statement		term=bold cterm=bold ctermfg=White ctermbg=NONE gui=NONE guifg=White guibg=NONE
highlight PreProc			term=NONE cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight Type				term=bold cterm=bold ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE
highlight Underlined		term=underline cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE guibg=NONE
highlight Ignore			term=NONE cterm=NONE ctermfg=DarkGrey ctermbg=DarkGrey gui=NONE guifg=DarkGrey guibg=NONE

highlight Error			term=reverse cterm=NONE ctermfg=NONE ctermbg=Red gui=NONE guifg=NONE guibg=Red
highlight Todo				term=bold cterm=bold ctermfg=NONE ctermbg=DarkGrey gui=NONE guifg=NONE guibg=DarkGrey


