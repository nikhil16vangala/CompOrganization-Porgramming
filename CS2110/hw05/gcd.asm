;;=============================================================
;; CS 2110 - Spring 2021
;; Homework 5 - Iterative GCD
;;=============================================================
;; Name: Sai Nikhil Vangala
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; a = (argument 1);
;; b = (argument 2);
;; ANSWER = 0;
;;
;; while (a != b) {
;;   if (a > b) {
;;     a = a - b;
;;   } else {
;;     b = b - a;
;;   }
;; }
;; ANSWER = a;

.orig x3000

AND R0, R0, 0 ;; Clear R0 
AND R1, R1, 0 ;; Clear R1

WHILE       LD R0, A         ;; R0 --> A
            LD R1, B         ;; R1 --> B
            NOT R2, R1
            ADD	R2,	R2,	1    ;; increase by 1
            ADD R3, R0, R2
            BRz ENDWHILE

            BRnz ELSE
            ST R3, A
            BR ENDIF

ELSE        NOT R2, R0        
            ADD R2, R2, 1    ;; increase by 1
            ADD R3, R1, R2
            ST R3, B
        
ENDIF      BR WHILE      

ENDWHILE    LD R2, A
            ST R2, ANSWER

HALT

A .fill 20
B .fill 19

ANSWER .blkw 1

.end
