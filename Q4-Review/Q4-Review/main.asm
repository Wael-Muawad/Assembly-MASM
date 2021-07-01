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
	sumTwo   PROTO, n1: PTR DWORD, n2: PTR DWORD, sum1: PTR DWORD

.data
		newLine byte 0AH, 0DH, 0 
		msgread   BYTE "Please enter a number: ", 0
		msgprint  BYTE "The sum is: ", 0
		num1 DWORD 0
		num2 DWORD 0
		sum  DWORD 0
.code
main PROC

		INVOKE readTwo, ADDR num1, ADDR num2
		INVOKE sumTwo, ADDR num1, ADDR num2, ADDR sum	

		mov EDX,offset msgprint
		call writeString
		mov EAX,sum
		call writeDec
		call printNewLine

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
sumTwo   PROC, n1: PTR DWORD, n2: PTR DWORD, sum1: PTR DWORD
		
		mov EBX,n1
		mov EAX,[EBX]

		mov EBX,sum
		mov [sum],EAX

		mov EBX,n2
		mov EAX,[EBX]

		mov EBX,sum
		add [sum],EAX

	   call printNewLine
	   ret
sumTwo ENDP
;***************************************************

END main
