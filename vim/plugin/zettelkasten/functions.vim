vim9script

if !exists('g:zettelkasten_mode')
    finish
endif

const vault = "~/Zettelkasten/"
const diary = vault .. "diary/"
const study = vault .. "study/"
const idea = vault .. "idea/"

def OpenDiaryNote()
    const today: string = system("date '+%Y-%m-%d'")[ : -2]
    const cmd = "edit + " .. expand(diary .. today .. ".md")
    execute cmd
enddef

def OpenPreviousDiaryNote()
    # Check current file is a diary
    const pat = "^" .. expand(diary) .. "\\d\\{4}-\\d\\{2}-\\d\\{2}\\.md" .. "$"
    const expr = expand('%:p')
    if expr =~# pat
        const tgt_date = expr[-13 : -4]
        const prev_ts = string(str2nr(system("date -j -f '%Y-%m-%d' " .. tgt_date .. " '+%s'")) - 86400)
	const prev_date = system("date -r " .. prev_ts .. " '+%Y-%m-%d'")[ : -2]

        const cmd = "edit + " .. expand(diary .. prev_date .. ".md")
        execute cmd
    else
	echom "Not a diary file"
    endif
enddef

def OpenNextDiaryNote()
    # Check current file is a diary
    const pat = "^" .. expand(diary) .. "\\d\\{4}-\\d\\{2}-\\d\\{2}\\.md" .. "$"
    const expr = expand('%:p')
    if expr =~# pat
        const tgt_date = expr[-13 : -4]
        const next_ts = string(str2nr(system("date -j -f '%Y-%m-%d' " .. tgt_date .. " '+%s'")) + 86400)
	const next_date = system("date -r " .. next_ts .. " '+%Y-%m-%d'")[ : -2]

        const cmd = "edit + " .. expand(diary .. next_date .. ".md")
        execute cmd
    else
	echom "Not a diary file"
    endif
enddef

def CreateNote(type: string)
    if type == 'idea'
        const filename = input('Create an idea note: ')
	if filename == ''
	    return
	endif
        const cmd = "edit + " .. expand(idea .. filename .. ".md")
        execute cmd
    elseif type == 'study'
        const filename = input('Create a study note: ')
	if filename == ''
	    return
	endif
        const cmd = "edit + " .. expand(study .. filename .. ".md")
        execute cmd
    else
	echom "Invalid type: " .. type
    endif
enddef

command! OpenDiaryNote execute "OpenDiaryNote()"
command! OpenPreviousDiaryNote execute "OpenPreviousDiaryNote()"
command! OpenNextDiaryNote execute "OpenNextDiaryNote()"
command! CreateIdeaNote execute "CreateNote('idea')"
command! CreateStudyNote execute "CreateNote('study')"
nnoremap <leader>dd :OpenDiaryNote<CR>
nnoremap <leader>dp :OpenPreviousDiaryNote<CR>
nnoremap <leader>dn :OpenNextDiaryNote<CR>
nnoremap <leader>ci :CreateIdeaNote<CR>
nnoremap <leader>cs :CreateStudyNote<CR>

