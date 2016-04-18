jmp INPUT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


x1 dw 00h ;first number parts (80 bits total)
x2 dw 0000h
x3 dw 0000h
x4 dw 0000h
x5 dw 0000h

y1 dw 00h ;second number parts (80 bits total)
y2 dw 0000h
y3 dw 0000h
y4 dw 0000h
y5 dw 0000h

res1 dw 0000h ;res parts (144 bits)
res2 dw 0000h 
res3 dw 0000h 
res4 dw 0000h 
res5 dw 0000h 
res6 dw 0000h 
res7 dw 0000h 
res8 dw 0000h 
res9 dw 0000h 

msg db "Answer is: $"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INPUT: ;get inputs char by char

	mov ch,100

input1:

	mov cl,5
	mov ah,01h ;get char and store in al 
	int 21h 	
 
	cmp al,13 ; if it's enter, input1 is finished 
	je beforeinput2 ; proceed to second input
	
	sub al, '0' ; if it's a number, char is converted from ascii to number
	cmp al, 9
	ja isletter1 ;if it's letter, go to isletter
	jmp input1_shift ;get next char

isletter1:
	sub al, 7 ; subtract 7 more if it's a letter
 
input1_shift:

	mov bh,0 ;adjust to counter to see how many shifts to perform 
	call fixcounter

  	mov dx,x1[bx] ;reach the char to shift
  
  	call shift
  
	mov ch, 100 ;adjust the counter
  	call fixcounter
	dec cl ;decrement loop counter
  
  	mov [x1[bx]],dx
  	cmp cl,0 ;if no character left to shift, get next char
  	je input1

	jmp input1_shift ;continue shifting



beforeinput2: 
	call newline
	mov ch,100

input2: ;same process with input1

	mov cl,5
	mov ah,01h 
	int 21h 	
 
	cmp al,13 
	je multiply
	
	sub al, '0' 
	cmp al, 9
	ja isletter2 
	jmp input2_shift 

isletter2:
	sub al, 7 
 
input2_shift:

	mov bh,0
	call fixcounter

  	mov dx,y1[bx] 
  
  	call shift
  
	mov ch, 100
	call fixcounter
  	dec cl
  
  	mov [y1+bx],dx
  	cmp cl,0 
  	je input2

	jmp input2_shift 
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



MULTIPLY: ;multiply 4 hex digits with 4 hex digits at a time, then add carries to left  
	mov ax, [x5] ;with y5
	mov bx, [y5]
	mul bx
	add [res9], ax
	adc [res8], dx
	adc [res7], 0
	adc [res6], 0
	adc [res5], 0
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x4]
	mov bx, [y5]
	mul bx
	add [res8], ax
	adc [res7], dx
	adc [res6], 0
	adc [res5], 0
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x3]
	mov bx, [y5]
	mul bx
	add [res7], ax
	adc [res6], dx
	adc [res5], 0
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x2]
	mov bx, [y5]
	mul bx
	add [res6], ax
	adc [res5], dx
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x1]
	mov bx, [y5]
	mul bx
	add [res5], ax
	adc [res4], dx
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0 

	mov ax, [x5] ;with y4
	mov bx, [y4]
	mul bx
	add [res8], ax
	adc [res7], dx
	adc [res6], 0
	adc [res5], 0
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x4]
	mov bx, [y4]
	mul bx
	add [res7], ax
	adc [res6], dx
	adc [res5], 0
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x3]
	mov bx, [y4]
	mul bx
	add [res6], ax
	adc [res5], dx
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x2]
	mov bx, [y4]
	mul bx
	add [res5], ax
	adc [res4], dx
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0 
	
	mov ax, [x1]
	mov bx, [y4]
	mul bx
	add [res4], ax
	adc [res3], dx
	adc [res2], 0
	adc [res1], 0 

	mov ax, [x5] ;with y3
	mov bx, [y3]
	mul bx
	add [res7], ax
	adc [res6], dx
	adc [res5], 0
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x4]
	mov bx, [y3]
	mul bx
	add [res6], ax
	adc [res5], dx
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x3]
	mov bx, [y3]
	mul bx
	add [res5], ax
	adc [res4], dx
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0 
	
	mov ax, [x2]
	mov bx, [y3]
	mul bx
	add [res4], ax
	adc [res3], dx
	adc [res2], 0
	adc [res1], 0 

	mov ax, [x1]
	mov bx, [y3]
	mul bx
	add [res3], ax
	adc [res2], dx
	adc [res1], 0 

	mov ax, [x5] ; with y2
	mov bx, [y2]
	mul bx
	add [res6], ax
	adc [res5], dx
	adc [res4], 0
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0

	mov ax, [x4]
	mov bx, [y2]
	mul bx
	add [res5], ax
	adc [res4], dx
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0 
	
	mov ax, [x3]
	mov bx, [y2]
	mul bx
	add [res4], ax
	adc [res3], dx
	adc [res2], 0
	adc [res1], 0 

	mov ax, [x2]
	mov bx, [y2]
	mul bx
	add [res3], ax
	adc [res2], dx
	adc [res1], 0 

	mov ax, [x1]
	mov bx, [y2]
	mul bx
	add [res2], ax
	adc [res1], dx


	mov ax, [x5] ;with y1
	mov bx, [y1]
	mul bx
	add [res5], ax
	adc [res4], dx
 	adc [res3], 0
	adc [res2], 0
	adc [res1], 0 
	
	mov ax, [x4]
	mov bx, [y1]
	mul bx
	add [res4], ax
	adc [res3], dx
	adc [res2], 0
	adc [res1], 0 

	mov ax, [x3]
	mov bx, [y1]
	mul bx
	add [res3], ax
	adc [res2], dx
	adc [res1], 0 

	mov ax, [x2]
	mov bx, [y1]
	mul bx
	add [res2], ax
	adc [res1], dx

	mov ax, [x1]
	mov bx, [y1]
	mul bx
	add [res1], ax

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


OUTPUT: ;char by char output

	call newline

	mov ah, 09h
	mov dx, offset msg ;write "answer is:"
	int 21h      

	mov ax, [res1]
	ror ax, 0Ch
	call fixlast

	mov ax, [res1]
	ror ax, 08h
	call fixlast

	mov ax, [res1]
	ror ax, 04h
	call fixlast

	mov ax, [res1]
	call fixlast	

	mov ax, [res2]
	ror ax, 0Ch
	call fixlast

	mov ax, [res2]
	ror ax, 08h
	call fixlast

	mov ax, [res2]
	ror ax, 04h
	call fixlast

	mov ax, [res2]
	call fixlast


	mov ax, [res3]
	ror ax, 0Ch
	call fixlast


	mov ax, [res3]
	ror ax, 08h
	call fixlast


	mov ax, [res3]
	ror ax, 04h
	call fixlast

	mov ax, [res3]
	call fixlast	

	mov ax, [res4]
	ror ax, 0Ch
	call fixlast

	mov ax, [res4]
	ror ax, 08h
	call fixlast

	mov ax, [res4]
	ror ax, 04h
	call fixlast

	mov ax, [res4]
	call fixlast

	mov ax, [res5]
	ror ax, 0Ch
	call fixlast


	mov ax, [res5]
	ror ax, 08h
	call fixlast


	mov ax, [res5]
	ror ax, 04h
	call fixlast


	mov ax, [res5]
	call fixlast

	mov ax, [res6]
	ror ax, 0Ch
	call fixlast

	mov ax, [res6]
	ror ax, 08h
	call fixlast

	mov ax, [res6]
	ror ax, 04h
	call fixlast

	mov ax, [res6]
	call fixlast

	mov ax, [res7]
	ror ax, 0Ch
	call fixlast



	mov ax, [res7]
	ror ax, 08h
	call fixlast



	mov ax, [res7]
	ror ax, 04h
	call fixlast


	mov ax, [res7]
	call fixlast
	

	mov ax, [res8]
	ror ax, 0Ch
	call fixlast

	mov ax, [res8]
	ror ax, 08h
	call fixlast

	mov ax, [res8]
	ror ax, 04h
	call fixlast

	mov ax, [res8]
	call fixlast

	mov ax, [res9]
	ror ax, 0ch
	call fixlast


	mov ax, [res9]
	ror ax, 08h
	call fixlast


	mov ax, [res9]
	ror ax, 04h
	call fixlast


	mov ax, [res9]
	call fixlast
	int 20h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;used subroutines in program 

fixlast: 
	and ax, 000fh ;get the last character
	add ax, '0' ;if number, convert hex to ascii
 	cmp ax, '9' 
	if be call print ;print if number
	if a call letter ;if letter, convert to ascii then print

	ret
print: 
	mov dx, ax
	mov ah, 02h
	int 21h
	
	ret
letter:
	add ax, 7
	call print 
	ret
newline:
	mov ah, 2
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	ret
fixcounter:
	mov bl,cl  
	add bl,cl  
	sub bl,2
	ret
shift:
	mov bx, dx   
  	shr bx, 12
	shl dx, 4
 	add dl, al
  	mov al, bl
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

