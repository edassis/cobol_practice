      ******************************************************************
      * AUTHOR: EDUARDO F. ASSIS EDINHO
      * DATE: 23/06/2022
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  WS-OPCAO PIC X(1).
       SCREEN SECTION.
       01 TELA.
           05 LIMPA-TELA.
               10 BLANK SCREEN.
               10 LINE 01 COLUMN 01 ERASE EOL
                   BACKGROUND-COLOR 1.
       PROCEDURE DIVISION.
           DISPLAY TELA.
           ACCEPT WS-OPCAO.
           STOP RUN.
           
       END PROGRAM MAIN.
