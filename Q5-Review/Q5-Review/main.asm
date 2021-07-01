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
	printAVG PROTO, n1: DWORD, n2: DWORD, avg1: PTR DWORD

.data
		newLine byte 0AH, 0DH, 0 
		msgread   BYTE "Please enter a number: ", 0
		msgprint  BYTE "The average is: ", 0
		num1 DWORD 0
		num2 DWORD 0
		avg  DWORD 0
.code
main PROC

		INVOKE readTwo, ADDR num1, ADDR num2
		INVOKE printAVG, num1, num2, ADDR avg		
		
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
printAVG PROC, n1: DWORD, n2: DWORD, avg1: PTR DWORD
		
		mov EAX,n1
		add EAX,n2
		mov EBX,avg1

		mov EDX,0
		mov ECX,2
		div ECX

		mov EDX,offset msgprint
		call writeString
		call writeDec

		mov [EBX],EAX
		 call printNewLine
		 ret
printAVG ENDP
;***************************************************

END main
