vim9script

if !exists('g:loaded_zettelkasten')
    finish
endif

const vault = "~/Zettelkasten/"
const fleeting   = vault .. "fleeting_note/"
const staging    = vault .. "staging_note/"
const permanent = vault .. "permanent_note/"
const paper      = vault .. "pdf/"

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

def CreateFleetingNote()
    var filename = system("date '+%Y-%m-%d-%H-%M-%S'")[ : -2]
    filename = expand(fleeting .. filename .. ".md")
    OpenNote(filename, true)
enddef

def RandomOpenFleetingNote()
    var fleeting_notes = systemlist('ls ' .. fleeting)
    if empty(fleeting_notes)
	CreateFleetingNote()
    else
        var random_file = fleeting_notes[rand() % len(fleeting_notes)]
        echom random_file
        execute "edit + " .. fleeting .. random_file
    endif
enddef

def OpenObsidian(filename: string)
    const cmd = "open 'obsidian://open?vault=Zettelkasten&file=" .. filename .. "'"
    system(cmd)
enddef

command! RandomOpenFleetingNote execute "RandomOpenFleetingNote()"
command! CreateFleetingNote execute "CreateFleetingNote()"
command! OpenObsidian execute "OpenObsidian('" .. expand('%:t') .. "')"
nnoremap <leader>n :RandomOpenFleetingNote<CR>
nnoremap <leader>c :CreateFleetingNote<CR>
nnoremap <leader>o :silent OpenObsidian<CR>

set path=.,/usr/local/include,/usr/include,/Users/bytedance/Zettelkasten/fleeting_note
