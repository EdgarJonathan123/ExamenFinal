
	Num db 100 dup('$')

    bufferLectura   db 1000  dup('$')
    bufferRespuesta db 100  dup('$')
	buffer          db 10000 dup('$')
	NumArchivos   	word 1 dup('$')
	NumTam        	word 1 dup('$')
	enc1 		  	db '>>RECONOCIENDO ARCHIVO','$'
	enc2          	db '>>ANALIZANDO ARCHIVO','$'
	enc3          	db '>>SE CREO ARCHIVO SALIDA ','$'


	flag1			db '0','$'    ;comprobar si es un numero
	flag2			db '0','$'   ;comprobar si es una letra
	debug			db 'prueba',13,10,'$'
	variable1  		db 10 dup('$')
	nombre  		db 50 dup('$')				;nombre
	rutaEntrada   	db 'F/entrada.txt',0
	rutaSalida    	db 'F/salida.txt',0
	varible3 db '32','$'
	handle 			dw ?

	tmp word 1 dup('$')     ;hace como una pop para no tocar la pila