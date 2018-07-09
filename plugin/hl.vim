function! HL_define_hl()
	highlight hl_def_0 cterm=bold ctermfg=green guifg=#40ff40 gui=bold
	highlight hl_def_1 cterm=bold ctermfg=red guifg=#ff4040 gui=bold
	highlight hl_def_2 cterm=bold ctermfg=cyan guifg=#00ffff gui=bold
	highlight hl_def_3 cterm=bold ctermfg=magenta  guifg=#ff40ff gui=bold
	highlight hl_def_4 cterm=bold ctermfg=yellow guifg=#ffff00 gui=bold
	highlight hl_def_5 cterm=bold ctermfg=blue guifg=#8080ff gui=bold
	highlight hl_def_6 cterm=bold ctermfg=white guifg=#ffffff gui=bold
	highlight hl_def_7 cterm=bold ctermfg=gray guifg=#808080 gui=bold
endfunction

function! HL_update()
	" create the window buffer matches
	if !exists("w:b_matches")
		let w:b_matches = []
	endif
	let i=0
	while i < len(w:b_matches)
		call matchdelete(w:b_matches[i])
		let i = i + 1
	endwhile
	let w:b_matches = []
	if !exists("b:matches")
		return
	endif
	let i=0
	call HL_define_hl()
	while i < len(b:matches)
		call add(w:b_matches, matchadd("hl_def_".b:matches[i][0], b:matches[i][1], -1))
		let i = i + 1
	endwhile
endfunction

au BufEnter * call HL_update()
au WinEnter * call HL_update()

function! HLW(...)
	if !exists("w:matches")
		let w:matches = [-1,-1,-1,-1,-1,-1,-1,-1]
	endif
	let id = -1
	let exp = ""
	if a:0 > 0
		let id = a:1
	endif
	if a:0 > 1
		let exp = a:2
	endif

	if id == -1
		let i=0
		while i < 8
			if w:matches[i] != -1
				call matchdelete(w:matches[i])
			endif
			let w:matches[i] = -1
			let i = i + 1
		endwhile
	else
		if w:matches[id] != -1
			call matchdelete(w:matches[id])
		endif
		let w:matches[id] = -1
		if exp != ""
			call HL_define_hl()
			let w:matches[id] = matchadd("hl_def_".id, exp, -1)
		endif
	endif
endfunction

function! HL(...)
	if !exists("b:matches")
		let b:matches = []
	endif
	let id = -1
	let exp = ""
	if a:0 > 0
		let id = a:1
	endif
	if a:0 > 1
		let exp = a:2
	endif
		
	if id == -1
		let b:matches = []
	else
		let i=0
		while i < len(b:matches)
			if b:matches[i][0] == id
				unlet b:matches[i]
			else
				let i = i + 1
			endif
		endwhile
		if exp != ""
			call add(b:matches, [id, exp])
		endif
	endif
	call HL_update()
endfunction


function! HL_extract_id(...)
	if a:1 == ""
		return -1
	endif
	return str2nr(a:1)
endfunction

function! HL_extract_expr(...)
	let pos = match(a:1, " ")
	if pos == -1
		return ""
	endif
	return strpart(a:1, pos+1)
endfunction

function! HL_command(...)
	let id = HL_extract_id(a:1)
	let exp = HL_extract_expr(a:1)
	call HL(id, exp)
endfunction

function! HLW_command(...)
	let id = HL_extract_id(a:1)
	let exp = HL_extract_expr(a:1)
	call HLW(id, exp)
endfunction

function! HL_save(...)
	let l:hl_rules = ["HL"]

	let i=0
	while i < len(b:matches)
		call add(l:hl_rules, "HL ".b:matches[i][0]." ".b:matches[i][1] )
		let i = i + 1
	endwhile
	call writefile(l:hl_rules, a:1)
endfunction

command! -nargs=* -complete=command HL call HL_command(<q-args>)
command! -nargs=* -complete=command HLW call HLW_command(<q-args>)
command! -nargs=1 -complete=command HLSave call HL_save(<q-args>)

