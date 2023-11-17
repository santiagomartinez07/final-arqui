; Template para Algoritmo de booth
; Para el algoritmo de booth son necesarias las siguientes variables

variableA: 0b0
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8

; Funciones
FUNCTION TAM:
; Devuelve el tamaño del operando multiplicando

; Regresa el valor de TAM
RET


FUNCTION SUMA:
; Suma los valores de Q(LSB) y A(MSB)

; Carga el valor de Q(LSB) a ACC
MOV ACC, CTE
Q(LSB):
MOV DPTR, ACC
MOV ACC, [DPTR]
MOV A, ACC

; Carga el valor de A(MSB) a ACC
MOV ACC, CTE
A(MSB):
MOV DPTR, ACC
MOV ACC, [DPTR]
MOV A, ACC

; Suma los valores de Q(LSB) y A(MSB)
ADD ACC, A

; Guarda el resultado en Q(LSB)
MOV ACC, CTE
Q(LSB):
MOV DPTR, ACC
MOV [DPTR], ACC

; Regresa al ciclo principal
RET


FUNCTION RESTA:
; Resta los valores de Q(LSB) y A(MSB)

; Carga el valor de Q(LSB) a ACC
MOV ACC, CTE
Q(LSB):
MOV DPTR, ACC
MOV ACC, [DPTR]
MOV A, ACC

; Carga el valor de A(MSB) a ACC
MOV ACC, CTE
A(MSB):
MOV DPTR, ACC
MOV ACC, [DPTR]
MOV A, ACC

; Complementa el valor de A(MSB)
INV ACC

; Suma el valor de A(MSB) a A
ADD A, ACC

; Almacena el resultado en Q(LSB)
MOV ACC, CTE
Q(LSB):
MOV DPTR, ACC
MOV [DPTR], ACC

; Realiza el desplazamiento a la izquierda de Q y A
CALL SHIFT_Q_AND_A

; Continúa el bucle
JMP CTE_LOOP

; Fin del bucle de resta
CTE_LOOP_END:

; Inicio del programa

Init_Loop:
; Inicializa el contador y el valor de la variable Q(LSB)
MOV ACC, CTE
CALL TAM
MOV DPTR, ACC
MOV ACC, [DPTR]
INV ACC
MOV A, ACC

MOV ACC, CTE
0x01
ADD ACC, A
MOV A, ACC

MOV ACC, CTE
ITERATOR:
MOV DPTR, ACC
MOV ACC, [DPTR]
ADD ACC, A
JZ CTE

; Entra al ciclo principal
CALL CICLO_BOOTH

Fin:
; Termina el programa
HLT

; Ciclo principal

CICLO_BOOTH:
; Carga el valor de Q(LSB) a ACC
MOV ACC, CTE
Q(LSB):
MOV DPTR, ACC
MOV ACC, [DPTR]
MOV A, ACC

; Carga el valor de G a ACC
MOV ACC, CTE
G:
MOV DPTR, ACC
MOV ACC, [DPTR]
ADD ACC, A

; Si ACC es igual a 0, termina el ciclo
JZ CTE_LOOP_END

; Llama a la subrutina RESTA
CALL RESTA

; Realiza el desplazamiento a la izquierda de Q y A
CALL SHIFT_Q_AND_A

; Continúa el bucle
JMP CTE_LOOP

; Fin del bucle principal
CTE_LOOP_END:

; Imprime el resultado
MOV ACC, Q
MOV DPTR, CTE
MOV [DPTR], ACC

; Termina el programa
HLT
