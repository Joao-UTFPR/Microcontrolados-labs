; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>

;; -------------------------------------------------------------------------------
;; Função main()
Start  
; Comece o código aqui <======================================================
lab0
	LDR R0, =STRING1
	MOV R2, #0x03BF
	MOVT R2, #0x2000
LOOP1
	LDRB R1, [R0], #1
	CBZ R1, END1
	
	ADD R5, R1, R2
	
	LDRB R9,[R5]
	ADD R9,#1
	STR R9,[R5]
	B LOOP1
	
END1
	MOV R0,#0x0400
	MOVT R0,#0x2000
	MOV R2,#0
LOOP2
	LDRB R1,[R0],#1
	CMP R1, R2
	IT HS
		MOVHS R2,R1
	MOV R9,#0x045A
	MOVT R9,#0x2000
	CMP R0,R9
	IT LS
		BLS LOOP2
	MOV R5, #0x0500
	MOVT R5, #0x2000
	STRB R2,[R5]
	NOP
	
STRING1 DCB "AAAAAAAAAABBCCCDDDDEEEEEFFFFFFZZZZZZZZZZZZZZZZZZZZZ", 0
    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
