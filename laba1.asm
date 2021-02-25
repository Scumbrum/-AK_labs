TITLE laba1

IDEAL ;Обьявление типа асемблера - tasm
Model small ;Обьявление типа модели памяти
STACK 256 ;Обьявление размера стека

DATASEG
exCode db 0
messageHello db "Hello World!", 10, 13 ;Создание рядка символов для вывода
messageAndrey db "Honcharenko", 10, 13
messageVlad db "Chorniy", 10, 13, '$'

CODESEG
Start:
	mov ax, @data ;Инициализация ds
	mov ds, ax
	
	mov dx, offset messageHello ;Запись ссылки на первый рядок в регистр dx
	mov ah, 09h ;Запись функции вывода в консоль в регистр ah
	int 21h ;Вызов функции DOS 09h
	
	mov ah, 01h ;Запись числа операции 01h в регистр ah
	int 21h ;Вызов функции 01h для ожидания нажатия кнопки
	
	mov ah, 4ch ;Запись числа операции выхода из программы
	mov al, [exCode] ;Получение кода выхода
	int 21h ;Вызов функции 4ch
	end Start
	
	