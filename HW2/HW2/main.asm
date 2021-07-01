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
.data
    CR equ 0DH
    LF equ 0AH
	newLine byte CR,LF,0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	salaries_prompt BYTE "Please enter the salaries of 10 employees ",0
	sumString BYTE "The Sum Is: ",0
	avgString BYTE "The Avarge Is: ",0
	countString BYTE "The count of salaries greater than avarage is: ",0
	maxString   BYTE "The maximum salary is: ",0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	array_of_sal DWORD 10 DUP(?)
	sum DWORD 0
	avg DWORD 0
	max DWORD 0
	count DWORD 0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.code
	ReadArray PROTO,
		 		  ptr_Array:PTR DWORD,
				  Array_Size:DWORD
	Print_Array PROTO,
					 ptr_Array:PTR DWORD,
				     Array_Size:DWORD
	Find_Sum PROTO,
				  ptr_Array: PTR DWORD,
				  Array_Size: DWORD
	Find_AVG PROTO,
				  ptr_Array: PTR DWORD,
				  Array_Size: DWORD
	Count_and_Max PROTO,
				  ptr_Array: PTR DWORD,
				  Array_Size: DWORD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main PROC
	
   INVOKE ReadArray, ADDR array_of_sal, lengthof array_of_sal
   INVOKE Print_Array, ADDR array_of_sal, lengthof array_of_sal
   INVOKE Find_Sum, ADDR array_of_sal , lengthof array_of_sal
   INVOKE Find_AVG, ADDR array_of_sal , lengthof array_of_sal
   INVOKE Count_and_Max, ADDR array_of_sal, lengthof array_of_sal
			
		
	call DumpRegs
	exit
main ENDP

printNewLine:
	mov edx, offset newLine
	call writeString
	ret		; (insert additional procedures here)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ReadArray PROC,
		   ptr_Array: PTR DWORD,
		   Array_Size: DWORD

		   mov  edx, OFFSET salaries_prompt
		   call WriteString
		   call printNewLine

		   mov ECX,Array_Size
		   mov ESI,ptr_Array
		L1:
		   call ReadDec
		   mov [ESI],EAX
		   add ESI,TYPE array_of_sal
		loop L1
		call printNewLine

		ret
ReadArray ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Print_Array PROC,
				ptr_Array:PTR DWORD,
				Array_Size:DWORD


				mov ECX,Array_Size
				mov ESI,ptr_Array
			L2:
				mov EAX,[ESI]
				call WriteDec
				add ESI,TYPE array_of_sal
				mov  AL,' '
				call WriteChar
			loop L2
			call printNewLine

			ret
Print_Array ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Find_Sum PROC,
			  ptr_Array: PTR DWORD,
			  Array_Size: DWORD


			  mov ECX,Array_Size
			  mov ESI,ptr_Array
			  mov EAX,0
  		  L2: 
			  add EAX,[ESI]
			  add ESI,TYPE array_of_sal
   		  loop L2
			  mov sum,EAX
			  call printNewLine
			  mov  edx, OFFSET sumString
			  call WriteString
			  call WriteDec
			  call printNewLine
			  call printNewLine

		 ret
Find_Sum ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Find_AVG PROC,
			  ptr_Array: PTR DWORD,
			  Array_Size: DWORD

			 mov  EDX,0
			 mov  ECX,Array_Size
		 	 div  ECX
			 mov  EBX,EDX
			 mov  avg,EAX
			 mov  edx, OFFSET avgString
			 call WriteString
			 call WriteDec
			 mov  AL,'.'
			 call WriteChar
			 mov  EAX,EBX
			 call WriteDec
			 call printNewLine
			 call printNewLine

		 ret
Find_AVG ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Count_and_Max PROC,
				  ptr_Array: PTR DWORD,
				  Array_Size: DWORD


					 mov ECX,Array_Size
					 mov ESI, ptr_Array
					 mov EDI,0					 ;EDI consedred as counter 
			Lbl_loop:
					 mov EDX,[ESI]			     ;EDX has array values 
					 add ESI,TYPE array_of_sal
					 cmp EDX,max
			JB  Lbl_count
					 mov max,EDX
			Lbl_count:
					 cmp EDX,avg
			JBE Lbl_false
					 inc EDI
			Lbl_false: 
					 loop Lbl_loop
					 mov count,EDI			     ;store the count from EDI
		 
					mov edx, OFFSET countString
					call WriteString
					mov  EAX,count
					call WriteDec
					call printNewLine
					call printNewLine

					mov edx, OFFSET maxString
					call WriteString
					mov  EAX,max
					call WriteDec
					call printNewLine
					call printNewLine
					ret
Count_and_Max ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
END main