.model small
.stack 100h

.data
    nr dw 0
    p dw 1 
    baza db 0
    ct db 0
    msg1 db 13,10, "Introdu primul numar (intre 0 si 65,535) : $"
    msg2 db 13,10, "Introdu baza in care sa fie schimbat numarul (2 .. 36)  : $"
    msg3 db 13,10, "Baza introdusa este gresita! $"

.code

main:
    MOV AX, @DATA
    MOV DS, AX

    ;Afisam msg1
    MOV ah, 09h            
    MOV dx, offset msg1             
    INT 21h

CitireNr:
    ;Construirea primului numar UltimulCaracter cu UltimulCaracter
    MOV ah, 01h      ;citeste un caracter de la tastatura si il baga in Al          
    INT 21h
    XOR ah, ah
    CMP al, 0Dh     ;enter
    JE ConstruireNr                  
    JMP IntrareStivaNr

IntrareStivaNr:
    ;Introduce cifrele de la tastatura in stiva
    INC ct
    SUB al, '0'
    PUSH AX
    JMP CitireNr

ConstruireNr:
    ;AX*p
    POP AX                                      
    MOV CX, p                       
    MUL CX                                        

    ;nr = nr + (AX*P)                   
    ADD nr, AX

    DEC ct                               
    CMP ct, 0   
    JE Mesaj2
    JMP UpdateP

UpdateP:
    ;P = P * 10
    MOV AX, p
    MOV CX, 10 
    MUL CX
    MOV p, AX
    JMP ConstruireNr
    
Mesaj2:
    ;Reinitializare ct si p
    MOV Al, 0
    MOV ct, Al
    MOV AX, 1
    MOV p, AX

    ;Afisam msg1
    MOV ah,09h            
    MOV dx, offset msg2             
    INT 21h

CitireBaza:
    ;Construirea primului numar UltimulCaracter cu UltimulCaracter
    MOV ah,01h      ;citeste un caracter de la tastatura si il baga in Al          
    INT 21h
    XOR ah, ah
    CMP al, 0Dh                 
    JE ConstruireBaza                  
    JMP IntrareStivaBaza

IntrareStivaBaza:
    ;Introduce cifrele de la tastatura in stiva
    INC ct
    SUB al, '0'
    PUSH AX
    JMP CitireBaza

ConstruireBaza:
    ;AX*p
    POP AX
    MOV CX, p                                                            
    MUL CX                                        

    ;nr = nr + (AX*P)                   
    ADD baza, Al

    ;P = P * 10
    MOV AX, p
    MOV CX, 10 
    MUL CX
    MOV p, AX
    DEC ct                               
    CMP ct, 0   
    JE AflatBaza
    JMP ConstruireBaza

AflatBaza:
    ;Ct = 0
    MOV ah, 0
    MOV ct, ah

    CMP baza, 2
    JB BazaGresita

    CMP baza, 36
    JA BazaGresita

    JMP OglindireStiva

BazaGresita:
    ;Afisam msg3
    MOV ah,09h            
    MOV dx, offset msg3             
    INT 21h

JMP TerminareProgram

OglindireStiva:
    INC ct
    MOV AX, nr
    XOR Ch, Ch
    XOR DX, DX
    MOV Cl, Baza
    DIV CX                      ;catul -> AX, restul -> DX
    MOV nr, AX
    PUSH DX
    CMP nr, 0
    JE AfisareNr
    JMP OglindireStiva

AfisareNr:
    POP AX
    CMP AX, 9
    JA Litera
    ADD al, '0'
    MOV dl, al
    MOV ah, 02h             
    INT 21h
    DEC ct
    CMP ct, 0
    JE TerminareProgram
    JMP AfisareNr

Litera:
    ADD al, 39              ;Diferenta Ascii dintre ; si a
    ADD al, '0'
    MOV dl, al
    MOV ah, 02h             
    INT 21h
    DEC ct
    CMP ct, 0
    JE TerminareProgram
    JMP AfisareNr

TerminareProgram:          
    MOV ah,4Ch             ;funcția pentru terminarea programului
    INT 21h

end main
