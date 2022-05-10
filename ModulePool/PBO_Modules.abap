*&---------------------------------------------------------------------*
*& Include          SAPMZTA_03_ALTER_PEDO01
*&---------------------------------------------------------------------*
MODULE status_9001 OUTPUT.
  SET PF-STATUS 'STATUS_9001'.
ENDMODULE.

MODULE fieldscontrol OUTPUT.

  PERFORM input_de_campos.
  PERFORM validacao_de_botoes.

ENDMODULE.