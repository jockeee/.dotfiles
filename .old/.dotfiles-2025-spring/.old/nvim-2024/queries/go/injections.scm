; SQL highlighting when you have
; stmt = `
;   ... SQL ...`
left: (expression_list
  (identifier) @var_name (#eq? @var_name "stmt")
)
right: (expression_list
  (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql"))
)
