.data
    msg_input:   .asciiz "Digite um numero maximo (1 < n < 10000): "
    msg_erro:    .asciiz "\nValor invalido!\n"
    espaco:      .asciiz " "

.text
.globl main

main:
loop_input:
    li      $v0, 4
    la      $a0, msg_input
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0

    ble     $s0, 1, entrada_invalida
    bge     $s0, 10000, entrada_invalida
    j       inicio_processamento

entrada_invalida:
    li      $v0, 4
    la      $a0, msg_erro
    syscall
    j       loop_input

inicio_processamento:
    li      $t0, 2

loop_principal:
    bgt     $t0, $s0, fim_programa
    
    li      $t1, 2

teste_primo:
    mul     $t2, $t1, $t1
    bgt     $t2, $t0, imprime_numero

    div     $t0, $t1
    mfhi    $t3
    beq     $t3, $zero, proximo_numero

    addi    $t1, $t1, 1
    j       teste_primo

imprime_numero:
    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 4
    la      $a0, espaco
    syscall

proximo_numero:
    addi    $t0, $t0, 1
    j       loop_principal

fim_programa:
    li      $v0, 10
    syscall