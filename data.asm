
	Num db 100 dup('$')

    bufferLectura   db 100  dup('$')
    bufferRespuesta db 100  dup('$')
	buffer          db 1000 dup('$')
	NumArchivos   	byte 1 dup('$')
	NumTam        	byte 1 dup('$')
	enc1 		  	db '>>RECONOCIENDO ARCHIVO','$'
	enc2          	db '>>ANALIZANDO ARCHIVO'
	rutaEntrada   	db 'F/entrada.txt',0
	rutaSalida    	db 'F/salida.txt',0
	handle 			dw ?

