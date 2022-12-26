org 100h

jmp  mulai

msg : db "1. TAMBAH"0dh,0ah,"2. KALI"0dh,0ah,"3. KURANG"0dh,0ah,"4. BAGI"0dh,0ah,'$' 
msg2: db 0dh,0ah,"Masukkan angka pertama : $"
msg3: db 0dh,0ah,"Masukkan angka kedua : $"
msg4: db 0dh,0ah,"Error! $"
msg5: db 0dh,0ah,"Hasil : $"
msg6: db 0dh,0ah,'Terimakasih, keluar dan coba lagi!',0dh,0ah, '$'

mulai: mov ah,9
       mov dx, offset msg
       int 21h
       mov ah, 0
       int 16h
       cmp al,31h
       je Tambah
       cmp al,32h     
       je Kali
       cmp al,33h
       je Kurang
       cmp al,34h 
       je Bagi
       mov ah,09h
       mov dx, offset msg4
       int 21h
       mov ah,0
       int 16h
       jmp mulai
       
Tambah:  mov ah,09h
           mov dx, offset msg2
           int 21h
           mov cx,0
           call TambahNo
           push dx
           mov ah,9
           mov dx, offset msg3
           int 21h
           mov cx,0
           call TambahNo
           pop bx
           add dx,bx
           push dx
           mov ah,9
           mov dx, offset msg5
           int 21h
           mov cx,10000
           pop dx
           call Lihat
           jmp Keluar
           
TambahNo:   mov ah,0   
            int 16h
            mov dx,0
            mov bx,1
            cmp al,0dh
            je FormNo
            sub ax,30h
            call LihatNo
            mov ah,0
            push ax
            inc cx
            jmp TambahNo   
            
FormNo:     pop ax
            push dx
            mul bx
            pop dx
            add dx,ax
            mov ax,bx
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne FormNo
            ret
            
Lihat:  mov ax,dx
       mov dx,0
       div cx 
       call LihatNo
       mov bx,dx
       mov dx,0
       mov ax,cx
       mov cx,10
       div cx
       mov dx,bx
       mov cx,ax
       cmp ax,0
       jne Lihat
       ret
             
LihatNo: push ax
        push dx
        mov dx,ax
        add dl,30h
        mov ah,2
        int 21h
        pop dx
        pop ax
        ret
        
keluar: mov dx,offset msg6
       mov ah, 09h
       int 21h
       
       
       mov ah, 0
       int 16h
       
       ret
       
Kali: mov ah,09h
           mov dx, offset msg2
           int 21h
           mov cx,0
           call TambahNo
           push dx
           mov ah,9
           mov dx, offset msg3
           int 21h
           mov cx,0
           call TambahNo
           pop bx
           sub bx,dx
           mov dx,bx
           mov dx,ax
           push dx
           mov ah,9
           mov dx, offset msg5
           int 21h
           mov cx,10000
           pop dx
           call Lihat
           jmp Keluar
           
Bagi: mov ah,09h
           mov dx, offset msg2
           int 21h
           mov cx,0
           call TambahNo
           push dx
           mov ah,9
           mov dx, offset msg3
           int 21h
           mov cx,0
           call TambahNo
           pop bx
           mov ax,bx
           mov cx,dx
           mov dx,0
           mov bx,0
           mov bx,dx
           mov dx,ax
           div cx  
           mov bx,dx
           mov dx,ax
           push bx
           push dx
           mov ah,9
           mov dx, offset msg5
           int 21h
           mov cx,10000
           pop dx
           call Lihat 
           pop bx
           cmp bx,0
           je Keluar
           jmp Keluar
ret