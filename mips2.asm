.data
string_menu: .asciiz "Seja bem vindo!\nPara iniciar o jogo, digite 1. Você pode sair no inicio de qualquer rodada digitando 0\n"
string_erro: .asciiz "\nOpção inválida! Digite novamente: "
string_fim: .asciiz "\nFim de jogo"
string_linha: .asciiz "\nCoordenada Linha: "
string_coluna: .asciiz "Coordenada Coluna: "
space_coluna: .space 3

.text

    #MENU
    li $v0, 4
    la $a0, string_menu
    syscall
    
OPCAO: 
    li $v0, 5
    syscall
    move $t0, $v0
    
    beq $t0, $zero, EXIT
    beq $t0, 1, GAME
    
    #mensagem de erro
    li $v0, 4
    la $a0, string_erro
    syscall
    j OPCAO

GAME:  
    jal coordenada_linha
    move $s0, $v0
    beq $s0, $zero, EXIT
    
    jal coordenada_coluna
    lw $s1, space_coluna
    
    jal numero_randomico
    move $s2, $v0
    jal teste
    j GAME
    
#fim de programa
EXIT: 
    li $v0, 4
    la $a0, string_fim
    syscall

    li $v0, 10
    syscall
    
    
coordenada_linha:
    li $v0, 4
    la $a0, string_linha
    syscall
            
    li $v0, 5
    syscall
    jr $ra
    
coordenada_coluna:
    li $v0, 4
    la $a0, string_coluna
    syscall
    
    li $v0, 8
    la $a0, space_coluna
    li $a1, 4
    syscall
    
    jr $ra

numero_randomico:
    li $a1, 100 #Here you set $a1 to the max bound.
    li $v0, 42  #generates the random number.
    syscall
    jr $ra

teste:
    ori $t1, $zero, 10
    ori $t2, $zero, 40
    slt $t3, $s2, $t1
    	bne $t3, $zero, BOMBA
    	slt $t3, $s2 $t2
    		bne $t3, $zero, BARCO
    		j MAR
    		
    BOMBA:
    	  jr $ra
    
    BARCO:
          jr $ra
          
    MAR:
          jr $ra
    	
