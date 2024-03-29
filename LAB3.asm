 TITLE Vihidni kod 2.1
;------------------------------------------------------------------------------
;ЛР  №3, команда №3, ІТ-01
;------------------------------------------------------------------------------
;----------------I.ЗАГОЛОВОК ПРОГРАМИ------------------------
IDEAL
MODEL SMALL
STACK 512
;-----------------------II.МАКРОСИ--------------------------------------
; Складний макрос для ініціалізації
MACRO M_Init		; Початок макросу 
	mov ax,@data	; @data ідентифікатор, що створюються директивою model
	mov ds, ax	; Завантаження початку сегменту даних в регістр ds
	mov es, ax	; Завантаження початку сегменту даних в регістр es
ENDM M_Init		

;--------------------III.ПОЧАТОК СЕГМЕНТУ ДАНИХ--------------
DATASEG

;Оголошення двовимірного експериментального масиву 16х16
array2Db 	    db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
        		db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46
				db  46, 46,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46 ,46

; Рядки повідомлень

msg_asm  DB  "Assembler AUTS $"
msg_vb     DB  "Variable in byte"
message db "Hello World!",10,13,'$';Рядок символів для виводу на екран

exCode 	DB 0
CODESEG

;----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ-------------------
Start:	
M_Init
;Способи адресації - Базова адресація. Призначена для роботи з масивами 



LEA BX, array2Db ; помістити в BX адресу початку масиву array2Db.

add bx, 0fh		 ; bx=bx+16 - на передостанній элемент в 0 рядку (правий верхній кут)

call fill_diag
LEA BX, array2Db ; помістити в BX адресу початку масиву array2Db.
add bx, 31		 ; на останній елемент в другому рядку

call fill_variant

mov dx, offset message

mov ah,09h ; 9h - команда виводу на консоль рядка
int 21h		; Виклик функції DOS 9h
	
	
-------------;очікування натискання клавіши---------------------
mov ah,01h
int 21h
----------;завершення роботи програми---------------------------
mov ah,4ch
mov al,[exCode]
int 21h 
;--------------------------------------------------------------

;---------------------Процедури-----------------------------------------
PROC fill_diag
	mov CL, 5     		; 5*3 = 15			
; ініціалізація регістрів ініціалами імен членів команди		
	mov al, 'I'				; Iryna
	mov ah, 'V'				; Vlad
	mov dl, 'A'				; Andriy			
	my_vptr:	
		mov [bx], al	; записати І в ячейку памяті, на котру вказує регістр bx (0 трока, остання позиція)
		mov [bx+15], ah	; записати V в ячейку, що відповідає діагоналі масиву 16х16 
		mov [bx+30], dl	; записати А в ячейку
		add bx, 45

		LOOP my_vptr        ;повторити цикл
		mov [bx], al	; 16тий рядок	
; очистити
	mov cx, 0 
	ret
ENDP fill_diag
	 
PROC fill_variant
	mov CL, 15   				
	mov AL, '3'  				
	my_varptr:			
		mov [bx], al		
		add bx, 16			  ; bx= bx+16
		LOOP my_varptr        ;повторити цикл
	mov cx, 0 
	ret
ENDP fill_variant
	
end Start