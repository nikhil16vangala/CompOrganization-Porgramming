;;=============================================================
;; CS 2110 - Spring 2021
;; Homework 6 - Bubble Sort with Compare
;;=============================================================
;; Name: Sai Nikhil Vangala
;;=============================================================

;; In this file, you must implement the 'SORT' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; array: memory address of the first element in the array
;; len: integer value of the number of elements in the array
;; compare: memory address of the subroutine used to compare elements
;;
;; sort(array, len, function compare) {
;;     // last index of the array
;;     y = len - 1;
;;     while(y > 0) {
;;         x = 0;
;;         while(x < y) {
;;             // if compare returns 1, swap
;;             if (compare(ARRAY[x], ARRAY[x+1]) > 0) {
;;                 temp = ARRAY[x];
;;                 ARRAY[x] = ARRAY[x+1];
;;                 ARRAY[x+1] = temp;
;;             }
;;             x++;
;;         }
;;         y--;
;;     }
;; }
;;
;; HINT: compare will be passed as a parameter on the stack. It will be a
;; a pointer to one of the subroutines below. Think about which instruction
;; allows you to call a subroutine with a memory address that is stored in a register
SORT

ADD R6, R6, -4      ; allocate register value space  
STR R7, R6, 2       ; save return address
STR R5, R6, 1       ; save old Frame Pointer
ADD R5, R6, 0       ; update frame pointer to point at first local variable
ADD R6, R6, -7      ; make room for saving register state
STR R0, R5, -3      ; save R0
STR R1, R5, -4      ; save R1
STR R2, R5, -5      ; save R2
STR R3, R5, -6      ; save R3
STR R4, R5, -7      ; save R4

LDR R0, R5, 5      ; R0 = len
ADD R0, R0, -1     ; R0 = len - 1
STR R0, R5, 0      ; R0 = y = len -1

while
LDR R0, R5, 0      ; conditions being set for y
BRnz sortreturn     ; if y <= 0, skip to sortreturn

AND R0, R0, 0
STR R0, R5, -1     ; x = 0

while1
LDR R0, R5, 0      ; R0 = y
LDR R1, R5, -1     ; R1 = x

NOT R0, R0
ADD R0, R0, 1
ADD R1, R0, R1      ; R1 = x - y
BRzp endwhile1      ; skip to endwhile1

LDR R0, R5, -1     ; R0 = x
LDR R1, R5, 4      ; R1 = address of array
ADD R1, R0, R1     
LDR R2, R1, 0      ; R2 = ARRAY[x]
LDR R3, R1, 1      ; R3 = ARRAY[x+1]
LDR R0, R5, 6
ADD R6, R6, -2     ; allocate space
STR R3, R6, 1      ; push R3 to stack
STR R2, R6, 0      ; push R2 to stack
JSRR R0             ; call compare subroutine
LDR R0, R6, 0      ; R0 = compare(ARRAY[x], ARRAY[x+1])
ADD R6, R6, 3      ; deallocate space
ADD R0, R0, 0
BRnz endif           ; skip to endif

LDR R0, R5, -1      ; R0 = x
LDR R1, R5, 4       ; R1 = address of array
ADD R1, R0, R1
LDR R2, R1, 0       ; R2 = ARRAY[x]
LDR R3, R1, 1       ; R3 = ARRAY[x+1]
STR R3, R1, 0       ; 
STR R2, R1, 1       ; 
BR endif

endif 
LDR R0, R5, -1     ; R0 = x
ADD R0, R0, 1      ; R0 = x+1
STR R0, R5, -1     ; x = R0
BR while1

endwhile1
LDR R0, R5, 0      ; R0 = y
ADD R0, R0, -1     ; R0 = y-1
STR R0, R5, 0      ; y = R0
BR while

sortreturn

LDR R4, R5, -7      ; restore R4
LDR R3, R5, -6      ; restore R3
LDR R2, R5, -5      ; restore R2
LDR R1, R5, -4      ; restore R1
LDR R0, R5, -3      ; restore R0

ADD R6, R5, 0       ; restore stack pointer to frame pointer
LDR R7, R6, 2       ; restore original return address
LDR R5, R6, 1       ; restore old frame pointer
ADD R6, R6, 3       ; pop past local variables -- R6 points to RV now

RET

;; used by the autograder
STACK .fill xF000
.end

;; USE FOR DEBUGGING IN COMPLEX
;; load array at x4000 and put the length as 7
;; you can use the memory addresses of the subroutines below for the last parameter

;; ARRAY
.orig x4000
    .fill 4
    .fill -9
    .fill 0
    .fill -2
    .fill 9
    .fill 3
    .fill -10
.end

;; The following subroutines are possible functions that may be passed
;; as the function address parameter into the sorting function.
;; DO NOT edit the code below; it will be used by the autograder.
.orig x5000
;; returns a positive number if a>b
;; compare(a,b) for ascending sort
CMPGT
    .fill   x1DBD
    .fill   x7180
    .fill   x7381
    .fill   x6183
    .fill   x6384
    .fill   x927F
    .fill   x1261
    .fill   x1201
    .fill   x0C03
    .fill   x5020
    .fill   x1021
    .fill   x0E01
    .fill   x5020
    .fill   x7182
    .fill   x6180
    .fill   x6381
    .fill   x1DA2
    .fill   xC1C0
.end

.orig x5100
;; returns a positive number if b>a
;; compare(a,b) for descending sort
CMPLT
    .fill   x1DBD
    .fill   x7180
    .fill   x7381
    .fill   x6183
    .fill   x6384
    .fill   x927F
    .fill   x1261
    .fill   x1201
    .fill   x0603
    .fill   x5020
    .fill   x1021
    .fill   x0E01
    .fill   x5020
    .fill   x7182
    .fill   x6180
    .fill   x6381
    .fill   x1DA2
    .fill   xC1C0
.end

.orig x5200
;; returns a positive number if |a| > |b|
;; compare(a,b) for ascending sort on magnitudes (absolute value)
CMPABS
    .fill   x1DBD
    .fill   x7180
    .fill   x7381
    .fill   x6183
    .fill   x0602
    .fill   x903F
    .fill   x1021
    .fill   x6384
    .fill   x0C02
    .fill   x927F
    .fill   x1261
    .fill   x1240
    .fill   x0C03
    .fill   x5020
    .fill   x1021
    .fill   x0E01
    .fill   x5020
    .fill   x7182
    .fill   x6180
    .fill   x6381
    .fill   x1DA2
    .fill   xC1C0
.end

MAP

ADD R6, R6, -4      ; allocate register value space  
STR R7, R6, 2       ; save return address
STR R5, R6, 1       ; save old Frame Pointer
ADD R5, R6, 0       ; update frame pointer to point at first local variable
ADD R6, R6, -7      ; make room for saving register state
STR R0, R5, -3      ; save R0
STR R1, R5, -4      ; save R1
STR R2, R5, -5      ; save R2
STR R3, R5, -6      ; save R3
STR R4, R5, -7      ; save R4

ADD R0, R0, #0
LDR R1, R5, #5
NOT R1, R1
ADD R1, R1, #1
WHILE
ADD R2, R0, R1
BRzp ENDWHILE
LEA R3, ARRAY
LDR R4, R3, R0
IF
STR R0, R5, #0
AND R0, R0, #1
BRnp ENDIF
ADD R6, R6, #-1
STR R4, R6, #0
JSR ABS
LDR R4, R6, #0
ADD R6, R6, #1
ENDIF
BR ENDCOND
ADD R6, R6, #-1
STR R4, R6, #0
JSR POW3
LDR R4, R6, #0
ADD R6, R6, #1
ENDCOND
LDR R0, R5, #0
STR R4, R3, R0
ADD R0, R0, #1
BR WHILE
ENDWHILE

LDR R4, R5, -7      ; restore R4
LDR R3, R5, -6      ; restore R3
LDR R2, R5, -5      ; restore R2
LDR R1, R5, -4      ; restore R1
LDR R0, R5, -3      ; restore R0

ADD R6, R5, 0       ; restore stack pointer to frame pointer
LDR R7, R6, 2       ; restore original return address
LDR R5, R6, 1       ; restore old frame pointer
ADD R6, R6, 3       ; pop past local variables -- R6 points to RV now