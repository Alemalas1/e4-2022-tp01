/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    tst R2,#0xFF
    beq 0F
1: 
    ldr R3,[R0],#1
    str R3,[R1],#1
    subs R2,R2,#1
    tst  R2,#0xFF
    beq  1b 
0:
    bx  lr

    
endfun copiaMemoria




defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
    push {R4}
    mov R4,0x00

inicio: 
 
    ldrb R3,[R0],#1
    strb R3,[R1],#1
    add R4,#1
    cmp R4,[R2,#-1]
    bne  inicio 

    mov R0,0x00
    strb R0,[R1] 
    pop {R4}
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
inicio:
    cmp R1,#0
    beq fin
    mov R3,#97      //a
    mov R4,#65      //A
    ldrb R2,[R0]
0:
    cmp R2,R3
    beq 1f 
    add R3,#1 
    add R4,#1 
    cmp R3,#122
    beq 2f
    b   0b
1:
    strb R4,[R0],#1
    subs  R1,#1
    b    inicio
2:
    strb R2,[R0],#1
    subs  R1,#1
    b    inicio
fin:
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima

3:
    cmp R1,#0
    beq 4f
    mov R4,#97      //a
    mov R3,#65      //A
    ldrb R2,[R0]
0:
    cmp R2,R3
    beq 1f 
    add R3,#1 
    add R4,#1 
    cmp R3,#90
    beq 2f
    b   0b
1:
    strb R4,[R0],#1
    subs  R1,#1
    b    3b
2:
    strb R2,[R0],#1
    subs  R1,#1
    b    3b
4:
    bx lr
endfun minusculaEnLugar
