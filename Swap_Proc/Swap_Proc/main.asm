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

; procedure prototypes
		swapArray  PROTO, ptr_array: PTR DWORD, arraySize: DWORD
		PrintArray PROTO, ptr_array: PTR DWORD, arraySize: DWORD
.data
	newLine BYTE 0AH, 0DH, 0
	strEnter  BYTE "Enter 2 variables: ",0
	strBefore BYTE "Variables Before the Swap are :",0
	strAfter  BYTE "Variables after the swap are :",0
	var1 DWORD 0
	var2 DWORD 0
	array DWORD 2 dup(0)
.code
main PROC


	mov EDX, offset strEnter
	call writeString
	call readDec
	mov var1,EAX
	mov array,EAX

	mov EDX, offset strEnter
	call writeString
	call readDec
	mov var2,EAX
	mov [array + TYPE array],EAX

	mov EDX, offset strBefore
	call writeString
	INVOKE PrintArray, ADDR array, lengthof array

	INVOKE swapArray, ADDR array, lengthof array

	mov EDX, offset strafter
	call writeString
	INVOKE PrintArray, ADDR array, lengthof array

	;INVOKE swapArray, ADDR array, lengthof array
	;call swapVar
	;call printNewLine
	;call DumpRegs
	; mov EDX, offset strafter
	; call writeString
	; call Print_Var
	;INVOKE PrintArray, ADDR array, lengthof array

	exit
main ENDP
;***************************************************
printNewLine:
	mov edx, offset newLine
	call writeString
    ret	
;***************************************************
	swapArray PROC, ptr_array: PTR DWORD, arraySize: DWORD
			  
			  mov  ESI,ptr_array
			  mov  EAX,[ESI + TYPE array]
			  xchg EAX,[ESI]
			  mov  [ESI + TYPE array],EAX
			  call printNewLine

			  ret
	swapArray ENDP
;***************************************************
	swapVar:
		mov  EAX,var1
		xchg EAX,var2
		mov  var1,EAX
	ret
;***************************************************
	Print_Var:
		call printNewLine
		mov EAX,var1
		call writeDec
		call printNewLine

		mov EAX,var2
		call writeDec
		call printNewLine
	ret
;***************************************************
	PrintArray PROC,
		ptr_array: PTR DWORD, arraySize: DWORD
			
			call printNewLine
			mov ESI,ptr_array
			mov EAX,[ESI]
			call writeDec
			call printNewLine

			add ESI,TYPE array
			mov EAX,[ESI]
			call writeDec
			call printNewLine


				ret
	PrintArray ENDP
;***************************************************
END main
