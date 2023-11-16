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

Inicio_Ciclo
	Cargar_Tamano: MOV ACC, CTE ; Cargar el tamaño al acumulador
TAM
	MOV DPTR, ACC ; Mover la dirección del tamaño a DPTR
	MOV ACC, [DPTR] ; Mover el valor en la dirección de tamaño al acumulador
	Invertir_Acumulador: INV ACC ; Invertir el acumulador
	MOV A, ACC ; Mover el acumulador a A
	Cargar_Direccion_Iterador: MOV ACC, CTE ; Cargar la dirección del iterador en el acumulador
0x01 ; Constante 1
	ADD ACC, A ; Sumar acumulador con A (complemento a2)
	MOV A, ACC ; Mover el acumulador a A
	Cargar_Direccion_Iterador_2: MOV ACC, CTE ; Cargar la dirección del iterador en el acumulador
Iterador
	MOV DPTR, ACC ; Mover la dirección del Iterador a DPTR
	MOV ACC, [DPTR] ; Mover el valor en la dirección de Iterador al acumulador
	ADD ACC, A ; ACC = -tamaño + Iterador
	JN Saltar_Si_Menor_Cero ; Salta si el resultado es menor a 0
Ciclo_Booth
	MOV ACC, CTE ; Cargar la dirección del LSB al acumulador
Q_LSB
	MOV DPTR, ACC ; Mover la dirección del LSB a DPTR
	MOV ACC, [DPTR] ; Mover el valor en la dirección de LSB al acumulador
	MOV A, ACC ; Mover el acumulador a A
	Invertir_Acumulador_2: INV ACC ; Invertir el acumulador
	MOV A, ACC ; Mover el acumulador a A
	MOV ACC, CTE ; Cargar la dirección de G al acumulador
G
	MOV DPTR, ACC ; Mover la dirección de G a DPTR
	MOV ACC, A ; Mover A al acumulador
	[DPTR], ACC ; Mover el acumulador a lo que contiene G
	MOV ACC, CTE ; Cargar la dirección de Q-1 en el acumulador
Q_1
	MOV DPTR, ACC ; Mover la dirección de Q-1 a DPTR
	MOV ACC, [DPTR] ; Mover el valor en la dirección de Q-1 al acumulador
	INV ACC ; Invertir el acumulador
	MOV A, ACC ; Mover el acumulador a A
	Cargar_Direccion_Iterador_3: MOV ACC, CTE ; Cargar la dirección del iterador en el acumulador
	0x01 ; Constante 1
	ADD ACC, A ; Sumar el acumulador con A (complemento a2)
	MOV A, ACC ; Mover el acumulador a A
	MOV ACC, CTE ; Cargar la dirección de G al acumulador
G
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, [DPTR] ; Mover lo que hay en G al acumulador
	ADD ACC, A ; Sumar el acumulador con A (para saber si son iguales o no)
	JZ Saltar_Si_Iguales ; Salta si el resultado es igual a 0
Desplazamiento
	MOV ACC, CTE ; Cargar la dirección del LSB al acumulador
Q_LSB
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, [DPTR] ; Mover el valor en LSB al acumulador
	INV ACC ; Invertir el acumulador
	MOV A, ACC ; Mover el acumulador a A
	JZ Saltar_Si_Cero ; Salta si es cero (significa que se suma M al registro A)
Suma
	JMP Saltar_Si_No_Cero ; Salta si no es cero (se realiza la resta)
Resta
	MOV ACC, CTE ; Cargar la dirección del LSB al acumulador
Q_LSB
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, [DPTR] ; Mover lo que contiene LSB al acumulador
	MOV A, ACC ; Mover el acumulador a A

// Validación del número
	MOV ACC, CTE ; Cargar la dirección del MSB al acumulador
Q_MSB
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, [DPTR]
	JZ Saltar_Si_MSB_Es_Cero ; Salta si el MSB es 0 (el número es válido)
Invalido
	JMP Fin_Ciclo
	MOV ACC, CTE ; Cargar la dirección del MSB al acumulador
Q_MSB
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, [DPTR]
	JZ Saltar_Si_MSB_Es_Cero ; Salta si el MSB es 0 (el número es válido)
Invalido
	JMP Saltar_SI_No_Es_Valido ; Salta si el número no es válido, al final

// Mantenimiento del estado
	MOV ACC, CTE ; Cargar la dirección del LSB al acumulador
Q_LSB
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, [DPTR] ; Mover lo que hay en LSB al acumulador
	MOV A, ACC ; Mover el acumulador a A
	MOV CTE, A

// Registro del estado
	MOV ACC, CTE ; Cargar la dirección del registro del estado al acumulador
Estado
	MOV DPTR, ACC ; Mover el acumulador a DPTR
	MOV ACC, A ; Mover A al acumulador
	[DPTR], ACC ; Mover el acumulador a lo que contiene Estado

// Salto a la siguiente iteración
	JMP Saltar_Siguiente_Iteracion

// Fin del ciclo
	Fin_Ciclo
