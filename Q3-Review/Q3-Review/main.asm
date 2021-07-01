TITLE Program Template           (Template.asm)

;***************************************************
; Program Name:
; Program Description:
; Author:
; Version:
; Date:
; Other Information:
;***************************************************

INCLUDE Irvine32.inc

	readTwo  PROTO, n1: PTR DWORD, n2: PTR DWORD
	printTwo PROTO, n1: PTR DWORD, n2: PTR DWORD

.data
		newLine byte 0AH, 0DH, 0 
		msgread   BYTE "Please enter a number: ", 0
		msgprint  BYTE "The numbers are: ", 0
		msgspace  BYTE ", ", 0
		num1 DWORD 0
		num2 DWORD 0
.code
main PROC

		INVOKE readTwo, ADDR num1, ADDR num2
		INVOKE printTwo, ADDR num1, ADDR num2		

	exit
main ENDP
;***************************************************	
	printNewLine:
	mov edx, offset newLine
	call writeString
    ret
;***************************************************
readTwo PROC, n1: PTR DWORD, n2: PTR DWORD


		mov edx, offset msgread
		call writeString
		call ReadDec

		mov EBX,n1
		mov [EBX], EAX

		mov edx, offset msgread
		call writeString
		call ReadDec

		mov EBX,n2
		mov [EBX], EAX
		
		call printNewLine
	ret
readTwo ENDP
;***************************************************
printTwo PROC, n1: PTR DWORD, n2: PTR DWORD
		
		mov EDX,offset msgprint
		call writeString

		mov EBX,n1
		mov EAX,[EBX]
		call writeDec
		
		mov EDX,offset msgspace
		call writeString

		mov EBX,n2
		mov EAX,[EBX]
		call writeDec


		call printNewLine
		 ret
printTwo ENDP
;***************************************************

END main
