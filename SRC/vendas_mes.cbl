      ******************************************************************
      * AUTHOR: EDUARDO F. ASSIS EDINHO
      * DATE: 23/06/2022
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VENDAS_MES.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-MESES-TABLE.
           02 FILLER         PIC A(3) VALUES 'JAN'. 
           02 FILLER         PIC A(3) VALUES 'FEV'. 
           02 FILLER         PIC A(3) VALUES 'MAR'. 
           02 FILLER         PIC A(3) VALUES 'ABR'. 
           02 FILLER         PIC A(3) VALUES 'MAI'. 
           02 FILLER         PIC A(3) VALUES 'JUN'. 
           02 FILLER         PIC A(3) VALUES 'JUL'. 
           02 FILLER         PIC A(3) VALUES 'AGO'. 
           02 FILLER         PIC A(3) VALUES 'SET'. 
           02 FILLER         PIC A(3) VALUES 'OUT'. 
           02 FILLER         PIC A(3) VALUES 'NOV'. 
           02 FILLER         PIC A(3) VALUES 'DEZ'.
       01  WS-MESES          REDEFINES WS-MESES-TABLE.
           02 WS-MES         PIC A(3) OCCURS 12 TIMES.     

       77  I                 PIC 9(6) VALUES ZEROES.

       77  WS-VENDA          PIC 9(7)V99 VALUES ZEROES.
       77  WS-MES-N          PIC 9(2) VALUES ZEROES.

       01  WS-VENDAS.
           05 WS-VENDA-MES   PIC 9(12)V99 OCCURS 12 TIMES.
       01  VALOR-OUT-FMT     PIC $Z(11)9,99 VALUES ZEROES.
       PROCEDURE DIVISION.
           PERFORM WITH TEST AFTER UNTIL WS-MES-N=99
               PERFORM 0100-INIT
               PERFORM 0200-PROCESS
           END-PERFORM.
           PERFORM 0300-FINALIZE.
           STOP RUN.

       0100-INIT.
           DISPLAY 'INFORME O VALOR DA VENDA'.
           ACCEPT WS-VENDA.
           DISPLAY 'INFORME O MES DA VENDA'.
           ACCEPT WS-MES-N.

       0200-PROCESS.
           COMPUTE WS-VENDA-MES(WS-MES-N) = WS-VENDA-MES(WS-MES-N) 
               + WS-VENDA.

       0300-FINALIZE.
           DISPLAY 'TOTAL DE VENDAS:'.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 12
               MOVE WS-VENDA-MES(I) TO VALOR-OUT-FMT
               DISPLAY WS-MES(I)': 'VALOR-OUT-FMT
           END-PERFORM.

       END PROGRAM VENDAS_MES.
