;================================================================================
;En la clase anterior pintamos pixeles usando la interrupción 10h servicio 0Ch; 
;podríamos pensar que estamos mandando la instrucción de pintar un pixel directamente 
;a la tarjeta de video. Sin embargo, lo que realmente estamos haciendo es escribir al 
;área de memoria de gráficos que inicia en A000:0000.
;
;Esta área consta de 320x200 bytes (64,000 bytes) y cada byte corresponde a un pixel. 
;Para cada byte del área de memoria de gráficos, la tarjeta de video lee el byte y usa 
;ese byte como índice en la paleta de colores para obtener el color del pixel.
;
;En la pantalla, el pixel superior-izquierdo (fila 0, columna 0) corresponde al byte en 
;la dirección A000:0000, el pixel superior-derecho (fila 0, columna 319) corresponde a A000:013F, 
;el primer pixel de la segunda fila (fila 1, columna 0) está mapeado a la dirección A000:0140. 
;En general, el pixel en la fila i, columna j corresponde a A000:(140h*i+j).
;
;La siguiente imagen muestra cómo interactuamos con el área de memoria y la paleta de colores; 
;la tarjeta de video usa esta información para desplegar el contenido de la pantalla.

;================================================================================
iniciarDs macro 
        mov ax,@data        ;pasamos la direccion de data a ax
        mov ds,ax           ;Inicializa DS
endm


limpiarCadena macro cadena
        push offset cadena
        call Clear_String
endm 

copiarCadena macro string1,string2
        push offset string2
        push offset string1
        call Copy_String
endm

copiarCadenaDir macro string1,string2
        push string2
        push string1
        call Copy_String
endm

compararCadena macro string1,string2
        push offset string2
        push offset string1
        call Compare_String
endm

compararCadenaDir macro string1,string2
        push string2
        push string1
        call Compare_String
endm

mWrite macro texto
    LOCAL cadena
    .data
        cadena byte texto,'$'
    .code
        push offset cadena
        call WriteString
endm


ModoVideo macro
    mov ah,00h
    mov al,13h
    int 10h
    mov ax, 0A000h
    mov es, ax  ; es = A000h (memoria de graficos).
endm

printChar macro carac
    push ax
    xor ah,ah
    mov al,carac  
    call PrintAl
    pop ax
endm


ModoTexto macro
    mov ah,00h
    mov al,03h
    int 10h
endm

mDelay macro constante
    push ax
    mov ax,constante
    call delay
    pop ax
endm


String_size macro cadena 
	push offset cadena 
    call Str_length 
endm

getChar macro
    mov ah,0dh
    int 21h
    mov ah,01h
    int 21h
endm

print macro cadena
    push offset cadena
    call WriteString
endm


printDir macro parameter1
    
    push parameter1
    call WriteString

endm 

printReg macro parameter1
        push ax     
        mov ax,parameter1
        call toAscii
        ;print corA
        print Num
        ;print corC
        pop ax
endm

Ascii macro parameter1
    push ax     
    mov ax,parameter1
    call toAscii
    pop ax
endm

AsciiTime macro parameter1
    push ax     
    mov ax,parameter1
    call toAsciiTime
    pop ax
endm

mSetCursor macro fila,columna
    push fila 
    push columna
    call SetCursor
endm


mRead macro cadena
        push dx
        push cx

        mov dx,offset   cadena
        mov cx,lengthof cadena
        call ReadString

        pop cx
        pop dx
endm

mReadDir macro tamanio,parameter1
        push dx
        push cx

        mov dx,parameter1
        mov cx,tamanio
        call ReadString

        pop cx
        pop dx

endm

println macro cadena
        print cadena
        print salt
endm


Ascii macro parameter1
        push ax     
        mov ax,parameter1
        call toAscii
        pop ax
endm

ADecimal macro parameter1
        push offset parameter1
        call toDecimal
endm

Numero macro parameter1
        push di
        mov di, parameter1
        call EsNumero
        pop di
endm

;=======================FILE

abrirF macro ruta,handle
	mov ah,3dh
	mov al,010b
	lea dx,ruta
	int 21h
	mov handle,ax
	;jc ErrorAbrir
endm


leerF macro numbytes,buffer,handle
	mov ah,3fh
	mov bx,handle
	mov cx,numbytes
	lea dx,buffer
	int 21h
	;jc ErrorLeer
endm


crearF macro ruta, handle
	mov ah,3ch
	mov cx,00h
	lea dx, ruta
	int 21h
	;jc ErrorCrear
	mov handle,ax
endm

escribirF macro handle, numBytes, buffer
	mov ah,40h
	mov bx,handle
	mov cx,numBytes
	lea dx,buffer
	int 21h
endm

macroNumTam macro
    LOCAL entrada, salida
    push si
    xor si,si
    entrada:
        cmp buffer[si],'$'
        je salida
        
    salida:
        pop si

endm

macroAnalizar macro
    LOCAL entrada,salida,estado1,estado2,estado3,estado4,estado5,estado6,estado7,estado8,estado8fin,estado8fin2
    xor si,si
    xor di,di


    entrada:
        verificarNum si
        cmp flag1,31h
        je estado1
        inc si
        jmp entrada

    estado1:
        inc si
        verificarNum si
        cmp flag1,31h
        je estado1
       
    estado2:
        cmp buffer[si],26h
        je salida
        inc si
        verificarNum si
        cmp flag1,31h
        je estado3
        
        jmp estado2

    estado3:
        ;codigo para almacenar el numero en NumTam-----------
        mov ah,0000h
        mov al, buffer[si]
        mov variable1[di],al
        inc di
        ;-----------------------------------------------------
        inc si
        verificarNum si
        cmp flag1,31h
        je estado3
        mov al, buffer[si]
        cmp al,95d
        je estado3
        ;limpiando di
        ;print variable1
        
        xor di,di
        conDec variable1
        printReg NumTam
        getChar

    estado4:
        inc si
        verificarLetra si
        cmp flag1,31h
        je estado5
        jmp estado4
        
    estado5:
        ;codigo para almacenar el nombre------------
        mov al, buffer[si]
        mov nombre[di],al
        inc di
        ;--------------------------------------------
        inc si
        verificarLetra si               ;si es una letra
        cmp flag1,31h
        je estado5
        verificarNum si                 ;si es un numero
        cmp flag1,31h
        je estado5
        mov al, buffer[si]              ;si es un guion
        cmp al,95
        je estado5  
        print nombre
        getChar

     

    estado6:   
        inc si
        cmp buffer[si],10d
        je estado7
        jmp estado6
    
    estado7:
        xor di,di
        mWrite <'[$'>
        mov cx,NumTam
        printReg cx
        mWrite <']$'>
        mov dx,NumTam
        inc si
    etilooop:
         mov cx,NumTam
        etiloop:
            mov al, buffer[si]
            mov bufferLectura[di],al
            inc si
            inc di
        loop etiloop
        estado8:
            cmp buffer[si],10d
            je estado8fin
            inc si
            jmp estado8
        estado8fin:
        inc si
        dec dx
        mov cx,dx
        cmp cx, 0
        jne etilooop
       

        print bufferLectura
        getChar
    xor di,di
    limpiararray bufferLectura
    limpiararray nombre
    limpiararray variable1
    jmp estado2

    salida:

endm

conDec macro arreglo
    mov tmp,di
    contarArray arreglo
    mov di,tmp
    
endm
verificarNum macro num
    LOCAL fin
    mov flag1,30h
    cmp buffer[num],30h
    jb fin
    cmp buffer[num],39h
    ja fin
    
    mov flag1,31h
    fin:
endm
verificarLetra macro num 
    LOCAL fin,minusculass
    mov flag1,30h
    
    cmp buffer[num],41h
    jb minusculass
    cmp buffer[num],5ah
    ja minusculass
    mov flag1,31h
    jmp fin
    minusculass:
        cmp buffer[num],61h
        jb fin
        cmp buffer[num],7ah
        ja fin
        mov flag1,31h

    fin:
endm
limpiararray macro arreglo
	LOCAL continuar, finalizar
    push di
    xor di,di
    continuar:
        cmp arreglo[di],24h
        je finalizar
		mov arreglo[di],24h
        inc di
        jmp continuar
    finalizar: 
      pop di

endm

contarArray macro arreglo  
	LOCAL continuar, finalizar,dosDigitos,tresDigitos, finDigitos
    
    xor di,di
    continuar:
        cmp arreglo[di],24h
        je finalizar
        inc di
        jmp continuar
    finalizar: 

    cmp di,2
    je dosDigitos
    cmp di,3
    je tresDigitos
    
    dosDigitos:
        mov ah, 0h
        mov al, arreglo[0]
        mov bl, 10d
        sub ax, 30h
        mul bl
        mov dh,00h
        mov dl,arreglo[1]
        sub dl,30h
        add ax, dx
        ;printReg ax
        mov NumTam,ax
        jmp finDigitos
    tresDigitos:
        mov ah, 00h
        mov al, arreglo[0]
        sub ax,30h
        mov bl, 100d
        mul bl

        mov dx,ax
        mov ah, 0h
        mov al, arreglo[1]
        mov bl, 10d
        sub ax, 30h
        mul bl
        add ax,dx
        mov dh,00h
        mov dl,arreglo[2]
        sub dl,30h
        add ax, dx
        ;sprintReg ax
        mov NumTam,ax
        jmp finDigitos
    finDigitos:

    
    
endm