*&---------------------------------------------------------------------*
*& Include SAPMZTA_03_ALTER_PEDTOP                  - Module Pool      SAPMZTA_03_ALTER_PED
*&---------------------------------------------------------------------*
PROGRAM sapmzta_03_alter_ped.

DATA: wa_produto        TYPE zta03_produto,
      wa_cliente        TYPE zta03_cliente,
      gv_okcode         TYPE sy-ucomm,
      ANS               TYPE c,
      gv_block_codpro   TYPE c VALUE 'X',
      gv_block_nomepro  TYPE c VALUE 'X',
      gv_block_valpro   TYPE c VALUE 'X',

      gv_block_codcli   TYPE c VALUE 'X',
      gv_block_nomecli  TYPE c VALUE 'X',
      gv_block_cpfcli   TYPE c VALUE 'X',

      gv_bt_search      TYPE c VALUE 'X',
      gv_bt_insert      TYPE c VALUE 'X',
      gv_bt_alter       TYPE c VALUE 'X',

      gv_bt_searchcli   TYPE c VALUE 'X',
      gv_bt_insertcli   TYPE c VALUE 'X',
      gv_bt_altercli    TYPE c VALUE 'X'.