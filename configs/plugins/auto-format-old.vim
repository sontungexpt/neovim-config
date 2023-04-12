"  "   Plug 'vim-autoformat/vim-autoformat'

"  "  "-----------Vim Autoformat------------"

"  "  au BufWrite * :Autoformat
"  "  let g:autoformat_autoindent = 1
"  "  let g:autoformat_retab = 1
"  "  let g:autoformat_remove_trailing_spaces = 1
"  "  let g:formatters_cpp = ['clangformat', 'astyle_cpp']
"  "  let g:autoformat_disable_for_filetypes = ['javascript', 'typescript', 'vue', 'html', 'svg', 'json', 'markdown', 'php', 'xml', 'rc']
"  "  let g:formatters_objc = ['clangformat']
"  "  let g:formatters_c = ['clangformat', 'astyle_c']
"  "  let g:formatters_python = ['autopep8','yapf', 'black']
"  "  let g:formatters_proto = ['clangformat']
"  "  let g:formatters_javascript = []
"  "  let g:formatters_vue = []
"  "  let g:formatters_html = []
"  "  let g:formatters_svg = ['tidy_xml']
"  "  let g:formatters_ruby = ['rbeautify', 'rubocop']
"  "  let g:formatters_java = ['astyle_java']
"  "  let g:formatters_cs = ['astyle_cs']
"  "  let g:formatters_bzl = ['buildifier']
"  "  let g:formatters_ada = ['gnatpp']
"  "  let g:formatters_go = ['gofmt']
"  "  let g:formatters_json = ['jsonlint']
"  "  let g:formatters_markdown = ['prettier']
"  "  let g:formatters_php = ['php-cs-fixer']
"  "  let g:formatters_rust = ['rustfmt']
"  "  let g:formatters_sql = ['sqlformat']
"  "  let g:formatters_xml = ['tidy_xml']
"  "  let g:formatters_rc = ['rcfmt']

"  Plug 'sbdchd/neoformat'
"  let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']
"  let g:neoformat_enabled_javascript = ['prettier']
"  let g:neoformat_enabled_typescript = ['prettier']
"  let g:neoformat_enabled_json = ['prettier']
"  let g:neoformat_enabled_html = ['prettier']
"  let g:neoformat_enabled_css = ['prettier']
"  let g:neoformat_enabled_scss = ['prettier']
"  let g:neoformat_enabled_vim = ['vim-vint']
"  let g:neoformat_enabled_lua = ['lua-format']
"  let g:neoformat_enabled_ruby = ['rubocop']
"  let g:neoformat_enabled_php = ['php-cs-fixer']
"  let g:neoformat_enabled_cpp = ['clang-format']
"  let g:neoformat_enabled_c = ['clang-format']


"  let g:neoformat_try_formatprg = 1
"  " Enable alignment
"  let g:neoformat_basic_format_align = 1

"  " Enable tab to spaces conversion
"  let g:neoformat_basic_format_retab = 1

"  " Enable trimmming of trailing whitespace
"  let g:neoformat_basic_format_trim = 1
"  let g:neoformat_run_all_formatters = 1
"  let g:neoformat_only_msg_on_error = 1

"  augroup fmt
"    autocmd!
"    autocmd BufWritePre * undojoin | Neoformat
"  augroup END