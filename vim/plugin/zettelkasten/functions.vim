vim9script

if !exists('g:loaded_zettelkasten')
    finish
endif

const vault = "~/Zettelkasten/"
const diary = vault .. "diary/"
const study = vault .. "study/"
const idea = vault .. "idea/"

def InsertTemplate()
    const today: string = split(system("date '+%Y-%m-%d'"), '\n')[0]
    execute "normal i" .. "---"
    execute "normal o" .. "date: " .. today
    execute "normal o" .. "---"
    execute "normal o"
enddef

def OpenNote(filename: string, allow_create: bool)
    if filewritable(filename)
        execute "edit + " .. fnameescape(filename)
    elseif allow_create
        execute "edit + " .. fnameescape(filename)
        InsertTemplate()
    else
	echom "No diary found"
    endif
enddef

def IsDiaryNote(filename: string): bool
    const pat = "^" .. expand(diary) .. "\\d\\{4}-\\d\\{2}-\\d\\{2}\\.md" .. "$"
    if filename =~# pat
	return true
    else
	return false
    endif
enddef

def OpenTodayDiaryNote()
    const today: string = system("date '+%Y-%m-%d'")[ : -2]
    const filename = expand(diary .. today .. ".md")
    OpenNote(filename, true)
enddef

def OpenRelativeDiaryNote(offset_day: number)
    const cur_file = expand('%:p') 
    if IsDiaryNote(cur_file)
        const tgt_date = cur_file[-13 : -4]
        const next_ts = string(str2nr(system("date -j -f '%Y-%m-%d' " .. tgt_date .. " '+%s'")) + 86400 * offset_day)
	const next_date = system("date -r " .. next_ts .. " '+%Y-%m-%d'")[ : -2]
	const filename = expand(diary .. next_date .. ".md")

	OpenNote(filename, false)
    else
	echom "Not a diary file"
    endif
enddef

def CreateNote(type: string)
    if type == 'idea'
        var filename = input('Create an idea note: ')
	if filename == ''
	    return
	endif
	filename = expand(idea .. filename .. ".md")
	OpenNote(filename, true)
    elseif type == 'study'
        var filename = input('Create a study note: ')
	if filename == ''
	    return
	endif
	filename = expand(study .. filename .. ".md")
	OpenNote(filename, true)
    else
	echom "Invalid type: " .. type
    endif
enddef

command! OpenTodayDiaryNote execute "OpenTodayDiaryNote()"
command! OpenPreviousDiaryNote execute "OpenRelativeDiaryNote(-1)"
command! OpenNextDiaryNote execute "OpenRelativeDiaryNote(1)"
command! CreateIdeaNote execute "CreateNote('idea')"
command! CreateStudyNote execute "CreateNote('study')"
nnoremap <leader>dd :OpenTodayDiaryNote<CR>
nnoremap <leader>dp :OpenPreviousDiaryNote<CR>
nnoremap <leader>dn :OpenNextDiaryNote<CR>
nnoremap <leader>ci :CreateIdeaNote<CR>
nnoremap <leader>cs :CreateStudyNote<CR>

