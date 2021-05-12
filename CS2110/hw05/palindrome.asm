;;=============================================================
;; CS 2110 - Fall 2020
;; Homework 5 - Palindrome
;;=============================================================
;; Name: Sai Nikhil Vangala
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; string = "racecar";
;; len = 0;
;;
;; // to find the length of the string
;; while (string[len] != '\0') {
;;   len = len + 1;
;; }
;;
;; // to check whether the string is a palindrome
;; result = 1;
;; i = 0;
;; while (i < length) {
;;   if (string[i] != string[length - i - 1]) {
;;     result = 0;
;;     break;
;;   }
;;   i = i + 1;
;; }

.orig x3000

            AND R0, R0, 0      ;; Clear R0
            AND R1, R1, 0      ;; Clear R1 
            AND R7, R7, 0      ;; Clear R7 
            ADD R7, R7, 1      ;; Set result --> 1
            AND R3, R3, 0      ;; Clear R3 

WHILE1      LD R0, STRING       ;; Set R0 --> string
            ADD R0, R0, R1      ;; string index --> len
            LDR R2, R0, 0       ;; string[i] --> R2
            BRz ENDWHILE1

            ADD R1, R1, 1       ;; increase by 1
            BR WHILE1

ENDWHILE1   WHILE2

WHILE2      LD R0, STRING       ;; Set R0 --> string
            NOT R2, R1           
            ADD R2, R2, 1      
            AND R4, R4, 0       ;; Clear R4
            ADD R4, R3, R2      ;; i minus len
            BRzp ENDWHILE2

            NOT R2, R3           
            AND R4, R4, 0       ;; Clear R4
            ADD R4, R1, R2      ;; len minus i minus i
            ADD R0, R0, R4      ;; Change string index --> length minus i minus 1
            LDR R5, R0, 0       ;; Load string[length minus i minus 1] --> R5
            LD R0, STRING       ;; R0 --> string
            ADD R0, R0, R3      ;; string index --> i
            LDR R6, R0, 0       ;; string[i] --> R6
            NOT R5, R5           
            ADD R5, R5, 1      
            ADD R2, R6, R5      ;; string[i] minus string[length minus i minus 1]
            BRz BOOST

            ADD R7, R7, -1      ;; result --> 0
            BR ENDWHILE2

BOOST       ADD R3, R3, 1       ;; increase by 1
            BR WHILE2

ENDWHILE2   ST R7, ANSWER
            
HALT

ANSWER .blkw 1
STRING .fill x4000
.end

.orig x4000
.stringz "racecar"
.end
