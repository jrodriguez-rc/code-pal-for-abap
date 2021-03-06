CLASS ltc_not_is_initial DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_not_is_initial IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_prefer_is_not( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( '   DATA(count) = 0. ' )
      ( '   IF NOT count IS INITIAL. ' )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( '   DATA(count) = 0. ' )
      ( '   IF count IS NOT INITIAL. ' )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( '   DATA(count) = 0. ' )
      ( '   IF NOT count IS INITIAL. "#EC PREFER_IS_NOT ' )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_not_contains_pattern DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_not_contains_pattern IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_prefer_is_not( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( |   DATA(text) = 'text'. | )
      ( '   DATA(count) = 0. ' )
      ( |   IF NOT text CP 't*'. | )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( |   DATA(text) = 'text'. | )
      ( '   DATA(count) = 0. ' )
      ( |   IF text NP 't*'. | )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.     ' )
      ( |   DATA(text) = 'text'. | )
      ( '   DATA(count) = 0. ' )
      ( |   IF NOT text CP 't*'. "#EC PREFER_IS_NOT | )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_not_value DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_not_value IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_prefer_is_not( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( '   DATA(count) = 0. ' )
      ( |   IF NOT count = 0. | )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( '   DATA(count) = 0. ' )
      ( |   IF count <> 0. | )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.      ' )
      ( '   DATA(count) = 0. ' )
      ( |   IF NOT count = 0. "#EC PREFER_IS_NOT | )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_and DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_and IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_prefer_is_not( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.  ' )
      ( '   DATA(count) = 0.   ' )
      ( '   IF sy-subrc = 0    ' )
      ( '   AND NOT count = 1. ' )
      ( '     count = 1.       ' )
      ( '   ENDIF.             ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.  ' )
      ( '   DATA(count) = 0.   ' )
      ( '   IF sy-subrc = 0    ' )
      ( '   AND count <> 1.    ' )
      ( '     count = 1.       ' )
      ( '   ENDIF.             ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.                      ' )
      ( '   DATA(count) = 0.                       ' )
      ( '   IF sy-subrc = 0                        ' )
      ( '   AND NOT count = 1. "#EC PREFER_IS_NOT  ' )
      ( '     count = 1.                           ' )
      ( '   ENDIF.                                 ' )
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltc_or DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_or IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_prefer_is_not( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.  ' )
      ( '   DATA(count) = 0.   ' )
      ( '   IF sy-subrc = 0    ' )
      ( '   OR NOT count = 1.  ' )
      ( '     count = 1.       ' )
      ( '   ENDIF.             ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.  ' )
      ( '   DATA(count) = 0.   ' )
      ( '   IF sy-subrc = 0    ' )
      ( '   OR count <> 1.     ' )
      ( '     count = 1.       ' )
      ( '   ENDIF.             ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.                     ' )
      ( '   DATA(count) = 0.                      ' )
      ( '   IF sy-subrc = 0                       ' )
      ( '   OR NOT count = 1. "#EC PREFER_IS_NOT  ' )
      ( '     count = 1.                          ' )
      ( '   ENDIF.                                ' )
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltc_elseif DEFINITION INHERITING FROM y_unit_test_base FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_cut REDEFINITION.
    METHODS get_code_with_issue REDEFINITION.
    METHODS get_code_without_issue REDEFINITION.
    METHODS get_code_with_exemption REDEFINITION.
ENDCLASS.

CLASS ltc_elseif IMPLEMENTATION.

  METHOD get_cut.
    result ?= NEW y_check_prefer_is_not( ).
  ENDMETHOD.

  METHOD get_code_with_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION. ' )
      ( '   DATA(count) = 0. ' )
      ( '   IF sy-subrc = 0. ' )
      ( '     count = 1. ' )
      ( '   ELSEIF NOT count = 5. ' )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION.  ' )
      ( '   DATA(count) = 0. ' )
      ( '   IF sy-subrc = 0. ' )
      ( '     count = 1. ' )
      ( '   ELSEIF count <> 5. ' )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

  METHOD get_code_with_exemption.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION. ' )

      ( '   DATA(count) = 0. ' )
      ( '   IF sy-subrc = 0. ' )
      ( '     count = 1. ' )
      ( '   ELSEIF NOT count = 5. "#EC PREFER_IS_NOT ' )
      ( '     count = 1. ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltc_line_exists DEFINITION INHERITING FROM ltc_not_value FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PROTECTED SECTION.
    METHODS get_code_without_issue REDEFINITION.
ENDCLASS.

CLASS ltc_line_exists IMPLEMENTATION.

  METHOD get_code_without_issue.
    result = VALUE #(
      ( 'REPORT y_example. ' )

      ( ' START-OF-SELECTION. ' )
      ( '   DATA itab TYPE TABLE OF tadir. ' )
      ( '   IF NOT line_exists( itab[ 0 ] ). ' )
      ( '   ENDIF. ' )
    ).
  ENDMETHOD.

ENDCLASS.
