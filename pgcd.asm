.text

.globl __start

__start:
    jal main
    li $v0 10 #permet de sortir du programme
    syscall

main:
    subu $sp, $sp, 24 #création du cadre de la pile
    sw $ra, 16($sp)
    li $a0, 175 #init param 1
    li $a1, 45 #init param 2
    jal pgcd #appel pgcd
    move $a0, $v0
    li $v0, 1 #on met 1 dans v0 car si on charge 1 dans v0 et qu'on fait un syscall on affiche la valeur de a0
    syscall
    lw $ra, 16($sp)
    addu $sp, $sp, 24 #destruction du cadre de la pile
    jr $ra

pgcd:
    subu $sp, $sp, 24
    sw $ra, 16($sp)

    if:     bnez $a1, else #si différent de 0 on va au else
    then:   move $v0, $a0
            b endif
    else:   move $t0, $a1
            rem $a1, $a0, $a1 #on met dans le a1 le reste de la division de a0 par a1
            move $a0, $t0
            jal pgcd
    endif:  lw $ra, 16($sp)
            addu $sp, $sp, 24
            jr $ra 