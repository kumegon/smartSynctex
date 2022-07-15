function! smartSynctex#backward_search(file, line) abort
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
				exec a:line
				break
			endif
		endfor
	endfor
	if l:flag
		exec 'tabnew +' .  a:line . ' ' . a:file
	endif
	exec 'normal z'
	if foldclosed(a:line) > 0
		exec 'norm zv'
	endif
	exec 'setlocal cursorline'
endfunction
