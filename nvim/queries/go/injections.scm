; SQL highlighting for:
;   stmt = `
;     ... SQL ...`
left: (expression_list
  (identifier) @var_name (#eq? @var_name "stmt"))
right: (expression_list
  (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql")))

; SQL highlighting for:
;   query = `
;     ... SQL ...`
left: (expression_list
  (identifier) @var_name (#eq? @var_name "query"))
right: (expression_list
  (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "sql")))


; SQL highlighting for:
;   stmt := fmt.Sprintf(`
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

; SQL highlighting for:
;   query := fmt.Sprintf(`
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

; HTML highlighting for:
;   html = `
;     ... HTML ...`
; manually change any %s to valid SQL before formatting, then change back to %s
name: (identifier) @var_name (#eq? @var_name "html")
value: (expression_list
  (raw_string_literal
    (raw_string_literal_content) @injection.content (#set! injection.language "html")))

