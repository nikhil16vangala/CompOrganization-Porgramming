;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 5 - Array Merge
;;=============================================================
;; Name: Sai Nikhil Vangala
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; x = 0;
;; y = 0;
;; z = 0;
;; while (x < LENGTH_X && y < LENGTH_Y) {
;;   if (ARR_X[x] <= ARR_Y[y]) {
;;     ARR_RES[z] = ARR_X[x];
;;     z++;
;;     x++;
;;   } else {
;;     ARR_RES[z] = ARR_Y[y];
;;     z++;
;;     y++;
;;   }
;; }
;; while(x < ARRX.length) {
;;   ARR_RES[z] = ARR_X[x];
;;   z++;
;;   x++;
;; }
;; while (y < ARRY.length) {
;;   ARR_RES[z] = ARR_Y[y];
;;   z++;
;;   y++;
;; }



.orig x3000

AND R0, R0, 0   ;; Clear R0 
AND R1, R1, 0   ;; Clear R1 
AND R2, R2, 0   ;; Clear R2 

WHILE1          AND R3, R3, 0       
                LD R3, LENGTH_X     ;; LENGTH_X --> R3
                NOT R4, R3          
                ADD R4, R4, 1       ;; increase by 1
                ADD R5, R4, R0      ;; x minus LENGTH_X
                BRzp WHILE2         

                AND R3, R3, 0       
                LD R3, LENGTH_Y     ;; LENGTH_Y --> R3
                NOT R4, R3          
                ADD R4, R4, 1       ;; increase by 1
                ADD R5, R4, R1      ;; y minus LENGTH_Y
                BRzp WHILE2         

                AND R3, R3, 0
                LD R3, ARR_Y        ;; Lea ARR_Y --> R3
                ADD R3, R3, R1      
                LDR R4, R3, 0       ;; ARR_Y[y] --> R4
                LD R3, ARR_X        ;; Lea ARR_X -->  R3
                ADD R3, R3, R0      
                LDR R5, R3, 0       ;; ARR_X[x] --> R5
                NOT R4, R4          
                ADD R4, R4, 1       ;; increase by 1
                ADD R4, R5, R4      ;; ARR_X[x] minus ARR_Y[y]
                BRp ELSE1
                LD R3, ARR_RES      ;; Lea ARR_RES --> R3
                ADD R3, R3, R2      ;; ARR_RES[z] --> R4
                STR R5, R3, 0       ;; ARR_RES[z] equals ARR_X[x]
                ADD R2, R2, 1       ;; increase by 1
                ADD R0, R0, 1       ;; increase by 1
                BR ENDIF1

ELSE1           LD R3, ARR_Y        ;; Lea ARR_Y --> R3
                ADD R3, R3, R1      
                LDR R4, R3, 0       ;; ARR_Y[y] --> R4
                LD R3, ARR_RES      ;; Lea ARR_RES --> R3
                ADD R3, R3, R2      ;; ARR_RES[z] --> R4
                STR R4, R3, 0       ;; ARR_RES[z] equals ARR_Y[y]
                ADD R2, R2, 1       ;; increase by 1
                ADD R1, R1, 1       ;; increase by 1

ENDIF1          BR WHILE1
WHILE2          LD R3, LENGTH_X     ;; LENGTH_X --> R3
                NOT R3, R3          
                ADD R3, R3, 1      ;; increase by 1
                ADD R4, R0, R3      ;; x minus LENGTH_X
                BRzp WHILE3
                LD R3, ARR_X        ;; Lea ARR_X --> R3
                ADD R3, R3, R0      
                LDR R4, R3, 0      ;; ARR_X[x] --> R4
                LD R3, ARR_RES      ;; Lea ARR_RES --> R3
                ADD R3, R3, R2      ;; ARR_RES[z] --> R4
                STR R4, R3, 0      ;; ARR_RES[z] equals ARR_X[x]
                ADD R2, R2, 1      ;; increase by 1
                ADD R0, R0, 1      ;; increase by 1
                BR WHILE2

WHILE3          LD R3, LENGTH_Y     ;; LENGTH_Y --> R3
                NOT R3, R3          
                ADD R3, R3, 1      ;; increase by 1
                ADD R4, R1, R3      ;; y minus LENGTH_Y
                BRzp END
                LD R3, ARR_Y        ;; Lea ARR_Y --> R3
                ADD R3, R3, R1      
                LDR R4, R3, 0      ;; ARR_Y[y] --> R4
                LD R3, ARR_RES      ;; Lea ARR_RES --> R3
                ADD R3, R3, R2      ;; RR_RES[z] --> R4
                STR R4, R3, 0      ;; ARR_RES[z] equals ARR_Y[y]
                ADD R2, R2, 1      ;; increase by 1
                ADD R1, R1, 1      ;; increase by 1
                BR WHILE3

END         
HALT

ARR_X      .fill x4000
ARR_Y      .fill x4100
ARR_RES    .fill x4200

LENGTH_X   .fill 5
LENGTH_Y   .fill 7
LENGTH_RES .fill 12

.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.fill 12
.end

.orig x4100
.fill 3
.fill 4
.fill 6
.fill 9
.fill 15
.fill 16
.fill 17
.end
