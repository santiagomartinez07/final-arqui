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

loop:

mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
jz end

mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A

mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

mov ACC, bitUno
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A

mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A

jnz loop

end:

mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
hlt
