function! SCSSCompile()
    echo 'Compiling...'
    let cname = expand('%')
    let oname = expand('%:p:h:h') . '/css/' . expand('%:t:r') . '.css'
    execute printf(":!sass %s:%s --no-source-map", cname, oname)
endfunction

autocmd BufWritePost *.scss,*.sass call SCSSCompile()
