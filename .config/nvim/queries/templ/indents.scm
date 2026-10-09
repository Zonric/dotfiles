; inherits: go

(component_declaration) @indent.begin

((element
  (tag_start
    (element_identifier) @_not_void_element))
  (#not-any-of? @_not_void_element
    "area" "base" "basefont" "bgsound" "br" "col" "command" "embed" "frame" "hr" "image" "img"
    "input" "isindex" "keygen" "link" "menuitem" "meta" "nextid" "param" "source" "track" "wbr")) @indent.begin

(element
  (tag_end
    ">" @indent.end))

(element
  (tag_end) @indent.branch)

(element
  (self_closing_tag
    "/>" @indent.end))

[
  ">"
  "/>"
] @indent.branch

(component_switch_statement) @indent.begin
(component_switch_expression_case) @indent.begin
(component_switch_default_case) @indent.begin
(component_if_statement) @indent.begin
(component_for_statement) @indent.begin
(style_element) @indent.begin
(script_element) @indent.begin

[
  "}"
  ")"
] @indent.end

(component_block
  "}" @indent.branch)
