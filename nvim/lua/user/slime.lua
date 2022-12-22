vim.cmd([[
    let g:slime_no_mappings = 1
    xmap <leader>sl <Plug>SlimeRegionSend
    nmap <leader>sl <Plug>SlimeRegionSend
    nmap <leader>sr <Plug>SlimeRegionSend
    let g:slime_target = "neovim"
    let g:slime_cell_delimiter = "#%%"
    nmap <leader>sc <Plug>SlimeSendCell
]])
