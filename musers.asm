mRegistrarUsuario macro 
	call RegistrarUsuario
endm

mshowUsers macro tamanio,arreglo
	push tamanio
	push offset arreglo
	call showUsers
endm

mBuscarUsuario macro tamanio,arreglo,nombre,contra
	push offset contra
	push offset nombre
	push tamanio
	push offset arreglo

	call buscarUsuario

endm

mIngresaUsuario macro 
	call ingresaUsuario
endm