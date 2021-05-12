;; Timed Lab 3
;; Student Name:

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA on Piazza quickly.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;;
;; ABS(x) {
;;     if (x < 0) {
;;         return -x;
;;     } else {
;;         return x;
;;     }
;; }
;;
;;
;;
;; POW3(x) {
;;     if (x == 0) {
;;         return 1;
;;     } else {
;;         return 3 * POW3(x - 1);
;;     }
;; }
;;
;;
;; MAP(array, length) {
;;     i = 0;
;;     while (i < length) {
;;         element = arr[i];
;;         if (i & 1 == 0) {
;;             result = ABS(element);
;;         } else {
;;             result = POW3(element);
;;         }
;;         arr[i] = result;
;;         i++;
;;     }
;; }

.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START ABS SUBROUTINE
ABS
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

LDR R0, R5, 4
BRzp ABSELSE
NOT R0, R0
ADD R0, R0, 1
STR R0, R5, 3
BR ABSENDIF
ABSELSE
STR R0, R5, 3
ABSENDIF

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
; END ABS SUBROUTINE




; START POW3 SUBROUTINE
POW3
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

LDR R0, R5, 4       ; R0 = n

BRnp POWELSE      ; if n != 0, then skip to POWELSE
AND R0, R0, 0
ADD R0, R0, 1 
STR R0, R5, 3
BR RETPOW3

POWELSE
ADD R0, R0, -1
ADD R6, R6, -1
STR R0, R6, 0
JSR POW3
LDR R0, R6, 0
ADD R6, R6, 2
ADD R1, R0, R0
ADD R1, R1, R0
STR R1, R5, 3
BR RETPOW3

RETPOW3
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
; END POW3 SUBROUTINE




; START MAP SUBROUTINE
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

AND R0, R0, 0
LDR R1, R5, 5
NOT R1, R1
ADD R1, R1, 1
MAPWHILE
ADD R2, R0, R1
BRzp MAPENDWHILE
LDR R3, R5, 4
ADD R3, R3, R0
LDR R4, R3, 0
MAPIF
STR R0, R5, 0
AND R0, R0, 1
BRnp MAPENDIF
ADD R6, R6, -1
STR R4, R6, 0
JSR ABS
LDR R4, R6, 0
ADD R6, R6, 2
BR MAPENDELSE
MAPENDIF
ADD R6, R6, -1
STR R4, R6, 0
JSR POW3
LDR R4, R6, 0
ADD R6, R6, 1
MAPENDELSE
LDR R0, R5, 0
STR R4, R3, 0
ADD R0, R0, 1
BR MAPWHILE
MAPENDWHILE

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
; END MAP SUBROUTINE


; ARRAY FOR TESTING
ARRAY .fill x4000
.end

.orig x4000
.fill -2
.fill 5
.fill 3
.fill 2
.fill -6
.fill 0
.end
