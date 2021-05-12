;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Studly Caps!
;;=============================================================
;; Name: Sai Nikhil Vangala
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;; string = "TWENTY 1 ten";
;; i = 0;
;; while (string[i] != 0) {
;;   if (i % 2 == 0) {
;;   // should be lowercase
;;     if ('A' <= string[i] <= 'Z') {
;;       string[i] = string[i] | 32;
;;     }
;;   } else {
;;   // should be uppercase
;;     if ('a' <= string[i] <= 'z') {
;;       string[i] = string[i] & ~32;
;;     }
;;   }
;;   i++;
;; }

.orig x3000

            AND R0, R0, 0      ;; Clear R0 
            AND R1, R1, 0      ;; R1 --> i = 0
            AND R3, R3, 0      

WHILE       LD R0, STRING       ;; R0 --> string
            ADD R0, R0, R1      ;; string index --> i      
            LDR R2, R0, 0       ;; Load string[i] --> R2
            BRz ENDWHILE 

            ADD R3, R3, -1      ;;
            BRz BE

            ADD R3, R3, 2      
            LD R4, UPPERA       ;; 'A' --> R4
            NOT R4, R4          
            ADD R4, R4, 1       ;; icrease by 1
            ADD R5, R2, R4      ;; string[i] - 'A'
            BRn END

            LD R4, UPPERZ       ;; Load 'Z' into R4
            NOT R4, R4          ;; NOT 'Z'
            ADD R4, R4, 1       ;; NOT 'Z' + 1
            ADD R5, R2, R4      ;; string[i] - 'Z'
            BRp END

            LD R4, NUM32        ;; #32 --> R4
            NOT R4, R4          
            AND R5, R2, R4      
            NOT R4, R4          
            ADD R5, R2, R4      
            LD R0, STRING       ;; R0 --> string
            ADD R0, R0, R1      ;; index of string[i]
            STR R5, R0, 0       ;; string[i] equals string[i] | 32
            BR END

BE          LD R4, LOWERA       ;; Load 'a' --> R4
            NOT R4, R4          
            ADD R4, R4, 1       ;; increase by 1
            ADD R5, R2, R4      ;; string[i] minus 'a'
            BRn END

            LD R4, LOWERZ       ;; Load 'z' --> R4
            NOT R4, R4          
            ADD R4, R4, 1       ;; increase by 1
            ADD R5, R2, R4      ;; string[i] minus 'z'
            BRp END

            LD R4, NUM32        ;; #32 --> R4
            NOT R4, R4          
            AND R5, R2, R4      ;; string[i] and ~32
            LD R0, STRING       ;; R0 --> string
            ADD R0, R0, R1      ;; index of string[i]
            STR R5, R0, 0       ;; string[i] equals string[i] and ~32
            BR END

END         ADD R1, R1, 1       ;; increase by 1
            BR WHILE

ENDWHILE    
HALT

UPPERA .fill x41    ;; A in ASCII
UPPERZ .fill x5A	;; Z in ASCII
LOWERA .fill x61	;; a in ASCII
LOWERZ .fill x7A	;; z in ASCII
NUM32  .fill x20    ;; 32 in HEX

STRING .fill x4000
.end

.orig x4000
.stringz "TWENTY ONE TEN"
.end
