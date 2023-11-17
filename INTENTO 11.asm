; Template para Algoritmo de booth
; Para el algoritmo de booth son necesarias las siguientes variables

Q: 0b10000001 ; Multiplicador
M: 0b11111101 ; Multiplicando

; Funciones
FUNCTION TAM:
; Devuelve el tamaño del operando multiplicando

; Regresa el valor de TAM
RET


FUNCTION SUMA:
; Suma los valores de Q(LSB) y A(MSB)

; Carga el valor de Q(LSB) a ACC
MOV ACC, Q(LSB)

; Carga el valor de A(MSB) a ACC
MOV ACC, A(MSB)

; Realiza la operación de AND entre ACC y A
AND ACC, A

; Realiza la suma manualmente sin la instrucción ADD ACC, A
ADD ACC, #0x01 ; Suma 1 manualmente

; Guarda el resultado en Q(LSB)
MOV Q(LSB), ACC

; Regresa al ciclo principal
RET


FUNCTION RESTA:
; Resta los valores de Q(LSB) y A(MSB)

; Carga el valor de Q(LSB) a ACC
MOV ACC, Q(LSB)

; Carga el valor de A(MSB) a ACC
MOV ACC, A(MSB)

; Complementa el valor de A(MSB)
INV ACC

; Suma el valor de A(MSB) a A
ADD ACC, A

; Almacena el resultado en Q(LSB)
MOV Q(LSB), ACC

; Realiza el desplazamiento a la izquierda de Q y A
CALL SHIFT_Q_AND_A

; Continúa el bucle
JMP CTE_LOOP

; Fin del bucle de resta
CTE_LOOP_END:

; Inicio del programa

Init_Loop:
; Inicializa el contador y el valor de la variable Q(LSB)
MOV ACC, #0x08
MOV A, ACC

MOV ACC, #0x01
ADD ACC, A
MOV A, ACC

MOV ACC, #0x00
ITERATOR:
MOV A, [ACC]
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
MOV ACC, Q(LSB)

; Carga el valor de G a ACC
MOV ACC, G

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
MOV [ACC], A

; Termina el programa
HLT
