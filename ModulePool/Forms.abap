*&---------------------------------------------------------------------*
*& Include          SAPMZTA_03_ALTER_PEDF01
*&---------------------------------------------------------------------*

FORM confirmacao_delete.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            TITLEBAR                    = ' !!! WARNING !!!'
            text_question               = ' Tem certeza que deseja deletar o produto ? '
            TEXT_BUTTON_1               = 'SIM'
            TEXT_BUTTON_2               = 'NAO'
            DEFAULT_BUTTON              = '2'
            DISPLAY_CANCEL_BUTTON       = ''
         IMPORTING
           ANSWER                      =  ANS
         EXCEPTIONS
           TEXT_NOT_FOUND = 1
           OTHERS = 2.
ENDFORM.

FORM exibe_ALV.
CONSTANTS c_table TYPE dd02l-tabname VALUE 'ZTA03_PRODUTO_ST'.

      DATA: lt_fieldcat TYPE lvc_t_fcat,
            gt_produto  TYPE TABLE OF ZTA03_PRODUTO_ST,
            wa_layout   TYPE lvc_s_layo,
            wa_fieldcat TYPE LINE OF lvc_t_fcat.

            wa_layout-zebra      = 'X'.

            SELECT
              ID_PRODUTO
              NOME_PRODUTO
              PRECO_PRODUTO
               FROM zta03_produto
            INTO TABLE gt_produto.

            CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
              EXPORTING
                I_STRUCTURE_NAME             = c_table
              CHANGING
                ct_fieldcat                  = lt_fieldcat
                 EXCEPTIONS
                 INCONSISTENT_INTERFACE       = 1
                 PROGRAM_ERROR                = 2
                 OTHERS                       = 3.

            CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
              EXPORTING
                IS_LAYOUT_LVC                     = wa_layout
                IT_FIELDCAT_LVC                   = lt_fieldcat
              TABLES
                t_outtab                          = gt_produto
                EXCEPTIONS
                PROGRAM_ERROR                     = 1
                OTHERS                            = 2.

ENDFORM.

FORM input_de_campos.
*-------- Screen 9001 ---------*
  IF gv_block_codpro IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'IDP'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'IDP'.
        screen-input = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

    IF gv_block_nomepro IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'NPR'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'NPR'.
        screen-input = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

    IF gv_block_valpro IS NOT INITIAL.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'PPR'.
          screen-input = '0'.
        MODIFY SCREEN.
      ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'PPR'.
          screen-input = '1'.
        MODIFY SCREEN.
    ENDLOOP.
  ENDIF.
*-------- Screen 9002 ---------*
    IF gv_block_codcli IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'IDC'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'IDC'.
        screen-input = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

    IF gv_block_nomecli IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'NDC'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'NDC'.
        screen-input = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

    IF gv_block_cpfcli IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'CLI'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'CLI'.
        screen-input = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

ENDFORM.

FORM validacao_de_botoes.
*---------- Screen 9001 -----------*
  IF gv_bt_search IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'BTS'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'BTS'.
        screen-invisible = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  IF gv_bt_insert IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'IPR'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'IPR'.
        screen-invisible = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  IF gv_bt_alter IS NOT INITIAL.
   LOOP AT SCREEN.
      CHECK screen-group1 = 'APR'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'APR'.
        screen-invisible = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.
*---------- Screen 9003 -----------*
  IF gv_bt_searchcli IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'BTC'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'BTC'.
        screen-invisible = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  IF gv_bt_insertcli IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'ACL'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'ACL'.
        screen-invisible = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  IF gv_bt_altercli IS NOT INITIAL.
    LOOP AT SCREEN.
      CHECK screen-group1 = 'ICL'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDLOOP.
  ELSE.
      LOOP AT SCREEN.
        CHECK screen-group1 = 'ICL'.
        screen-invisible = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

ENDFORM.