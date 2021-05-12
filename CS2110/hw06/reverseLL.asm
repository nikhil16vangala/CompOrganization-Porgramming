;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 6 - Reverse Linked List
;;=============================================================
;; Name: Sai Nikhil Vangala
;;============================================================

;; In this file, you must implement the 'reverseLL' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of reverseLL: Node head
;;
;; reverseLL(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return NULL;
;;     }
;;     if (head.next == NULL) {
;;         return head;
;;     }
;;     Node tail = head.next;
;;     Node newHead = reverseLL(tail);
;;     tail.next = head;
;;     head.next = NULL;
;;     return newHead;
;; }
reverseLL

ADD R6, R6, -4          ; allocate register value space  
STR R7, R6, 2           ; save return address
STR R5, R6, 1           ; save old Frame Pointer
ADD R5, R6, 0           ; update frame pointer to point at first local variable
ADD R6, R6, -5          ; make room for saving register state
STR R0, R5, -1          ; save R0
STR R1, R5, -2          ; save R1
STR R2, R5, -3          ; save R2
STR R3, R5, -4          ; save R3
STR R4, R5, -5          ; save R4

LDR R0, R5, 4           ; R0 = head

BRnp HEADNEXTIF         ; if head != NULL, then skip to HEADNEXTIF
STR R0, R5, 0           ; returh NULL
BRnzp reverseLLreturn   ; skip to reverseLLreturn

HEADNEXTIF
LDR R1, R0, 0           ; R1 = head.next
BRnp RECURSIVE          ; if head.next != NULL, then skip to RECURSIVE
STR R0, R5, 0           ; return head
BRnzp reverseLLreturn   ; skip to reverseLLreturn

RECURSIVE
ADD R6, R6, -1          ; allocate space
STR R1, R6, 0           ; push R1 to stack
JSR reverseLL           ; call reverseLL
LDR R2, R6, 0           ; retrieve R2 from stack
ADD R6, R6, 2           ; deallocate space
STR R0, R1, 0
AND R3, R3, 0
STR R3, R0, 0          
STR R2, R5, 0           ; return newHead

reverseLLreturn
LDR R0, R5, 0 
STR R0, R5, 3           ; store result into allocated register value space

LDR R4, R5, -5          ; restore R4
LDR R3, R5, -4          ; restore R3
LDR R2, R5, -3          ; restore R2
LDR R1, R5, -2          ; restore R1
LDR R0, R5, -1          ; restore R0

ADD R6, R5, 0           ; restore stack pointer to frame pointer
LDR R7, R6, 2           ; restore original return address
LDR R5, R6, 1           ; restore old frame pointer
ADD R6, R6, 3           ; pop past local variables -- R6 points to RV now

RET

;; used by the autograder
STACK .fill xF000
.end

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end
