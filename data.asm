
	space db ' ','$'
	salt db 0ah,0dh, '	','$'
	tab db 9,'$'
	;ENCABEZADO
	msm0     db  9,9,'***UNIVERSIDAD DE SANCARLOS DE GUATEMALA***',13,10,9,9,'FACULTAD DE INGENIERIA',13,10,9,9,'CIENCIAS Y SISTEMAS',13,10,9,9,'ARQUITECTURA DE COMPUTADORES  Y ENSAMBLADORES 1',13,10,9,9,'SECCION B',13,10,9,9,'NOMBRE: EDGAR JONATHAN ARRECIS MARTINEZ',13,10,9,9,'CARNTE: 201602633',13,10,9,9,'TAREA PRACTICA 5',13,10,'$'
    msm8     db   13,10,9,9,'****Menu Principal *****',13,10,9,9,'1) Ingreso Usuario ',13,10,9,9,'2) Registro Usuario',13,10,9,9,'3) Ingreso Admin',13,10,9,9,'4) Salir','$'
 
	Num db 100 dup('$')
	corA db 91,'$'
    corC db 93,'$'

    aux db 50 dup('$')

    auxContra byte 15 dup('$')
    auxNombre byte 15 dup('$')

	usuario STRUCT
        nombre BYTE 15 dup('$')
        contra BYTE 15 dup('$')
        punteo WORD 0
        tiempo word 0
	usuario ENDS  

		;==========================================================================================
		;==========================================================================================

    bufferLectura db 100  dup('$')
	buffer        db 1000 dup('$')
	NumArchivos   byte 1 dup('$')
	NumTam        byte 1 dup('$')
	rutaEntrada   db 'F/entrada.txt',0
	rutaSalida    db 'F/salida.txt',0
	handle dw ?

