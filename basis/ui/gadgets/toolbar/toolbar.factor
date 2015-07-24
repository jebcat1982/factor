! Copyright (C) 2005, 2009 Slava Pestov, 2015 Nicolas Pénet.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors assocs classes fry kernel locals ui.commands
ui.gadgets ui.gadgets.borders ui.gadgets.buttons
ui.gadgets.buttons.private ui.gadgets.colors ui.gadgets.packs
ui.gadgets.tracks ui.pens ui.pens.solid ;
IN: ui.gadgets.toolbar

<PRIVATE

: <toolbar-button-pen> ( -- pen )
    toolbar-background <solid> dup
    line-color <solid> dup dup
    <button-pen> ;
    
: toolbar-button-theme ( gadget -- gadget )
    dup gadget-child border-button-label-theme
    horizontal >>orientation
    <toolbar-button-pen> >>interior
    dup dup interior>> pen-pref-dim >>min-dim
    { 10 6 } >>size ; inline
    
PRIVATE>

:: <toolbar-button> ( target gesture command -- button )
    command command-name
    target command command-button-quot
    '[ drop @ ] <button> toolbar-button-theme
    gesture gesture>tooltip >>tooltip ; inline

: <toolbar> ( target -- toolbar )
    <shelf>
        1 >>fill
        { 5 5 } >>gap
        swap
        [ [ "toolbar" ] dip class-of get-command-at commands>> ]
        [ '[ [ _ ] 2dip <toolbar-button> add-gadget ] ]
        bi assoc-each ;
        
: format-toolbar ( toolbar -- toolbar )
    { 0 0 } <border> 
    toolbar-background <solid> >>interior
    { 1 0 } >>fill ;

: add-toolbar ( track -- track )
    dup <toolbar> format-toolbar f track-add ;
