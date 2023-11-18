variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8
bitUno: 0b1
variableS: 0b0

inicio:

mov ACC, 0b1
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A
mov A, ACC
mov ACC, variableS
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

mov ACC, Q_1
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, bitUno
add ACC, A
mov A, ACC

mov ACC, variableS
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
jz  desplazamiento
mov ACC, bitUno
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A
mov A, ACC
jz suma
jmp resta

desplazamiento:

mov ACC, bitUno
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A
mov A, ACC

mov ACC, Q_1
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

RSH ACC, variableA
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

RSH ACC, Q
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC
hlt

suma:

mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC
jmp desplazamiento

resta:

mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
inv ACC
mov A, ACC
mov ACC, bitUno
add ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC
jmp desplazamiento
