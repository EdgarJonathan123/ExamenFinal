
main proc
    Inicio:
        IniciarDs
        xor di,di
        
        print enc1
        getChar
		abrirF rutaEntrada, handle 
		leerF SIZEOF buffer,buffer,handle
        ;print buffer
		
        print enc2
        getChar
        macroAnalizar
        
     ;   conDec moises ;convertDecimal
       
  
    salir:
        mov ah,4ch ; numero de funcion para finalizar el programa
        xor al,al
        int 21h
    ;fin etiqueta

main endp
