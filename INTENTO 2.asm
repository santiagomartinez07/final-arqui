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

Inicio_Ciclo:

    Cargar_Tamano:
        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        INV ACC
        mov A, ACC

        Cargar_Direccion_Iterador:
            mov ACC, CTE
            mov DPTR, ACC
            mov ACC, [DPTR]
            ADD ACC, A
            mov A, ACC

        Cargar_Direccion_Iterador_2:
            mov ACC, CTE
            mov DPTR, ACC
            mov ACC, [DPTR]
            ADD ACC, A

        jc Saltar_Si_Menor_Cero

Ciclo_Booth:

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        mov A, ACC
        INV ACC
        mov A, ACC

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        mov A, ACC

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        ADD ACC, A
        jn Saltar_Si_Menor_Cero

Desplazamiento:

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        INV ACC
        mov A, ACC
        jz Saltar_Si_Cero

Suma:
        JMP Saltar_Si_No_Cero

Resta:
        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        mov A, ACC

; Validación del número

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        jz Saltar_Si_MSB_Es_Cero

Invalido:
        JMP Fin_Ciclo

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        jz Saltar_Si_MSB_Es_Cero

Invalido:
        JMP Saltar_SI_No_Es_Valido

; Mantenimiento del estado

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, [DPTR]
        mov A, ACC
        mov CTE, A

; Registro del estado

        mov ACC, CTE
        mov DPTR, ACC
        mov ACC, A
        mov [DPTR], ACC

; Salto a la siguiente iteración

        JMP Saltar_Siguiente_Iteracion

;Fin del ciclo

Fin_Ciclo:
