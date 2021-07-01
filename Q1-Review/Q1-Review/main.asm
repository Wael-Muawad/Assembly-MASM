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

	readarr  PROTO, ar: PTR DWORD, arraySize: DWORD
	countarr PROTO, ar: PTR DWORD, arraySize: DWORD
.data
	newLine byte 0AH, 0DH, 0 
	arr DWORD 10 dup(?)
	msgOdd  BYTE  "The Count Of Odd numbers is: ",0
	msgEven BYTE "The Count Of Even numbers is: ",0
	Prompt  BYTE "Please enter a number: ",0
	countOdd  DWORD 0
	countEven DWORD 0
.code
main PROC

		INVOKE readarr, ADDR arr, lengthof arr
		INVOKE countarr, ADDR arr, lengthof arr
		call print

	exit
main ENDP
;***************************************************	
	printNewLine:
	mov edx, offset newLine
	call writeString
    ret
;***************************************************
readarr PROC, ar: PTR DWORD, arraySize: DWORD

	mov ecx, arraySize
	mov esi, ar
	mov edx, offset prompt
	top : 
		call writeString
		call ReadDec
		mov [ESI], EAX
		add ESI, TYPE ar
	Loop top
	call printNewLine
	ret
readarr ENDP
;***************************************************
countarr PROC, ar: PTR DWORD, arraySize: DWORD
	
	mov ecx, arraySize
	mov esi, ar

	mov EDX,0
	mov EBX,2
	top : 
		mov EAX, [ESI]
		div EBX
		cmp EDX,0
	JNE odd
		inc countEven
	jmp next
	odd:
		inc countOdd	
	next:
		add ESI, TYPE ar
	Loop top

		ret
countarr ENDP
;***************************************************
	print:
		mov EDX,offset msgOdd
		mov EAX,countOdd
		call writeString
		call writeDec

		call printNewLine
		call printNewLine

		mov EDX,offset msgEven
		mov EAX,countEven
		call writeString
		call writeDec

		call printNewLine
		call printNewLine
	ret
;***************************************************
END main
