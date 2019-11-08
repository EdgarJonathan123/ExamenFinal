
main proc
    Inicio:
        IniciarDs
        print msm0
    ;Fin etiqueta

    MenuPrincipal:
		;--------MOSTRANDO EL MENU PRINCIPAL--------------------------
		print msm8

		print salt
		;--------OBTENIENDO EL NUMERO ESCOGIDO------------------------
		getChar
		cmp al,'1'; COMPARO CON EL ASCII DEL NUMERO 1 QUE ES 49 Y EN HEXA `31H
		je IngresoUsuario
		cmp al,'2'
		je regUsuario
		cmp al,'3'
		je IngresoAdmin
		cmp al,'4'
		je Salir
		jmp MenuPrincipal
	;fin etiqueta



	IngresoUsuario:
		mIngresaUsuario
		cmp bx,1
		je juego
		jmp MenuPrincipal
	;fin etiqueta
	regUsuario:
		mRegistrarUsuario
		jmp MenuPrincipal
	;fin etiqueta
	IngresoAdmin:
		mshowUsers ptrUser,arrayuser
		getchar
		jmp MenuPrincipal
	;fin etiqueta


	juego:
		mov time[0],0
		mSetup
		mGame
		
		;--Esto se Ejecuta despues de terminar el juegos
		;se puede inicial el juego de nuevo
		ModoTexto
		mov si, offset arrayuser
        mov ax, ptrUser
        mov bx, type usuario
        mul bx
        add si,ax

        lea bx,(usuario ptr[si]).nombre
        mov ax,offset user
        copiarCadenaDir bx,ax



		jmp MenuPrincipal
		
	;fin etiqueta


    salir:
            mov ah,4ch ; numero de funcion para finalizar el programa
            xor al,al
            int 21h
    ;fin etiqueta

main endp
