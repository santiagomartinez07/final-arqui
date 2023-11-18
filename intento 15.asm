variableA: 0b0
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8 ; Contador de bucle
bitUno: 0b1
variableS: 0b0

inicio:

; Inicializar variables
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

; Verificar si se han procesado todos los bits
mov ACC, M
mov DPTR, ACC
mov ACC, [DPTR]
jz end

; Manejar el bit de signo por separado
mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
mov A, ACC
or ACC, variableS ; Agregar el bit de signo a variableA
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

; Desplazar el multiplicando y el multiplicador
mov ACC, bitUno
mov DPTR, ACC
mov ACC, [DPTR]
and ACC, A   ; Extraer el bit a desplazar
mov A, ACC   ; Guardar el valor actual de variableA

loopDesplazar:

mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
add ACC, A   ; Desplazar variableA a la izquierda
mov A, ACC
mov ACC, variableA
mov DPTR, ACC
mov ACC, A
mov [DPTR], ACC

mov ACC, bitUno
mov DPTR, ACC
mov ACC, [DPTR]
inv ACC   ; Invertir el bit de desplazamiento
mov A, ACC
jmp loopDesplazar   ; Desplazar el multiplicador a la derecha (equivalente a shl -1)

jmp loop

fin:

; Obtener el resultado final
mov ACC, variableA
mov DPTR, ACC
mov ACC, [DPTR]
hlt
