
	Num db 100 dup('$')

    bufferLectura db 100  dup('$')
	buffer        db 1000 dup('$')
	NumArchivos   byte 1 dup('$')
	NumTam        byte 1 dup('$')
	rutaEntrada   db 'F/entrada.txt',0
	rutaSalida    db 'F/salida.txt',0
	handle dw ?

