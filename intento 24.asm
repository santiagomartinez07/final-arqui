variableA:0x0 
Q: 0b10000001 ; Multiplicador
Q_1:0x0
M: 0b11111101; Multiplicando
count: 0x8


inicio:

mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
AND ACC, A
mov A, ACC

mov ACC, Q_1
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A
mov A, ACC
jz  desplazamiento

mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
and ACC, A
mov A, ACC
jz suma
jmp resta
hlt

desplazamiento:

mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
mov ACC, 0x1
AND ACC, A
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
;jmp inicio
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
hlt

resta:

mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
inv ACC
mov A, ACC
mov ACC, 0x1
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
hlt
