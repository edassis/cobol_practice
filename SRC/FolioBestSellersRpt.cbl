       IDENTIFICATION DIVISION.
       PROGRAM-ID.  BESTSELLERS.
      *AUTHOR.  MICHAEL COUGHLAN.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BOOKMASTERFILE ASSIGN TO "ASSETS/BOOKMF.DAT"
                     ORGANIZATION IS LINE SEQUENTIAL.

           SELECT BOOKSALESFILE ASSIGN TO "ASSETS/BOOKSALES.DAT"
                      ORGANIZATION IS LINE SEQUENTIAL.

           SELECT WORKFILE ASSIGN TO "ASSETS/TEMP.DAT".

           SELECT REPORTFILE ASSIGN TO "ASSETS/BSLIST.RPT"
                      ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  BOOKMASTERFILE.
       01  BMF-RECORD.
           02 BMF-BOOKNUM        PIC X(5).
           02 BMF-BOOKTITLE      PIC X(25).
           02 BMF-AUTHORNAME     PIC X(25).

       FD  BOOKSALESFILE.
       01  BSF-RECORD.
           88 ENDOFBSF VALUE HIGH-VALUES.
           02 BSF-BOOKNUM        PIC X(5).
           02 BSF-COPIES         PIC 99.
           02 BSF-SALESTATUS     PIC X.
              88    NORMALSALE VALUE "N".

       FD REPORTFILE.
       01  PRINTLINE             PIC X(75).

                
       SD WORKFILE.
       01  WORKREC.
           88 ENDOFWORKFILE VALUE HIGH-VALUES.
           02 W-BOOKNUM          PIC X(5).
           02 W-COPIES           PIC 99.
           02 FILLER             PIC X.


       WORKING-STORAGE SECTION.
       01  HEADING1.
           02 FILLER             PIC X(20) VALUE SPACES.
           02 FILLER             PIC X(31)
              VALUE "FOLIO SOCIETY BEST SELLERS LIST".

       01  HEADING2.
           02 FILLER             PIC X(19) VALUE SPACES.
           02 FILLER             PIC X(33) VALUE ALL "-".

       01  HEADING3.
           02 FILLER             PIC X(7) VALUE " RANK".
           02 FILLER             PIC X(17) VALUE "BOOK NO.".
           02 FILLER             PIC X(26) VALUE "BOOK TITLE".
           02 FILLER             PIC X(20) VALUE "AUTHOR NAME".
           02 FILLER             PIC X(5)  VALUE "SALES".

       01  FOOTING-LINE.
           02 FILLER             PIC X(25) VALUE SPACES.
           02 FILLER             PIC X(21) VALUE "** END OF REPORT **".

       01  BOOK-RANK-LINE.
           02 PRNRANK            PIC ZZ9.
           02 FILLER             PIC X VALUE ".".
           02 FILLER             PIC X(4) VALUE SPACES. 
           02 PRNBOOKNUM         PIC 9(5).
           02 PRNBOOKTITLE       PIC BBBX(25).
           02 PRNAUTHORNAME      PIC BBX(25).
           02 PRNSALES           PIC BBZ,ZZ9.

       01  BOOK-RANK-TABLE.
           02 BOOKDETAILS OCCURS 11 TIMES.
              03 BOOKNUM         PIC 9(5).
              03 BOOKTITLE       PIC X(25).
              03 AUTHORNAME      PIC X(25).
              03 BOOKSALES       PIC 9(4) VALUE ZEROS.

       01  RANK                  PIC 99.
       01  PREVBOOKNUM           PIC X(5).
       01  BOOKSALESTOTAL        PIC 9(4).


       PROCEDURE DIVISION.
       BEGIN.
           SORT WORKFILE ON ASCENDING KEY W-BOOKNUM
               INPUT PROCEDURE IS SELECT-NORMALSALES
               OUTPUT PROCEDURE IS PRINTBESTSELLERSLIST.
           STOP RUN.

       SELECT-NORMALSALES.    
           OPEN INPUT BOOKSALESFILE.
           READ BOOKSALESFILE
               AT END SET ENDOFBSF TO TRUE
           END-READ
           PERFORM UNTIL ENDOFBSF
              IF NORMALSALE 
               RELEASE WORKREC FROM BSF-RECORD
              END-IF     
              READ BOOKSALESFILE
               AT END SET ENDOFBSF TO TRUE
              END-READ
           END-PERFORM
           CLOSE BOOKSALESFILE.
        

       PRINTBESTSELLERSLIST.
           OPEN INPUT BOOKMASTERFILE
           OPEN OUTPUT REPORTFILE

           WRITE PRINTLINE FROM HEADING1 AFTER ADVANCING PAGE.
           WRITE PRINTLINE FROM HEADING2 AFTER ADVANCING 1 LINE.
           WRITE PRINTLINE FROM HEADING3 AFTER ADVANCING 3 LINES.

           RETURN WORKFILE
               AT END SET ENDOFWORKFILE TO TRUE
           END-RETURN

           PERFORM GETBOOKRANKINGS UNTIL ENDOFWORKFILE

           PERFORM PRINTBOOKRANKINGS
               VARYING RANK FROM 1 BY 1 UNTIL RANK > 10

           WRITE PRINTLINE FROM FOOTING-LINE AFTER ADVANCING 3 LINES.

           CLOSE REPORTFILE, 
                 BOOKMASTERFILE.

    
       PRINTBOOKRANKINGS.
           MOVE RANK TO PRNRANK
           MOVE BOOKNUM(RANK) TO PRNBOOKNUM
           MOVE BOOKTITLE(RANK) TO PRNBOOKTITLE
           MOVE AUTHORNAME(RANK) TO PRNAUTHORNAME
           MOVE BOOKSALES(RANK) TO PRNSALES
           WRITE PRINTLINE FROM BOOK-RANK-LINE 
               AFTER ADVANCING 2 LINES. 

       GETBOOKRANKINGS.
           MOVE W-BOOKNUM TO PREVBOOKNUM
           MOVE ZEROS TO BOOKSALESTOTAL
           PERFORM UNTIL W-BOOKNUM NOT EQUAL TO PREVBOOKNUM
                   OR ENDOFWORKFILE
              ADD W-COPIES TO BOOKSALESTOTAL
              RETURN WORKFILE
               AT END SET ENDOFWORKFILE TO TRUE
               END-RETURN
            END-PERFORM

           PERFORM WITH TEST AFTER UNTIL BMF-BOOKNUM = PREVBOOKNUM
              READ BOOKMASTERFILE
               AT END DISPLAY "IN C-B-R END-OF-BMF ENCOUNTERED"
              END-READ
           END-PERFORM

           PERFORM CHECKBOOKRANK
                VARYING RANK FROM 10 BY -1 UNTIL RANK < 1.
 

       CHECKBOOKRANK.
           IF BOOKSALESTOTAL >= BOOKSALES(RANK) 
               MOVE BOOKDETAILS(RANK) TO BOOKDETAILS(RANK + 1)
               MOVE BMF-BOOKNUM TO BOOKNUM(RANK)
               MOVE BMF-BOOKTITLE TO BOOKTITLE(RANK)
               MOVE BMF-AUTHORNAME TO AUTHORNAME(RANK)
               MOVE BOOKSALESTOTAL TO BOOKSALES(RANK)
           END-IF.
                      