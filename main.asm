
main proc
    Inicio:
        IniciarDs
		abrirF rutaEntrada, handle 
		leerF SIZEOF buffer,buffer,handle
		print buffer

        getChar
    salir:
            mov ah,4ch ; numero de funcion para finalizar el programa
            xor al,al
            int 21h
    ;fin etiqueta

main endp
