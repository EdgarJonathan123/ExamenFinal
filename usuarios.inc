include musers.asm

.data
;====================Ini Var Globales=============================

;====================Fin Var Globales=============================

.code
;====================Gestion Usuarios=============================



RegistrarUsuario proc
        ;--------------------------------------------------------------------
        ;   Recibe:      Nada                                                 
        ;   Devuelve:    Nada                                                
        ;                                                                    
        ;   Comentarios: Registra Usuarios                                  
        ;--------------------------------------------------------------------

        ;Ini Subrutina prologo
            pusha
        ;Fin Subrutina prologo


        ;Ini Codigo

            mov si, offset arrayuser

            mov ax, ptrUser
            mov bx, type usuario
            mul bx

            add si,ax

            println space
            mWrite <'****Ingrese***',13,10>

            mWrite <9,'Nombre Usuario:'>
            lea bx,(usuario ptr[si]).nombre
            mReadDir SIZEOF usuario.nombre,bx

            mWrite <9,'Contrasena:'>
            lea bx,(usuario ptr[si]).contra
            mReadDir SIZEOF Usuario.contra,bx
             
            inc ptrUser
        ;Fin Codigo


        ;ini Subrutina epilogo
            FIN:
                popa
                ret 
        ;fin Subrutina epilogo
RegistrarUsuario endp

showUsers proc
        ;--------------------------------------------------------------------
        ;   Recibe:      [bp+4] Arreglo de Usuarios   
        ;                [bp+6] tamnio de arreglo                                           
        ;   Devuelve:    Nada                                                
        ;                                                                    
        ;   Comentarios: Muestra los Usuarios en consola                                
        ;--------------------------------------------------------------------

        ;Ini Subrutina prologo
            push bp
            mov bp,sp
            pusha
        ;Fin Subrutina prologo


        ;Ini Codigo
            mov si,[bp+4]           ;si = offset arrayuser
            mov cx,[bp+6]           ;contador del ciclo

            

            L1:
                lea bx,(usuario ptr[si]).nombre
                printDir bx

                print tab

                lea bx,(usuario ptr[si]).contra
                printDir bx

                print tab

                lea bx,(usuario ptr[si]).punteo
                Ascii [bx]
                print Num

                print tab

                lea bx,(usuario ptr[si]).tiempo
                Ascii [bx]
                print Num


                println space

                add si,type usuario  
                loop L1
            ;fin etiqueta

        ;Fin Codigo


        ;ini Subrutina epilogo
            FIN:
                popa
                mov sp,bp
                pop bp
                ret 4
        ;fin Subrutina epilogo
showUsers endp


buscarUsuario proc
        ;--------------------------------------------------------------------
        ;   Recibe:      [bp+4] Arreglo de Usuarios   
        ;                [bp+6] tamnio de arreglo   
        ;                [bp+8]  nombre a buscar
        ;                [bp+10] contra a buscar                                    
        ;   Devuelve:    BX= usuario encontrado                                                
        ;                                                                    
        ;   Comentarios: guarda los datos en variables globales en caso 
        ;                se encuentra el usuario                              
        ;--------------------------------------------------------------------

        ;Ini Subrutina prologo
            push bp
            mov bp,sp
            push si
            push cx
            push ax
        ;Fin Subrutina prologo


        ;Ini Codigo
            mov si,[bp+4]           ;si = offset arrayuser
            mov cx,[bp+6]           ;contador del ciclo

            

            L1:
                lea bx,(usuario ptr[si]).nombre

                compararCadenaDir bx,[bp+8]
                je verficaContra
                jmp adelante

                verficaContra:
                    lea bx,(usuario ptr[si]).contra
                    compararCadenaDir bx,[bp+10]
                    je encontrado
                    jmp adelante
                ;fin etiqueta

                adelante:
                add si,type usuario  
                cmp cx,0
                je NoEcontrado
                dec cx
                jmp L1
            ;fin etiqueta

            NoEcontrado:
                mWrite<9,'!!!Usuario o Contrasena no econtrados!!',13,10>
                jmp FIN
            ;fin etiqueta


            Encontrado:
                lea bx,(usuario ptr[si]).nombre
                mov ax,offset user

                copiarCadenaDir bx,ax

                mov bx,1        ;Usuario Encontrado

                JMP FIN
            ;fin etiqueta
        ;Fin Codigo


        ;ini Subrutina epilogo
            FIN:
                pop ax
                pop cx
                pop si
                mov sp,bp
                pop bp
                ret 8
        ;fin Subrutina epilogo
buscarUsuario endp

ingresaUsuario proc
        ;--------------------------------------------------------------------
        ;   Recibe:      Nada                                  
        ;   Devuelve:    Nad                                              
        ;                                                                    
        ;   Comentarios: verifica si el usuario esta registrado 
        ;                para poder jugar                              
        ;--------------------------------------------------------------------

        ;Ini Subrutina prologo
            push bp
            mov bp,sp
        ;Fin Subrutina prologo


        ;Ini Codigo
            mWrite <'****Ingrese***',13,10>
            mWrite <9,'Nombre Usuario:'>
            mRead auxNombre
            mWrite <9,'Contrasena:'>
            mRead auxContra

            mBuscarUsuario  ptrUser,arrayuser,auxNombre,auxContra


        ;Fin Codigo


        ;ini Subrutina epilogo
            FIN:
                mov sp,bp
                pop bp
                ret 
        ;fin Subrutina epilogo
ingresaUsuario endp



;====================Gestion Usuarios=============================

