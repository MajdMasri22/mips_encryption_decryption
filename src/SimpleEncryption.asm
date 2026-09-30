.data
shift_value:		.asciiz 	"The shift value is: \n"
choose_method:		.asciiz 	"Please choose 'e' for encryption or 'd' for decryption: \n"
EorD:			.space 		2	#2 byte
new_line:		.asciiz 	"\n"	#for new line
text_file_msg:		.asciiz 	"please input the name of the plain text file \n"
cipher_file_msg:	.asciiz 	"please input the name of the cipher text file \n"
			.align 2
read_fileName:		.space		48
text_fileName:		.asciiz 	"text.txt"
cipher_fileName:	.asciiz 	"cipher.txt"
text_file:		.asciiz 	"/Users/majdmasri/text.txt"
file_inputs:		.space 		1024
cipher_file:		.asciiz 	"/Users/majdmasri/cipher.txt"

.text 
  .globl main
    main:
      la $a0,choose_method	#load choose method to a0
      li $v0,4			#print choose method message
      syscall 
      li $v0,8			#read if encryption or decryption
      la $a0,EorD		#load byte space into address of a0
      li $a1,2			#assign the byte space for a string
      move $t0,$a0		#move entered char to t0
      syscall
      li $t1,'e'		#put e in t1(t1=e)
      lbu $t2,0($t0)		#value of t0 in t2
      bne  $t2,$t1,decryption	#if input != e go to decryption
      j encryption		#jump to encryption
    
      
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall 
       
      encryption:
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall
      la $a0,text_file_msg	#load plain text to a0
      li $v0,4			#print plain text
      syscall
      li $v0,8			#read plaint text file
      la $a0,read_fileName	#load byte space into address of a0
      li $a1,48			#assign the byte space for a string
      syscall
      
        
      #ReadFile
      la $a0,text_file		#load text file to a0
      li $v0,13			#open text file
      li $a1,0			#file flag = 0 (read)
      syscall 
      move $t0,$v0		#move file directory to t0
      li $v0,14			#read from file
      move $a0,$t0		#move directory to a0
      la $a1,file_inputs	#load byte space into address of a1
      la $a2,1024		#assign the byte space for the file inputs
      syscall 
      la $a0,file_inputs	#read from a file then print
      li $v0,4
      syscall
      li $v0,16			#close file
      move $a0,$t0
      syscall
      
      #Remove non Alpha char    
      li $s0,0      		#i = 0
      li $t0,1024     		#max for i to reach
      la $a0,file_inputs	#load address of file inputs to a0
      jal RemoveNonAlpha	
      la $a0,file_inputs	#load address of file inputs after removing non alpha to a0
      li $v0,4			#print string
      syscall 
      
      
      #change upper to lower
      li $s0,0      		#i = 0
      li $t0,1024     		#max for i to reach
      la $a0,file_inputs	#load address of file inputs to a0
      jal UppertoLower
      la $a0,file_inputs	#load address of file inputs after changing upper to lower to a0
      li $v0,4			#print string
      syscall 
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall 
      
      
      #finding the shift value
      li $s0,0      		#i = 0
      li $t0,1024     		#max for i to reach
      la $a0,file_inputs	#load address of file inputs to a0
      jal ShiftValue
      la $a0,shift_value	#load message of shift value to a0
      li $v0,4			#print message
      syscall 
      move $a0,$t9		#(t0=shiftvalue) move shift value to a0
      li $v0,1			#print shift value (print integer)
      move $t9,$a0		
      syscall
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall 
      
      
      #Shift file inputs(string)
      li $s0,0      		#i = 0
      li $t0,1024     		#max for i to reach
      la $a0,file_inputs	#load address of file inputs to a0
      move $t1,$t9		#move shift value to t1
      jal ShiftString
      la $a0,file_inputs	#address of shifted string
      li $v0,4			#print shifted string
      syscall 
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall
      
      
      la $a0,cipher_file_msg	#load cipher text to a0
      li $v0,4			#print cipher text
      syscall
      li $v0,8			#read cipher text file
      la $a0,read_fileName	#load byte space into address of a0
      li $a1,48			#assign the byte space for a string
      syscall
      
      
      #WritetoFile
      la $a0,cipher_file	#load cipher file to a0
      li $v0,13			#open cipher file
      li $a1,1			#file flag = 1 (write)
      syscall 
      move $t0,$v0		#move file directory to t0
      li $v0,15			#write to file
      move $a0,$t0		#move directory to a0
      la $a1,file_inputs
      la $a2,1024
      syscall
      li $v0,16			#close file
      move $a0,$t0 
      syscall 
      
          
      next:
      li $v0,10			#exit
      syscall 



    decryption:
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall 
      la $a0,cipher_file_msg	#load cipher text to a0
      li $v0,4			#load cipher text to a0
      syscall
      li $v0,8			#read cipher text file
      la $a0,read_fileName	#load byte space into address of a0
      li $a1,48			#assign the byte space for a string
      syscall
      
      
      #ReadFile
      la $a0,cipher_file	#load cipher file to a0
      li $v0,13			#open cipher file
      li $a1,0			#file flag = 0 (read)
      syscall 
      move $t0,$v0		#move file directory to t0
      li $v0,14			#read from file
      move $a0,$t0		#move directory to a0
      la $a1,file_inputs	#load byte space into address of a1
      la $a2,1024		#assign the byte space for the file inputs
      syscall 
      la $a0,file_inputs	#read from a file then print
      li $v0,4
      syscall
      li $v0,16			#close file
      move $a0,$t0
      syscall  
      
      #finding the shift value
      li $s0,0      		#i = 0
      li $t0,1024     		#max for i to reach
      la $a0,file_inputs	#load address of file inputs to a0
      jal ShiftValue
      la $a0,shift_value	#load message of shift value to a0
      li $v0,4			#print message
      syscall 
      move $a0,$t9		#(t0=shiftvalue) move shift value to a0
      li $v0,1			#print shift value (print integer)
      move $t9,$a0
      syscall
      la $a0,new_line		#load new line to a0
      li $v0,4			#print new line
      syscall 
      
      
      la $a0,text_file_msg	#load plain text to a0
      li $v0,4			#print plain text
      syscall
      li $v0,8			#read plaint ext file
      la $a0,read_fileName	#load byte space into address of a0
      li $a1,48			#assign the byte space for a string
      syscall 
      
      #return text to original form
      li $s0,0      		#i = 0
      li $t0,1024     		#max for i to reach
      la $a0,file_inputs
      move $t1,$t9		#move shift value to t1
      jal UndoShiftString
      la $a0,file_inputs	
      li $v0,4			#print original string
      syscall 
      
      
      #WritetoFile
      la $a0,text_file		#load text file to a0
      li $v0,13			#open text file
      li $a1,1			#file flag = 1 (write)
      syscall 
      move $t0,$v0		#move file directory to t0
      li $v0,15			#write to file
      move $a0,$t0		#move directory to a0
      la $a1,file_inputs
      la $a2,1024
      syscall
      li $v0,16			#close file
      move $a0,$t0 
      syscall 
      j next
	
      
      
    RemoveNonAlpha:
      beq $s0,$t0,End_RemoveNonAlpha  		#if i = 1024 end
      add $t4,$s0,$a0       	#address of text_file_inputs[i] in $t4
      lb  $s1,0($t4)     	#load value of text_file_inputs[i]
      addi $s0,$s0,1    	#i = i + 1
      beq $s1,0x0a,print	#if new line print
      beq $s1,0x20,print	#if space print
      slti $t1,$s1,0x41         #if ascii code is less than 0x41
      bne $t1,$zero,remove   	#remove ascii character
      move $t1,$zero		#reset t0 to 0
      sgtu $t1,$s1,0x5a        	#if ascii code is greater than 0x5a and 
      slti $t2,$s1,0x61        	#if ascii code is less than 0x61     
      beq $t1,$t2,remove   	#remove ascii character
      move $t1,$zero
      move $t2,$zero
      sgtu $t1,$s1,0x7a       	#if ascii character is greater than 0x7a
      bne $t1,$zero,remove  	#remove ascii character
      print:
      move $a1,$a0		#move a0 to a1
      lb $a0,0($t4)		#print character
      li $v0,11
      syscall 
      move $a0,$a1		#return value to a0
      move $t1,$zero
      move $t2,$zero
      j RemoveNonAlpha      	#jump to RemoveNonAlpha
     remove:
     li $s2,0x7f		#ascii for delete
     sb $s2,0($t4)      	#text_file_inputs[i] = delete (removed)
     j RemoveNonAlpha       	#jump to RemoveNonAlpha
     End_RemoveNonAlpha:
     la $a0,new_line		#load new line to a0
     li $v0,4			#print new line
     syscall
     jr $ra         		#return
     
     
   UppertoLower:
    lb $s1,file_inputs($s0)		#load first char
    beq $s1,0,End_UppertoLower		#if null terminator end
    blt $s1,0x41,AlreadyLower		#there is only alpha chars so if nor in this range
    bgt $s1,0x5a,AlreadyLower		#then its already lower
    add  $s1,$s1,32			#from upper to lower add 32 (ascii)
    sb $s1,file_inputs($s0)		#store char

    AlreadyLower: 
    addi $s0, $s0, 1		#i=i+1
    j UppertoLower
    
    End_UppertoLower:
    la $a0,new_line		#load new line to a0
    li $v0,4			#print new line
    syscall
    jr $ra			#return
    
    
  ShiftValue:
    lb $s1,file_inputs($s0)		#load first char
    beq $s1,0,End_ShiftValue		#if null terminator end
    addi $s0,$s0,1			#i=i+1
    addi $t8,$t8,1			#shift value increment
    beq $s1,0x7f,Removed_Word		#if removed word go to Removed_Word
    beq $s1,0x0a,New_Word		#if new line go to new word
    beq $s1,0x20,New_Word		#if space go to new word
    j ShiftValue
    
    New_Word:
    subi $t8,$t8,1		#decrement 1 for space
    bgtu $t8,$t9,MaxShift	#finding if its max shift
    move $t8,$zero		#reset counter
    j ShiftValue
    
    Removed_Word:
    subi $t8,$t8,1		#decrement 1 for removed word
    j ShiftValue
    
    MaxShift:
    move $t9,$t8		#move shift value to t9
    move $t8,$zero		#reset counter
    j ShiftValue
    
    End_ShiftValue:
    jr $ra
    
    
  ShiftString:
    lb $s1,file_inputs($s0)		#load first char
    beq $s1,0,End_ShiftString		#if null terminator end
    beq $s1,0x20,NoShift		#if space no shift
    beq $s1,0x0a,NoShift		#if new line no shift
    beq $s1,0x7f,Remove			#if removed word remove it
    add $s1,$s1,$t1			#shift value
    bgtu $s1,0x7a,case			# if after z go to case
    sb $s1,file_inputs($s0)		#store char
    addi $s0,$s0,1			#i=i+1
    j ShiftString
    
    NoShift:
    sb $s1,file_inputs($s0)		#store char
    addi $s0,$s0,1			#i=i+1
    j ShiftString
    
    Remove:
    addi $s0, $s0, 1			#i=i+1
    j ShiftString
    
    case:
    subi $s1,$s1,0x7a			#get remaining shift
    addi $s1,$s1,0x60			#add it to 0x60 to start from a
    sb $s1,file_inputs($s0)		#store char
    addi $s0,$s0,1			#i=i+1
    j ShiftString
    
    End_ShiftString:
    jr $ra
    
    
    UndoShiftString:
      lb $s1,file_inputs($s0)		#load first char
      beq $s1,0,End_UndoShiftString	#if null terminator end
      beq $s1,0x20,UNoShift		#if space no shift
      beq $s1,0x0a,UNoShift		#if new line no shift
      beq $s1,0x7f,URemove		#if removed word remove it
      sub $s1,$s1,$t1			#shift value
      bltu $s1,0x61,Ucase		# if after z go to case
      sb $s1,file_inputs($s0)		#store char
      addi $s0,$s0,1			#i=i+1
      j UndoShiftString
    
      UNoShift:
      sb $s1,file_inputs($s0)		#store char
      addi $s0,$s0,1			#i=i+1
      j UndoShiftString
    
      URemove:
      addi $s0, $s0, 1			#i=i+1
      j UndoShiftString
    
      Ucase:
      la $s2,0x61			#load a to s2
      sub $s1,$s2,$s1			#get remaining shift
      la $s3,0x7b			#load ascii after z to s3
      sub $s1,$s3,$s1			#ascii after z - remening shift value = ascii of wanted char
      sb $s1,file_inputs($s0)		#store char
      addi $s0,$s0,1			#i=i+1
      j UndoShiftString
    
      End_UndoShiftString:
      jr $ra
      