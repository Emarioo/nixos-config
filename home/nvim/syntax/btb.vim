syntax keyword btbKeyword if else while switch case for break namespace continue global fn enum union struct return defer operator asm cast cast_unsafe _test using as 
syntax match btbType "(?<=(:\s*)|(-\>\s*))\w+" 
syntax keyword btbConstant true false null
syntax match btbLiteralNum "(\d+(.\d+)?(usd)?)|(0x[0-9a-fA-F_]+)|(0b[01_]+)|(0o[0-7_]+)"
syntax match btbComment "//.*$"
syntax region btbCommentBig start=+/\*+ end=+\*/+
syntax match btbShebang "#!.*$"
syntax region btbString start=+"+ end=+"+
syntax region btbStringBig start=+@strbeg+ end=+@strend+
syntax match btbPreproc "#\w+"

highlight link btbKeyword Keyword
highlight link btbPreproc Keyword
highlight link btbType Type
highlight link btbConstant Constant
highlight link btbComment Comment
highlight link btbCommentBig Comment
highlight link btbLiteralNum Constant
highlight link btbShebang Comment
highlight link btbString String
highlight link btbStringBig String
