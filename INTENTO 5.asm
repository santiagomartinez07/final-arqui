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
  RET CTE


FUNCTION SUMA:
  ; Suma los valores de Q(LSB) y A(MSB)

  ; Carga el valor de Q(LSB) a ACC
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Carga el valor de A(MSB) a ACC
  MOV ACC, CTE
  A(MSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Suma los valores de Q(LSB) y A(MSB)
  ADD ACC, A

  ; Guarda el resultado en Q(LSB)
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV [DPTR], ACC

  ; Regresa al ciclo principal
  RET CTE


FUNCTION RESTA:
  ; Resta los valores de Q(LSB) y A(MSB)

  ; Carga el valor de Q(LSB) a ACC
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Carga el valor de A(MSB) a ACC
  MOV ACC, CTE
  A(MSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Resta los valores de Q(LSB) y A(MSB)
  SUB ACC, A

  ; Guarda el resultado en Q(LSB)
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV [DPTR], ACC

  ; Regresa al ciclo principal
  RET CTE


; Inicio del programa

Init_Loop:
  ; Inicializa el contador y el valor de la variable Q(LSB)
  MOV ACC, CTE
  TAM
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  INV ACC
  MOV A, ACC

  MOV ACC, CTE
  0x01
  ADD ACC, A
  MOV A, ACC

  MOV ACC, CTE
  ITERATOR
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
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Carga el valor de G a ACC
  MOV ACC, CTE
  G
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV [DPTR], ACC

  ; Carga el valor de Q-1 a ACC
  MOV ACC, CTE
  Q-1
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  INV ACC
  MOV A, ACC

  ; Suma 1 a ACC
  MOV ACC, CTE
  0x01
  ADD ACC, A
  MOV A, ACC

  ; Carga el valor de G a ACC
  MOV ACC, CTE
  G
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  ADD ACC, A

  ; Si ACC es 0, termina el ciclo
  JZ CTE
; Sub-ciclo de desplazamiento

DESPLAZAMIENTO:
  ; Carga el valor de Q(LSB) a ACC
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Guarda el valor de Q-1 en Q(LSB)
  MOV ACC, CTE
  Q-1
  MOV DPTR, ACC
  MOV [DPTR], ACC

  ; Carga el valor de Q(MSB) a ACC
  MOV ACC, CTE
  Q(MSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Shiftea a la izquierda el valor de Q(MSB)
  MOV ACC, A
  SHR ACC, 1
  MOV [DPTR], ACC

  ; Carga el valor de A(MSB) a ACC
  MOV ACC, CTE
  A(MSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  ; Shiftea a la izquierda el valor de A(MSB)
  MOV ACC, A
  SHR ACC, 1
  MOV [DPTR], ACC

  ; Regresa al ciclo principal
  CALL CICLO_BOOTH

; Fin del programa

Fin:
  ; Termina el programa
  HLT
