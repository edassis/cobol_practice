      ******************************************************************
      * AUTHOR: EDUARDO F. ASSIS EDINHO
      * DATE: 23/06/2022
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INVESTIMENTO.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 WS-INVESTIMENTO  PIC 9(8)V99 VALUE ZEROES.
       77 WS-PERIODO       PIC 9(3)    VALUE ZEROES.
       77 WS-CORRECAO      PIC 9(2)V99 VALUE ZEROES.
       PROCEDURE DIVISION.
           PERFORM WITH TEST AFTER UNTIL WS-INVESTIMENTO <= 0
               PERFORM 0200-INIT
               PERFORM 0300-PROCESS
               PERFORM 0400-FINALIZE
           END-PERFORM.
           STOP RUN.

       0200-INIT.
           DISPLAY 'INFORME O VALOR DO INVESTIMENTO'.
           ACCEPT WS-INVESTIMENTO.
           DISPLAY 'INFORME O PERIODO'.
           ACCEPT WS-PERIODO.
           DISPLAY 'INFORME A CORRECAO MENSAL'.
           ACCEPT WS-CORRECAO.

       0300-PROCESS.
           PERFORM WS-PERIODO TIMES
               COMPUTE WS-INVESTIMENTO = WS-INVESTIMENTO * WS-CORRECAO
           END-PERFORM.
       0400-FINALIZE.
           DISPLAY 'O INVESTIMENTO IRAH RENDER ' WS-INVESTIMENTO.

       END PROGRAM INVESTIMENTO.