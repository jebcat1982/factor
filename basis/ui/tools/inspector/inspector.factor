! Copyright (C) 2006, 2009 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors inspector namespaces kernel
ui.tools.browser ui.commands
ui.gadgets ui.gadgets.panes ui.gadgets.scrollers
ui.gadgets.slots ui.gadgets.tracks ui.gestures
ui.gadgets.buttons ui.tools.workspace ;
IN: ui.tools.inspector

TUPLE: inspector-gadget < track object pane ;

: refresh ( inspector -- )
    [ object>> ] [ pane>> ] bi [
        +editable+ on
        +number-rows+ on
        describe
    ] with-pane ;

: <inspector-gadget> ( -- gadget )
    { 0 1 } inspector-gadget new-track
        add-toolbar
        <pane> >>pane
        dup pane>> <scroller> 1 track-add ;

: inspect-object ( obj mirror keys inspector -- )
    2nip swap >>object refresh ;

\ &push H{ { +nullary+ t } { +listener+ t } } define-command

\ &back H{ { +nullary+ t } { +listener+ t } } define-command

\ &globals H{ { +nullary+ t } { +listener+ t } } define-command

: inspector-help ( -- ) "ui-inspector" com-follow ;

\ inspector-help H{ { +nullary+ t } } define-command

inspector-gadget "toolbar" f {
    { T{ update-object } refresh }
    { f &push }
    { f &back }
    { f &globals }
    { T{ key-down f f "F1" } inspector-help }
} define-command-map

inspector-gadget "multi-touch" f {
    { T{ left-action } &back }
} define-command-map

M: inspector-gadget tool-scroller
    pane>> find-scroller ;
