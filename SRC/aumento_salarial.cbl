      ******************************************************************
      * AUTHOR: EDUARDO F. ASSIS EDINHO
      * DATE: 22/06/2022
      ******************************************************************
           IDENTIFICATION DIVISION.
           PROGRAM-ID. AUMENTO_SALARIAL.
           ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           SPECIAL-NAMES.
               DECIMAL-POINT IS COMMA.
           DATA DIVISION.
           WORKING-STORAGE SECTION.
           77  WS-STR PIC A(128) VALUE SPACES.
           77  WS-ANO-INGRESSO PIC 9(04) VALUE ZEROS.
           77  WS-SALARIO PIC 9(9)V9(2) VALUE ZEROS.
           77  WS-AUX PIC 9(9)V9(2) VALUE ZEROS.
      *>      77 WS-SALARIO-FMT PIC Z(8)9V9(2) VALUE ZEROS.
           01  WS-DATA.
               05 WS-ANO PIC 9(04).
               05 WS-MES PIC 9(02).
               05 WS-DIA PIC 9(02).
           PROCEDURE DIVISION.
           0001-MAIN.
               PERFORM 0002-INIT.
               PERFORM 0003-PROCESS.
               PERFORM 0004-FINALIZE.
               STOP RUN.

           0002-INIT.
      *>          MOVE FUNCTION CURRENT-DATE(1:8) TO WS-DATA.
      *>          DISPLAY 'FUNCTION CURRENT-DATE - DATA 'WS-DATA.
               ACCEPT WS-DATA FROM DATE YYYYMMDD.
               DISPLAY 'INFORME O NOME'.
               ACCEPT WS-STR.
               DISPLAY 'INFORME O ANO DE INGRESSO'.
               ACCEPT WS-ANO-INGRESSO.
               DISPLAY 'INFORME O SALARIO'.
               ACCEPT WS-SALARIO.

           0003-PROCESS.
      *>          DISPLAY 'SALARIO ANTES 'WS-SALARIO.
               COMPUTE WS-AUX = (WS-ANO-INGRESSO - WS-ANO).
      *>          DISPLAY 'CONTA 'WS-AUX.
               EVALUATE WS-AUX
                   WHEN 2 THRU 5
                       COMPUTE WS-SALARIO = WS-SALARIO * 1,01
                   WHEN 6 THRU 15
                       COMPUTE WS-SALARIO = WS-SALARIO * 1,05
                   WHEN GREATER THAN 15
                       COMPUTE WS-SALARIO = WS-SALARIO * 1,15
               END-EVALUATE.
      *>          MOVE WS-SALARIO TO WS-SALARIO-FMT

           0004-FINALIZE.
               DISPLAY 'SR.'WS-STR','.
               DISPLAY 'SEU NOVO SALARIO EH 'WS-SALARIO.

           END PROGRAM AUMENTO_SALARIAL.
