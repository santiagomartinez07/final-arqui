variableA: 0b0
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8 ; Contador de bucle
bitUno: 0b1
variableS: 0b0

inicio:

mov ACC, 0b1
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A   ; Extraer el bit de signo de Q
mov A, ACC
mov ACC, variableS
mov DPTR, ACC
mov ACC, A   ; Inicializar variable de signo
mov [DPTR], ACC

mov ACC, Q_1
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A   ; Extraer el bit de signo de Q_1
mov A, ACC
mov ACC, bitUno
add ACC, A
mov A, ACC   ; Calcular el bit a agregar

mov ACC, variableS
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A   ; Actualizar la variable de signo si el bit está establecido

loop:

mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
jz fin

mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
MOV A, ACC
AND A, variableS
MOV ACC, A
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

mov ACC, bitUno
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A   ; Extraer el bit a desplazar
mov A, ACC   ; Guardar el valor actual de variableA
LSH ACC, 1   ; Desplazar variableA
mov variableA, ACC   ; Actualizar variableA
LSH ACC, 1   ; Desplazar nuevamente para obtener el siguiente bit
mov A, ACC
mov ACC, Q
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A   ; Extraer el bit a desplazar
RSH ACC, 1   ; Desplazar el multiplicador
mov Q, ACC   ; Actualizar el multiplicador
RSH ACC, 1   ; Desplazar nuevamente para obtener el siguiente bit
mov A, ACC

mov ACC, variableS
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A   ; Actualizar la variable de signo si el bit a agregar está establecido

jmp loop

fin:

mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
hlt
