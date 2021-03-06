CLASS y_check_method_output_param DEFINITION
  PUBLIC
  INHERITING FROM y_check_base
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .
  PROTECTED SECTION.
    METHODS inspect_tokens REDEFINITION.
    METHODS execute_check REDEFINITION.

  PRIVATE SECTION.
    DATA has_found_methods TYPE abap_bool.
    DATA has_exporting_parameter TYPE abap_bool.
    DATA has_changing_parameter TYPE abap_bool.
    DATA has_returning_parameter TYPE abap_bool.
    DATA has_pseudo_comment TYPE abap_bool.

    METHODS check_token_content
      IMPORTING token TYPE stokesx.

    METHODS has_error RETURNING VALUE(result) TYPE abap_bool.
ENDCLASS.



CLASS Y_CHECK_METHOD_OUTPUT_PARAM IMPLEMENTATION.


  METHOD has_error.
    DATA(sum) = 0.
    IF has_exporting_parameter = abap_true.
      ADD 1 TO sum.
    ENDIF.
    IF has_changing_parameter = abap_true.
      ADD 1 TO sum.
    ENDIF.
    IF has_returning_parameter = abap_true.
      ADD 1 TO sum.
    ENDIF.
    IF sum > 1.
      result = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD check_token_content.
    IF token-str EQ 'EXPORTING'.
      has_exporting_parameter = abap_true.
    ENDIF.
    IF token-str EQ 'CHANGING'.
      has_changing_parameter = abap_true.
    ENDIF.
    IF token-str EQ 'RETURNING'.
      has_returning_parameter = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    settings-pseudo_comment = '"#EC PARAMETER_OUT' ##NO_TEXT.
    settings-disable_threshold_selection = abap_true.
    settings-threshold = 1.
    settings-documentation = |{ c_docs_path-checks }method-output-parameter.md|.

    set_check_message( 'Combination of parameters(RETURNING/EXPORTING) should not be used!' ).
  ENDMETHOD.


  METHOD execute_check.
    LOOP AT ref_scan_manager->get_structures( ) ASSIGNING FIELD-SYMBOL(<structure>)
      WHERE stmnt_type EQ scan_struc_stmnt_type-class_definition OR
            stmnt_type EQ scan_struc_stmnt_type-interface.

      is_testcode = test_code_detector->is_testcode( <structure> ).

      TRY.
          DATA(check_configuration) = check_configurations[ apply_on_testcode = abap_true ].
        CATCH cx_sy_itab_line_not_found.
          IF is_testcode EQ abap_true.
            CONTINUE.
          ENDIF.
      ENDTRY.

      DATA(index) = <structure>-stmnt_from.

      LOOP AT ref_scan_manager->get_statements( ) ASSIGNING FIELD-SYMBOL(<statement>)
        FROM <structure>-stmnt_from TO <structure>-stmnt_to.
        inspect_tokens( index = index
                        statement = <statement> ).
        index = index + 1.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.


  METHOD inspect_tokens.
    CHECK get_token_abs( statement-from ) = 'METHODS' OR
          get_token_abs( statement-from ) = 'CLASS-METHODS'.

    has_exporting_parameter = abap_false.
    has_changing_parameter = abap_false.
    has_returning_parameter = abap_false.

    LOOP AT ref_scan_manager->get_tokens( ) ASSIGNING FIELD-SYMBOL(<token>)
      FROM statement-from TO statement-to.

      CASE <token>-str.
        WHEN 'EXPORTING'.
          has_exporting_parameter = abap_true.
        WHEN 'RETURNING'.
          has_returning_parameter = abap_true.
        WHEN 'CHANGING'.
          has_changing_parameter = abap_true.
      ENDCASE.

    ENDLOOP.

    IF has_error( ) = abap_false.
      RETURN.
    ENDIF.

    DATA(check_configuration) = detect_check_configuration( statement ).

    IF check_configuration IS INITIAL.
      RETURN.
    ENDIF.

    raise_error( statement_level     = statement-level
                 statement_index     = index
                 statement_from      = statement-from
                 error_priority      = check_configuration-prio ).

  ENDMETHOD.
ENDCLASS.
