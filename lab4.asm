 TITLE Vihidni kod 2.1
;------------------------------------------------------------------------------
;ЛР  №4, команда №3, ІТ-01
;------------------------------------------------------------------------------
;----------------I.ЗАГОЛОВОК ПРОГРАМИ------------------------
IDEAL
MODEL SMALL
STACK 16384
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
array2Db 	    DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		Dw  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '2', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
        		DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'
				DW  '3', '4', '8', '9', '7', '3', '0', '3', '9', '0', '7', '6', '1', '0', '8', '6'



exCode 	DB 0
CODESEG

;----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ-------------------
Start:	
M_Init
;Способи адресації - Базова адресація. Призначена для роботи з масивами 

xor si, si ; обнулюємо si, що використовується для адресації
call copy ; викликаємо процедуру copy для копіювання у сегмент даних
add si, 64 ; додаємо до si 64 для перенесення до початку наступного масиву
call copy ; повторюємо минулий пункт
add si, 64
call copy

call set_birthday ; додаємо до 3 ряду першого масиву день народження 

call to_stack ; додаємо 
	
;-------------очікування натискання клавіши---------------------
mov ah,01h
int 21h
;----------завершення роботи програми---------------------------
mov ah,4ch
mov al,[exCode]
int 21h 
;--------------------------------------------------------------

;---------------------Процедури-----------------------------------------
PROC set_birthday
	
	LEA BX, array2Db ; записуємо в bx посилання на початок масиву
	add BX, 64 ; зміщуємося на 3 строку
	mov[bx], '1' ; додаємо цифри дня народження
	mov[bx+2], '8'
	mov[bx+4], '1'
	mov[bx+6], '1'
	mov[bx+8], '2'
	mov[bx+10], '0'
	mov[bx+12], '0'
	mov[bx+14], '2'
	ret
ENDP set_birthday

PROC copy
		mov cx, 256 ; 16*16 - розмір масиву
        my_vaaptr:
            mov bx, [ds:si]   ; записуємо у bx значення          
            mov [ds:[si+220h]], bx    ; записуємо bx до зміщенного на 220h місця у сегменті даних 
            add si, 2              ; переходимо до наступного елемента масиву
            loop my_vaaptr
			
        ret
    ENDP copy
	
PROC to_stack
		lea si, [array2Db] ; записуэмо у si початок масиву
		mov ax, 16 ; записуємо до cx 16 - кількість повторів циклу
		mov cx, ax
	stack1:
		mov ax, [si] ; записуємо до ax елемент масиву
		add si, 2 ; додаємо 2 для обробки наступного елементу
		push ax ; додаємо елемент до стеку
		loop stack1

        ret
ENDP to_stack

	
	
end Start