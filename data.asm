
	Num db 100 dup('$')

    bufferLectura   db 100  dup('$')
    bufferRespuesta db 100  dup('$')
	buffer          db 1000 dup('$')
	NumArchivos   	word 1 dup('$')
	NumTam        	word 1 dup('$')
	enc1 		  	db '>>RECONOCIENDO ARCHIVO','$'
	enc2          	db '>>ANALIZANDO ARCHIVO','$'
	enc3          	db '>>SE CREO ARCHIVO SALIDA ','$'
	rutaEntrada   	db 'F/entrada.txt',0
	rutaSalida    	db 'F/salida.txt',0
	handle 			dw ?
	flag1			db '0','$'    ;comprobar si es un numero
	flag2			db '0','$'   ;comprobar si es una letra
