;;=======================================
;; CS 2110 - Spring 2020
;; HW6 - Recursive Fibonacci Sequence
;;=======================================
;; Name: Sai Nikhil Vangala
;;=======================================

;; In this file, you must implement the 'fib' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of Fibonacci number: integer n
;;
;; Pseudocode:
;; fib(int n) {
;;     if (n == 0) {
;;         return 0;
;;     } else if (n == 1) {
;;         return 1;
;;     } else {
;;         return fib(n - 1) + fib(n - 2);
;;     }
;; }
fib
ADD R6, R6, -4      ; allocate register value space  
STR R7, R6, 2       ; save return address
STR R5, R6, 1       ; save old Frame Pointer
ADD R5, R6, 0       ; update frame pointer to point at first local variable
ADD R6, R6, -5      ; make room for saving register state
STR R0, R5, -1      ; save R0
STR R1, R5, -2      ; save R1
STR R2, R5, -3      ; save R2
STR R3, R5, -4      ; save R3
STR R4, R5, -5      ; save R4

LDR R0, R5, 4       ; R0 = n

BRnp fibELSEIF      ; if n != 0, then skip to ELSEIF
AND R0, R0, 0       ; R0 = 0
BRnzp fibreturn     ; skip to fibreturn

fibELSEIF
ADD R0, R0, -1      ; R0 = n == 1
BRnp fibELSE        ; if n != 1, then skip to ELSE
ADD R0, R0, #1      ; R0 = 1
BRnzp fibreturn     ; skip to fibreturn

fibELSE
LDR R0, R5, 4       ; R0 = n
ADD R0, R0, -1      ; R0 = n-1
AND R1, R1, 0       ; R1 = 0
ADD R1, R0, -1      ; R1 = n-1-1 = n-2
ADD R6, R6, -1      ; allocate space
STR R0, R6, 0       ; push n-1 to stack
JSR fib             ; call fib
LDR R0, R6, 0       ; retrieve R0 from stack
ADD R6, R6, 2       ; deallocate space
ADD R6, R6, -1      ; allocate space
STR R1, R6, 0       ; push n-2 to stack
JSR fib             ; call fib
LDR R1, R6, 0       ; retrieve R1 from stack
ADD R6, R6, 2       ; deallocate space
ADD R0, R0, R1      ; R0 = R0 + R1 = fib(n - 1) + fib(n - 2)

fibreturn
STR R0, R5, 3       ; store result into allocated register value space

LDR R4, R5, -5      ; restore R4
LDR R3, R5, -4      ; restore R3
LDR R2, R5, -3      ; restore R2
LDR R1, R5, -2      ; restore R1
LDR R0, R5, -1      ; restore R0

ADD R6, R5, 0       ; restore stack pointer to frame pointer
LDR R7, R6, 2       ; restore original return address
LDR R5, R6, 1       ; restore old frame pointer
ADD R6, R6, 3       ; pop past local variables -- R6 points to RV now
RET

;; used by the autograder
STACK .fill xF000
.end
