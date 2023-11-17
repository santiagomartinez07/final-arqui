; Template para Algoritmo de booth

; Observe que los comentarios están especificados usando ";"
; por lo tanto, todo lo que encuentre despues de este simbolo así será tratado.


; Hasta este punto del curso se asume llena la información a operar en memoria
; Acá se describe como cargar los datos para la ejecución y como usarlos

; Cada variable que se desee usar debe definirse usando un nombre, una serie de caracteres (Palabras) 
; Para identificar ques es una variable se debe usar ":" y posteriormente agregar el valor inicial
; el valor inicial puede agregarse en binario o hexadecimal, recuerde agregar el prefijo correspondiente
; "0b" para binario o "0x para hexadecimal".
; Aunque parece una asignación directa, recuerde que debe usar el DTPR para acceder a esta información
; pues al hacer referencia al nombre de la variable, se accederá a la posición de memoria de la misma,
; no a su contenido.

; Para el algoritmo de booth son necesarias las siguientes variables
; aunque el nombre no es importante, es recomendable mantenerlo.
; Es importante mantener el orden de estas variables, pues la visualización de la interfaz web
; se basa en la dirección de memoria, no en el nombre de la variable.

variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8

; Es importante destacar una diferencia en este punto, un indice para realizar saltos en el código
; se define usando el simbolo ":" al igual que la definición de una variable
; La diferencia radica en la asignación del valor, es decir, si no se detecta valor, 
; se establece esa pocisión de código como indice

Init_Loop
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
  JN CTE
  CICLO_BOOTH
  JMP CTE
  END_LOOP

CICLO_BOOTH
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  MOV ACC, CTE
  G
  MOV DPTR, ACC
  MOV ACC, A
  MOV [DPTR], ACC

  MOV ACC, CTE
  Q-1
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  INV ACC
  MOV A, ACC

  MOV ACC, CTE
  0x01
  ADD ACC, A
  MOV A, ACC

  MOV ACC, CTE
  G
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  ADD ACC, A
  JZ CTE
  DESPLAZAMIENTO

  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  JZ CTE
  SUMA
  JMP CTE
  RESTA

DESPLAZAMIENTO
  MOV ACC, CTE
  Q(LSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  MOV ACC, CTE
  Q-1
  MOV DPTR, ACC
  MOV [DPTR], A

  MOV ACC, CTE
  Q(MSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  MOV ACC, CTE
  Q
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  SHR ACC, 1
  MOV [DPTR], ACC

  MOV ACC, CTE
  Q(MSB)
  MOV DPTR, ACC
  MOV [DPTR], A

  MOV ACC, CTE
  A(MSB)
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  MOV ACC, CTE
  A
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  SHR ACC, 1
  MOV [DPTR], ACC

  MOV ACC, CTE
  A(MSB)
  MOV DPTR, ACC
  MOV [DPTR], A

  JMP CTE
  Init_Loop

SUMA
  MOV ACC, CTE
  M
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  MOV A, ACC

  MOV ACC, CTE
  A
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  ADD ACC, A
  MOV A, ACC

  MOV ACC, CTE
  A
  MOV DPTR, ACC
  MOV ACC, A
  MOV [DPTR], ACC

  JMP CTE
  DESPLAZAMIENTO

RESTA
  MOV ACC, CTE
  M
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  INV ACC

  MOV ACC, CTE
  0x01
  ADD ACC, A
  MOV A, ACC

  MOV ACC, CTE
  A
  MOV DPTR, ACC
  MOV ACC, [DPTR]
  ADD ACC, A
  MOV A, ACC

  MOV ACC, CTE
  A
  MOV DPTR, ACC
  MOV ACC, A
  MOV [DPTR], ACC

  JMP CTE
  DESPLAZAMIENTO
