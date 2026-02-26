# Laboratorio: Estructura de Computadores - OPTIMIZADO
# Objetivo: Minimizar paradas (stalls) reordenando instrucciones.

.data
    vector_x: .word 1, 2, 3, 4, 5, 6, 7, 8
    vector_y: .space 32
    const_a:  .word 3
    const_b:  .word 5
    tamano:   .word 8

.text
.globl main

main:
    la $s0, vector_x      
    la $s1, vector_y      
    lw $t0, const_a       
    lw $t1, const_b       
    lw $t2, tamano        
    li $t3, 0             

loop:
    beq $t3, $t2, fin     
    
    sll $t4, $t3, 2       
    addu $t5, $s0, $t4    
    
    # --- CARGA DE DATO ---
    lw $t6, 0($t5)        
    
    # --- INSTRUCCIONES MOVIDAS PARA EVITAR STALL ---
    # Calculamos la dirección de destino de Y mientras esperamos que termine el lw
    addu $t9, $s1, $t4    
    # Incrementamos el índice i anticipadamente
    addi $t3, $t3, 1      

    # --- OPERACIÓN ARITMÉTICA (Ya no hay stall de Load-Use) ---
    mul $t7, $t6, $t0     
    addu $t8, $t7, $t1    
    
    # --- ALMACENAMIENTO ---
    sw $t8, 0($t9)        
    
    j loop

fin:
    li $v0, 10            
    syscall