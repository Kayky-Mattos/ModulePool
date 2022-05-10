*&---------------------------------------------------------------------*
*& Include          SAPMZTA_03_ALTER_PEDI01
*&---------------------------------------------------------------------*

MODULE user_command_9001.
  CASE gv_okcode.
    WHEN 'INSERTPROD'.
      CALL SCREEN 9001.

    WHEN 'INSERTCLI'.
      CALL SCREEN 9003.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE TO SCREEN 0.

    WHEN 'INCLUIR'.
      CLEAR wa_produto.
      gv_bt_search     = 'X'.
      gv_bt_alter      = 'X'.
      gv_block_codpro  = 'X'.
      gv_block_nomepro = ''.
      gv_block_valpro  = ''.
      gv_bt_insert     = ''.


    WHEN 'INSPROD' OR 'SAVE'.


      IF wa_produto-nome_produto IS NOT INITIAL AND wa_produto-preco_produto IS NOT INITIAL.
      ELSE.
        MESSAGE 'Preencha todos os campos !' TYPE 'I'.
        sy-subrc = 4.
      ENDIF.

      IF sy-subrc EQ 0.
        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            nr_range_nr = '1'
            object      = 'ZPDV03'
          IMPORTING
            number      = wa_produto-id_produto.

        MODIFY zta03_produto FROM wa_produto.
        IF sy-subrc EQ 0.
          MESSAGE ' Produto inserido com sucesso ! ' TYPE 'I'.
          CLEAR wa_produto.
          gv_block_codpro  = 'X'.
          gv_block_nomepro = 'X'.
          gv_block_valpro  = 'X'.
          gv_bt_search     = 'X'.
        ENDIF.
      ENDIF.

    WHEN 'ALTPROD'.

        MODIFY zta03_produto FROM wa_produto.
        IF sy-subrc EQ 0.
          MESSAGE ' Produto Alterado com sucesso ! ' TYPE 'I'.
          CLEAR wa_produto.
          gv_block_codpro  = ''.
          gv_block_nomepro = 'X'.
          gv_block_valpro  = 'X'.
          gv_bt_search     = ''.
          gv_bt_alter      = 'X'.
        ENDIF.

    WHEN 'ALTERAR'.

      gv_block_nomepro = 'X'.
      gv_block_valpro  = 'X'.
      gv_bt_insert     = 'X'.
      gv_bt_alter      = 'X'.
      gv_bt_search     = ''.
      gv_block_codpro  = ''.


      CLEAR wa_produto.


    WHEN 'SEARCH'.
      gv_bt_alter     = 'X'.
      IF wa_produto-id_produto IS NOT INITIAL.
*        BREAK-POINT.
        SELECT SINGLE *
          FROM zta03_produto
          INTO wa_produto
          WHERE id_produto = wa_produto-id_produto.

      IF sy-subrc eq 0.
        gv_bt_alter     = ''.
      ENDIF.

      ELSE.
        MESSAGE 'Insira o id que desejar editar !' TYPE 'I'.
        sy-subrc = 4.
        CLEAR wa_produto.
      ENDIF.

      IF sy-subrc EQ 0.
        gv_block_codpro  = ''.
        gv_block_nomepro = ''.
        gv_block_valpro  = ''.
        gv_bt_search     = ''.

      ELSE.
        MESSAGE 'Id inserido não existe !' TYPE 'I'.
        CLEAR wa_produto.
        gv_block_codpro  = ''.
        gv_block_nomepro = 'X'.
        gv_block_valpro  = 'X'.
        gv_bt_search     = ''.
      ENDIF.

    WHEN 'DELETAR'.
      IF wa_produto-id_produto IS NOT INITIAL.

        PERFORM confirmacao_delete.

        IF ans = 1.
          DELETE FROM zta03_produto
            WHERE id_produto = wa_produto-id_produto.
          MESSAGE 'Produto deletado com sucesso !' TYPE 'I'.
          CLEAR wa_produto.
          gv_block_codpro  = ''.
          gv_block_nomepro = 'X'.
          gv_block_valpro  = 'X'.
          gv_bt_search     = ''.
        ELSE.
          EXIT.
        ENDIF.

      ELSE.
        MESSAGE 'Insira o id que deseja deletar !' TYPE 'I'.
        sy-subrc = 4.
      ENDIF.

    WHEN 'TABELAPROD'.
      PERFORM exibe_alv.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.

MODULE valida_nome INPUT.

  IF wa_produto-nome_produto IS INITIAL.
    MESSAGE 'Insira o nome do produto!' TYPE 'E'.
  ENDIF.
ENDMODULE.

MODULE valida_preco INPUT.
*    BREAK-POINT.
  IF wa_produto-preco_produto > 100.
    MESSAGE 'Valor incompativel irmao, sem condição ' TYPE 'E'.
  ENDIF.
ENDMODULE.

MODULE USER_COMMAND_9002.
    CASE gv_okcode.

      WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
       LEAVE TO SCREEN 0.

      WHEN 'INCLUIR'.
        CLEAR wa_cliente.

         gv_block_codcli  = 'X'.
         gv_block_nomecli = ''.
         gv_block_cpfcli  = ''.

         gv_bt_search     = 'X'. " bt serach ficará invisivel "
         gv_bt_altercli   = ''.  " Esse ficará invisivel "
         gv_bt_insertcli  = 'X'.

      WHEN 'INSCLI' OR 'SAVE'.


      IF wa_cliente-nome_cliente IS NOT INITIAL AND wa_cliente-cpf_cliente IS NOT INITIAL.
      ELSE.
        MESSAGE 'Preencha todos os campos !' TYPE 'I'.
        sy-subrc = 4.
      ENDIF.

      IF sy-subrc EQ 0.
        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            nr_range_nr = '1'
            object      = 'ZPDV03_CLI'
          IMPORTING
            number      = wa_cliente-id_cliente.

        MODIFY zta03_cliente FROM wa_cliente.
        IF sy-subrc EQ 0.
          MESSAGE ' Cliente inserido com sucesso ! ' TYPE 'I'.
            CLEAR wa_produto.
                gv_block_codcli  = 'X'.
                gv_block_nomecli = 'X'.
                gv_block_cpfcli  = 'X'.
          ENDIF.
      ENDIF.
*
*    WHEN 'ALTPROD'.
*
*      MODIFY zta03_produto FROM wa_produto.
*        IF sy-subrc EQ 0.
*          MESSAGE ' Produto Alterado com sucesso ! ' TYPE 'I'.
*          CLEAR wa_produto.
*          gv_block_codpro  = ''.
*          gv_block_nomepro = 'X'.
*          gv_block_valpro  = 'X'.
*          gv_bt_search     = ''.
*          gv_bt_alter      = 'X'.
*        ENDIF.
*
*    WHEN 'ALTERAR'.
*
*      gv_block_nomepro = 'X'.
*      gv_block_valpro  = 'X'.
*      gv_bt_insert     = 'X'.
*      gv_bt_alter      = 'X'.
*      gv_bt_search     = ''.
*      gv_block_codpro  = ''.
*
*
*      CLEAR wa_produto.
*
*
*    WHEN 'SEARCH'.
*      gv_bt_alter     = 'X'.
*      IF wa_produto-id_produto IS NOT INITIAL.
**        BREAK-POINT.
*        SELECT SINGLE *
*          FROM zta03_produto
*          INTO wa_produto
*          WHERE id_produto = wa_produto-id_produto.
*
*      IF sy-subrc eq 0.
*        gv_bt_alter     = ''.
*      ENDIF.
*
*      ELSE.
*        MESSAGE 'Insira o id que desejar editar !' TYPE 'I'.
*        sy-subrc = 4.
*        CLEAR wa_produto.
*      ENDIF.
*
*      IF sy-subrc EQ 0.
*        gv_block_codpro  = ''.
*        gv_block_nomepro = ''.
*        gv_block_valpro  = ''.
*        gv_bt_search     = ''.
*
*      ELSE.
*        MESSAGE 'Id inserido não existe !' TYPE 'I'.
*        CLEAR wa_produto.
*        gv_block_codpro  = ''.
*        gv_block_nomepro = 'X'.
*        gv_block_valpro  = 'X'.
*        gv_bt_search     = ''.
*      ENDIF.
*
*    WHEN 'DELETAR'.
*      IF wa_produto-id_produto IS NOT INITIAL.
*
*        PERFORM confirmacao_delete.
*
*        IF ans = 1.
*          DELETE FROM zta03_produto
*            WHERE id_produto = wa_produto-id_produto.
*          MESSAGE 'Produto deletado com sucesso !' TYPE 'I'.
*          CLEAR wa_produto.
*          gv_block_codpro  = ''.
*          gv_block_nomepro = 'X'.
*          gv_block_valpro  = 'X'.
*          gv_bt_search     = ''.
*        ELSE.
*          EXIT.
*        ENDIF.
*
*      ELSE.
*        MESSAGE 'Insira o id que deseja deletar !' TYPE 'I'.
*        sy-subrc = 4.
*      ENDIF.
*
*    WHEN 'TABELAPROD'.
*      PERFORM exibe_alv.
*
*    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
*      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.