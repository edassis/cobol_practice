      ******************************************************************
      * AUTHOR: EDUARDO F. ASSIS EDINHO
      * DATE: 22/06/2022
      ******************************************************************
           IDENTIFICATION DIVISION.
           PROGRAM-ID. ARITMETICA.
           ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           SPECIAL-NAMES.
               DECIMAL-POINT IS COMMA.
           DATA DIVISION.
           WORKING-STORAGE SECTION.
           77  NUM1 PIC S9(09) VALUE ZEROS.
           77  NUM2 PIC S9(09) VALUE ZEROS.
           77  RES  PIC S9(20) VALUE ZEROS.
           77  RESTO  PIC 9(09) VALUE ZEROS.
           PROCEDURE DIVISION.
               ACCEPT NUM1 FROM CONSOLE.
               ACCEPT NUM2 FROM CONSOLE.
               DISPLAY '===================='.
               DISPLAY 'NUMERO_1 'NUM1.
               DISPLAY 'NUMERO_2 'NUM2.
      ************* SOMA
               ADD NUM1 NUM2 TO RES.
               DISPLAY 'SOMA 'RES.
      ************* SUBTRACAO
               SUBTRACT NUM2 FROM NUM1 GIVING RES.
               DISPLAY 'SUBTRACAO 'RES.
      ************* DIVISAO
               DIVIDE NUM1 BY NUM2 GIVING RES REMAINDER RESTO.
               DISPLAY 'DIVISAO 'RES' COM RESTO 'RESTO.
      ************* MULTIPLE
               MULTIPLY NUM1 BY NUM2 GIVING RES.
               DISPLAY 'MULTIPLICACAO 'RES.
      ************* COMPUTE
               COMPUTE RES = (NUM1 + NUM2)/2.
               DISPLAY 'MEDIA 'RES.
      ************* USO DE SINAIS
               STOP RUN.
           END PROGRAM ARITMETICA.
