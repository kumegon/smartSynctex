function! smartSynctex#backward_search(file, line) abort
	" memorize the current position of the cursor
	exec 'normal! m`'
	exec "call cursor(".line('.').",".col('.').")"
	let l:current_fname = expand('%:p')
	let l:tablist = gettabinfo()
	let l:flag = 1
	for tab in l:tablist
		for winid in tab['windows']
			let l:buf_nr = winbufnr(winid)
			let l:buf_fname = expand('#'.l:buf_nr.':p')
			if l:buf_fname == a:file
				call win_gotoid(winid)
				let l:flag = 0
				exec 'normal! m`'
				exec 'call cursor('.a:line.',0)'
				break
			endif
		endfor
	endfor
	if l:flag
		exec 'tabnew +' .  a:line . ' ' . a:file
	endif
	if foldclosed(a:line) > 0
		exec 'normal zv'
	endif
	exec 'normal zz'
	exec 'setlocal cursorline'
endfunction
