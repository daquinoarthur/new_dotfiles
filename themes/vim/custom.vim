" =============================================================================
" Custom Color Scheme - Beautiful Dark Theme with Transparent Backgrounds
" =============================================================================

" Vim color file
" Maintainer: Arthur Daquino <arthurdaquinosilva@gmail.com>
" Last Change: 2025-06-20
" License: MIT

" Initialization
set termguicolors
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "custom"

" =============================================================================
" COLOR PALETTE (Tokyo Night Style)
" =============================================================================
let s:bg_dark = '#1a1b26'
let s:bg_medium = '#2a2b3d'
let s:bg_highlight = '#3b3d57'
let s:bg_sidebar = '#414868'
let s:fg_main = '#c0caf5'
let s:fg_dim = '#444B6A'
let s:blue = '#7aa2f7'
let s:purple = '#ad8ee6'
let s:green = '#9ECE6A'
let s:yellow = '#E0AF68'
let s:red = '#F7768E'
let s:orange = '#E06C75'
let s:cyan = '#61AFEF'
let s:lime = '#98C379'
let s:magenta = '#E5C07B'

" GitGutter line background colors
let s:bg_git_add = '#20303b'
let s:bg_git_change = '#292421'
let s:bg_git_delete = '#2d202a'
let s:bg_git_change_delete = '#252129'

" =============================================================================
" BASIC HIGHLIGHTING
" =============================================================================
execute 'hi Normal guifg=' . s:fg_main . ' guibg=NONE ctermfg=250 ctermbg=NONE'
execute 'hi NonText guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE'
execute 'hi EndOfBuffer guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE'
execute 'hi Comment guifg=' . s:fg_dim . ' gui=italic ctermfg=240 cterm=italic'
execute 'hi Constant guifg=' . s:orange . ' ctermfg=203'
execute 'hi String guifg=' . s:green . ' ctermfg=114'
execute 'hi Character guifg=' . s:green . ' ctermfg=114'
execute 'hi Number guifg=' . s:orange . ' ctermfg=203'
execute 'hi Boolean guifg=' . s:orange . ' ctermfg=203'
execute 'hi Float guifg=' . s:orange . ' ctermfg=203'
execute 'hi Identifier guifg=' . s:cyan . ' ctermfg=117'
execute 'hi Function guifg=' . s:blue . ' ctermfg=111'
execute 'hi Statement guifg=' . s:purple . ' ctermfg=176'
execute 'hi Conditional guifg=' . s:purple . ' ctermfg=176'
execute 'hi Repeat guifg=' . s:purple . ' ctermfg=176'
execute 'hi Label guifg=' . s:purple . ' ctermfg=176'
execute 'hi Operator guifg=' . s:purple . ' ctermfg=176'
execute 'hi Keyword guifg=' . s:purple . ' ctermfg=176'
execute 'hi Exception guifg=' . s:purple . ' ctermfg=176'
execute 'hi PreProc guifg=' . s:purple . ' ctermfg=176'
execute 'hi Include guifg=' . s:purple . ' ctermfg=176'
execute 'hi Define guifg=' . s:purple . ' ctermfg=176'
execute 'hi Macro guifg=' . s:purple . ' ctermfg=176'
execute 'hi PreCondit guifg=' . s:purple . ' ctermfg=176'
execute 'hi Type guifg=' . s:cyan . ' ctermfg=117'
execute 'hi StorageClass guifg=' . s:cyan . ' ctermfg=117'
execute 'hi Structure guifg=' . s:cyan . ' ctermfg=117'
execute 'hi Typedef guifg=' . s:cyan . ' ctermfg=117'
execute 'hi Special guifg=' . s:yellow . ' ctermfg=221'
execute 'hi SpecialChar guifg=' . s:yellow . ' ctermfg=221'
execute 'hi Tag guifg=' . s:yellow . ' ctermfg=221'
execute 'hi Delimiter guifg=' . s:fg_main . ' ctermfg=250'
execute 'hi SpecialComment guifg=' . s:fg_dim . ' ctermfg=240'
execute 'hi Debug guifg=' . s:red . ' ctermfg=203'
execute 'hi Underlined guifg=' . s:blue . ' gui=underline ctermfg=111 cterm=underline'
execute 'hi Ignore guifg=' . s:fg_dim . ' ctermfg=240'
execute 'hi Error guifg=' . s:red . ' guibg=NONE ctermfg=203 ctermbg=NONE'
execute 'hi Todo guifg=' . s:green . ' gui=bold ctermfg=114 cterm=bold'

" =============================================================================
" INTERFACE ELEMENTS (WITH TRANSPARENCY)
" =============================================================================
execute 'hi LineNr guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE'
execute 'hi CursorLineNr guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CursorLine guibg=' . s:bg_medium . ' ctermbg=238'
execute 'hi CursorColumn guibg=' . s:bg_medium . ' ctermbg=238'
execute 'hi ColorColumn guibg=' . s:bg_medium . ' ctermbg=238'
execute 'hi SignColumn guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE'
execute 'hi FoldColumn guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE'
execute 'hi Folded guifg=' . s:bg_highlight . ' guibg=NONE ctermfg=245 ctermbg=NONE'
execute 'hi VertSplit guifg=' . s:bg_sidebar . ' guibg=NONE ctermfg=238 ctermbg=NONE gui=NONE cterm=NONE term=NONE'
execute 'hi StatusLine guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE gui=NONE cterm=NONE term=NONE'
execute 'hi StatusLineNC guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE gui=NONE cterm=NONE term=NONE'
execute 'hi StatusLineTerm guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE gui=NONE cterm=NONE term=NONE'
execute 'hi StatusLineTermNC guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE gui=NONE cterm=NONE term=NONE'
execute 'hi Tabline guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE gui=NONE cterm=NONE'
execute 'hi TablineSel guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE gui=NONE cterm=NONE'
execute 'hi TablineFill guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE gui=NONE cterm=NONE'

" =============================================================================
" SEARCH & SELECTION
" =============================================================================
execute 'hi Search guifg=' . s:bg_dark . ' guibg=' . s:yellow . ' ctermfg=235 ctermbg=221'
execute 'hi IncSearch guifg=' . s:bg_dark . ' guibg=' . s:orange . ' ctermfg=235 ctermbg=203'
execute 'hi Visual guibg=' . s:bg_highlight . ' ctermbg=245'
execute 'hi VisualNOS guibg=' . s:bg_highlight . ' ctermbg=245'
execute 'hi MatchParen guibg=' . s:bg_highlight . ' ctermfg=250 ctermbg=245'

" =============================================================================
" COMPLETION MENU
" =============================================================================
execute 'hi Pmenu guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi PmenuSel guifg=' . s:fg_main . ' guibg=NONE ctermfg=250 ctermbg=NONE'
execute 'hi PmenuSbar guibg=' . s:bg_sidebar . ' ctermbg=238'
execute 'hi PmenuThumb guibg=' . s:blue . ' ctermbg=111'

" =============================================================================
" FLOATING WINDOWS
" =============================================================================
execute 'hi FloatBorder guifg=' . s:bg_highlight . ' ctermfg=245'
execute 'hi NormalFloat guifg=' . s:fg_main . ' guibg=' . s:bg_dark . ' ctermfg=250 ctermbg=235'

" =============================================================================
" COC.NVIM INTEGRATION
" =============================================================================
execute 'hi CocPumMenu guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocPumSearch guifg=' . s:blue . ' guibg=NONE ctermfg=111 ctermbg=NONE'
execute 'hi CocMenuSel guifg=' . s:fg_main . ' guibg=NONE ctermfg=250 ctermbg=NONE'
execute 'hi CocPum guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocPumSel guifg=' . s:fg_main . ' guibg=NONE ctermfg=250 ctermbg=NONE'
execute 'hi CocMenu guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocPumFloating guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocPumVirtualText guifg=' . s:bg_highlight . ' guibg=NONE ctermfg=245 ctermbg=NONE'
execute 'hi CocPumDetail guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocPumShortcut guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocListLine guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocListMode guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi CocListPath guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'
execute 'hi FgCocListMode guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'

" Coc signs
execute 'hi CocErrorSign guifg=' . s:red . ' guibg=NONE ctermfg=203 ctermbg=NONE'
execute 'hi CocWarningSign guifg=' . s:yellow . ' guibg=NONE ctermfg=221 ctermbg=NONE'
execute 'hi CocInfoSign guifg=' . s:cyan . ' guibg=NONE ctermfg=117 ctermbg=NONE'
execute 'hi CocHintSign guifg=' . s:lime . ' guibg=NONE ctermfg=114 ctermbg=NONE'

" Coc floating windows
execute 'hi CocFloating guifg=' . s:fg_dim . ' guibg=NONE ctermfg=240 ctermbg=NONE'
execute 'hi CocBorder guifg=' . s:bg_highlight . ' ctermfg=245'

" =============================================================================
" GIT INTEGRATION
" =============================================================================
execute 'hi GitGutterAdd guifg=' . s:green . ' guibg=NONE ctermfg=114 ctermbg=NONE'
execute 'hi GitGutterChange guifg=' . s:yellow . ' guibg=NONE ctermfg=221 ctermbg=NONE'
execute 'hi GitGutterDelete guifg=' . s:red . ' guibg=NONE ctermfg=203 ctermbg=NONE'
execute 'hi GitGutterChangeDelete guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'

" GitGutter line highlights
execute 'hi GitGutterAddLine guibg=' . s:bg_git_add . ' ctermbg=22'
execute 'hi GitGutterChangeLine guibg=' . s:bg_git_change . ' ctermbg=58'
execute 'hi GitGutterDeleteLine guibg=' . s:bg_git_delete . ' ctermbg=52'
execute 'hi GitGutterChangeDeleteLine guibg=' . s:bg_git_change_delete . ' ctermbg=53'

execute 'hi SignifySignAdd guifg=' . s:green . ' guibg=NONE ctermfg=114 ctermbg=NONE'
execute 'hi SignifySignChange guifg=' . s:yellow . ' guibg=NONE ctermfg=221 ctermbg=NONE'
execute 'hi SignifySignDelete guifg=' . s:red . ' guibg=NONE ctermfg=203 ctermbg=NONE'

" =============================================================================
" MARKS & SIGNS
" =============================================================================
execute 'hi SignatureMarkText guifg=' . s:blue . ' guibg=NONE ctermfg=111 ctermbg=NONE'
execute 'hi SignatureMarkerText guifg=' . s:purple . ' guibg=NONE ctermfg=176 ctermbg=NONE'

" =============================================================================
" MATCHING & HIGHLIGHTING
" =============================================================================
execute 'hi HighlightedyankRegion guibg=' . s:bg_highlight . ' ctermbg=245'
execute 'hi MatchWord guibg=' . s:bg_highlight . ' ctermbg=245'
execute 'hi MatchWordCur guibg=' . s:bg_highlight . ' ctermbg=245'
execute 'hi MatchBackground guibg=' . s:bg_highlight . ' ctermbg=245'

" =============================================================================
" SPECIAL PLUGINS
" =============================================================================
execute 'hi VimwikiItalic guifg=' . s:purple . ' gui=italic ctermfg=176 cterm=italic'

" =============================================================================
" DIFF HIGHLIGHTING
" =============================================================================
execute 'hi DiffAdd guifg=' . s:green . ' guibg=' . s:bg_git_add . ' ctermfg=114 ctermbg=22'
execute 'hi DiffChange guifg=' . s:yellow . ' guibg=' . s:bg_git_change . ' ctermfg=221 ctermbg=58'
execute 'hi DiffDelete guifg=' . s:red . ' guibg=' . s:bg_git_delete . ' ctermfg=203 ctermbg=52'
execute 'hi DiffText guifg=' . s:yellow . ' guibg=' . s:bg_git_change . ' gui=bold ctermfg=221 ctermbg=58 cterm=bold'

" =============================================================================
" QUICKFIX & LOCATION LIST
" =============================================================================
execute 'hi QuickFixLine guibg=' . s:bg_highlight . ' ctermbg=245'
execute 'hi qfLineNr guifg=' . s:yellow . ' ctermfg=221'
execute 'hi qfFileName guifg=' . s:blue . ' ctermfg=111'

" =============================================================================
" SPELL CHECKING
" =============================================================================
execute 'hi SpellBad guifg=' . s:red . ' gui=underline ctermfg=203 cterm=underline'
execute 'hi SpellCap guifg=' . s:yellow . ' gui=underline ctermfg=221 cterm=underline'
execute 'hi SpellLocal guifg=' . s:cyan . ' gui=underline ctermfg=117 cterm=underline'
execute 'hi SpellRare guifg=' . s:purple . ' gui=underline ctermfg=176 cterm=underline'

" =============================================================================
" MISCELLANEOUS
" =============================================================================
execute 'hi Title guifg=' . s:blue . ' gui=bold ctermfg=111 cterm=bold'
execute 'hi Directory guifg=' . s:blue . ' ctermfg=111'
execute 'hi Conceal guifg=' . s:fg_dim . ' ctermfg=240'
execute 'hi MoreMsg guifg=' . s:green . ' ctermfg=114'
execute 'hi ModeMsg guifg=' . s:yellow . ' ctermfg=221'
execute 'hi Question guifg=' . s:green . ' ctermfg=114'
execute 'hi WarningMsg guifg=' . s:yellow . ' ctermfg=221'
execute 'hi ErrorMsg guifg=' . s:red . ' ctermfg=203'
execute 'hi WildMenu guifg=' . s:bg_dark . ' guibg=' . s:blue . ' ctermfg=235 ctermbg=111'

" =============================================================================
" VISUAL DIMMING FUNCTIONALITY
" =============================================================================

" Define dimming highlight group
highlight clear DimText
execute 'highlight DimText ctermfg=240 guifg=' . s:bg_medium

" Store match id and state
let s:dim_match = -1
let s:is_active = 0

" Store original Visual highlight settings
let s:original_visual = ""

" Function to save original Visual highlight
function! s:SaveVisualHighlight()
    redir => s:original_visual
    silent highlight Visual
    redir END
endfunction

" Function to handle visual mode
function! s:HandleVisual()
    if !s:is_active
        return
    endif

    if s:dim_match != -1
        silent! call matchdelete(s:dim_match)
        let s:dim_match = -1
    endif

    let mode_str = mode()
    if mode_str ==# 'v' || mode_str ==# 'V' || mode_str ==# "\<C-v>"
        let s:dim_match = matchadd('DimText', '\%(\%V\@!.\|\s*$\)', -1)
    endif
endfunction

" Reset everything
function! s:ResetHighlight()
    if s:dim_match != -1
        silent! call matchdelete(s:dim_match)
        let s:dim_match = -1
    endif
endfunction

" Toggle the dimming functionality
function! s:ToggleDimming()
    let s:is_active = !s:is_active
    if s:is_active
        " Save current Visual highlight if not saved
        if empty(s:original_visual)
            call s:SaveVisualHighlight()
        endif
        " Set dark background for Visual mode
        execute 'highlight Visual guibg=' . s:bg_dark
        echo "Visual dimming enabled"
        call s:HandleVisual()
    else
        " Restore original Visual highlight
        execute 'highlight Visual guibg=' . s:bg_highlight
        echo "Visual dimming disabled"
        call s:ResetHighlight()
    endif
endfunction

" =============================================================================
" VISUAL DIMMING AUTOCOMMANDS & KEYMAPS
" =============================================================================

" Clean up existing group
augroup VisualDimming
    autocmd!
augroup END

" Set up autocommands
augroup VisualDimming
    autocmd!
    autocmd ModeChanged [nN]:[vV\<C-v>]* if s:is_active | call s:HandleVisual() | endif
    autocmd ModeChanged [vV\<C-v>]*:[nN]* if s:is_active | call s:ResetHighlight() | endif
    autocmd InsertEnter * if s:is_active | call s:ResetHighlight() | endif
    autocmd BufEnter * if s:is_active | call s:ResetHighlight() | endif
    autocmd VimEnter * call s:ResetHighlight()
    " Ensure Visual highlight is set correctly when entering Vim
    execute 'autocmd VimEnter * highlight Visual guibg=' . s:bg_highlight
augroup END

" Define keymaps (change these to your preferred keys)
nnoremap <leader>h :call <SID>ToggleDimming()<CR>
vnoremap <leader>h <ESC>:call <SID>ToggleDimming()<CR>gv

" Initial cleanup and setup
call s:ResetHighlight()
execute 'highlight Visual guibg=' . s:bg_highlight

" =============================================================================
" NERDTREE CURSOR FIX
" =============================================================================
" Remove cursor underline when in NERDTree
augroup NERDTreeCursor
    autocmd!
    autocmd FileType nerdtree setlocal nocursorline
    autocmd FileType nerdtree setlocal nocursorcolumn
augroup END