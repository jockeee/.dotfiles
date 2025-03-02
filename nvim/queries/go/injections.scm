; SQL highlighting when we have
; stmt = `
;   ... SQL ...`
left: (expression_list
  (identifier) @var_name (#eq? @var_name "stmt"))
right: (expression_list
  (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql")))

; SQL highlighting when we have
; query = `
;   ... SQL ...`
left: (expression_list
  (identifier) @var_name (#eq? @var_name "query"))
right: (expression_list
  (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql")))


; SQL highlighting when we have
; stmt := fmt.Sprintf(`
;     ... SQL ...`, filters.sortColumn(), filters.sortDirection())
; manually change any %s to valid SQL before formatting, then change back to %s
left: (expression_list
  (identifier) @var_name (#eq? @var_name "stmt"))
right: (expression_list
  (call_expression
    ; function: (selector_expression
    ;   operand: (identifier)
    ;   field: (field_identifier))
    arguments: (argument_list
      (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql")))))

; SQL highlighting when we have
; query := fmt.Sprintf(`
;     ... SQL ...`, filters.sortColumn(), filters.sortDirection())
; manually change any %s to valid SQL before formatting, then change back to %s
left: (expression_list
  (identifier) @var_name (#eq? @var_name "query"))
right: (expression_list
  (call_expression
    ; function: (selector_expression
    ;   operand: (identifier)
    ;   field: (field_identifier))
    arguments: (argument_list
      (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql")))))

