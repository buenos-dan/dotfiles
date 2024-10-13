vim9script

# DONT USE THIS PLUGIN
if true
    finish
endif

const API = "https://api.dictionaryapi.dev/api/v2/entries/en/"

def OnResponse(ch: channel, msg: string)
    const json = json_decode(msg)

    if type(json) != v:t_list
	echom "Sorry, no definition found"
	return
    endif

    final lines = [json[0].word]
    for meaning in json[0].meanings
        const pos = meaning.partOfSpeech
	for definition in meaning.definitions
	    add(lines, '(' .. pos .. ')' .. definition.definition)
	endfor
    endfor

    # Sst quickfix list
    setqflist([], 'r', {lines: lines})
    copen
enddef

def OnError(ch: channel, msg: string)
    echoe "Job failed: " .. msg
enddef

def DefineWord(word: string)
   const cmd = ['curl', '--silent', API .. word] 
   const job = job_start(cmd, {
	out_cb: OnResponse,
	err_cb: OnError
   })
enddef

command! DefineWord exec "DefineWord('" .. expand('<cword>') .. "')"
nnoremap <leader>dw :DefineWord<CR>
