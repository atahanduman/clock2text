# Atahan Duman -- 01/04/2022
# 215008004006.asm-- A program that convert and prints the time
# value of string specified at runtime by the user.
# Registers used:
# $t0 - used to hold hour value.
# $t1 - used to hold minute value.
# $t4 - used to hold the result string.
# $v0 - syscall parameter and return value.
# $a0 - syscall parameter.

.data

result:		.space 200
buffer:		.space 20

hour:		.space 50

enterHour: 	.asciiz "\nPlease enter the hour :\n"
enterMinute: 	.asciiz "\nPlease enter the minute :\n"

one:		.asciiz "one "
two:		.asciiz "two "
three: 		.asciiz "three "
four: 		.asciiz "four "
five: 		.asciiz "five "
six: 		.asciiz "six "
seven: 		.asciiz "seven "
eight: 		.asciiz "eight "
nine: 		.asciiz "nine "
ten: 		.asciiz "ten "
eleven: 	.asciiz "eleven "
twelve: 	.asciiz "twelve "
thirteen: 	.asciiz "thirteen "
fourteen: 	.asciiz "fourteen "
fifteen: 	.asciiz "fifteen "
sixteen: 	.asciiz "sixteen "
seventeen: 	.asciiz "seventeen "
eighteen: 	.asciiz "eighteen "
nineteen: 	.asciiz "nineteen "
twenty: 	.asciiz "twenty "
thirty: 	.asciiz "thirty "
fourty: 	.asciiz "fourty "
fifty: 		.asciiz "fifty "
minute: 	.asciiz "minute "
minutes: 	.asciiz "minutes "
quarter: 	.asciiz "quarter "
to: 		.asciiz "to "
half: 		.asciiz "half "
past: 		.asciiz "past "
clock: 		.asciiz "o' clock "

newLine:	.asciiz "\n"

end:		.word 58	# Converting end flag

.text
.globl main
main:
	li $v0, 4 		# system call code for Print String
	la $a0, enterHour 	
	syscall 		# print the prompt message

	li $v0, 5 		# Read Hour value to input
	syscall
	move $t0, $v0 		# Save hour value to $t0 = Hour
	
	li $v0, 4 		# system call code for Print String
	la $a0, enterMinute 	
	syscall 		# print the prompt message
	
	li $v0, 5 		#  Read Minute value to input
	syscall
	move $t1, $v0   	# Save minute value to $t0 = Minute
	
	jal incrHour		# If minutes > 30 hour = hour + 1
	
	jal controlHour		# Convert hour to string 5 -> five / Convert hour procedure
		
	jal controlMinute	# Convert minute to string 21 -> twenty five / Convert minute procedure
	
	jal printResult		# Print Final Result
	
exit:				# Exit Program
	li $v0, 10 		# terminate program run and
	syscall 		# return control to system 

incrHour:
	bgt $t1, 30, increment
	jr $ra
increment:
	addi $t0, $t0, 1
	jr $ra

printResult:			# Print Last Value
	la $t7, result		# stringin bulundugu adresi yukluyoruz
	
	li $v0, 4 		# system call code for Print String
	la $a0, newLine		# load address of newline into $a0 = newline
	syscall
	
	RunLoop:
	lw $t1, ($t7)		# kosul kontrolu icin 58 var mi yok mu diye degeri atiyoruz t1 e
	beq $t1, 58, endLoop	# end loop if value == 58
	li $v0, 4 		# system call code for Print String
	lw $a0, 0($t7)		# load address of prompt into $a0 = result[0]
	syscall
	addi $t7, $t7, 4	# her dongude word kadar ileri git
	j RunLoop
	
	endLoop:
	li $v0, 4 		# system call code for Print String
	la $a0, newLine		# load address of newline into $a0 = newline
	syscall
	jr $ra

controlHour:
	# Eger kolaysa $t0 degerini mod 12 yap
	beq $t0, $zero, setHZero
	beq $t0, 1, setHOne
	beq $t0, 2, setHTwo
	beq $t0, 3, setHThree
	beq $t0, 4, setHFour
	beq $t0, 5, setHFive
	beq $t0, 6, setHSix
	beq $t0, 7, setHSeven
	beq $t0, 8, setHEight
	beq $t0, 9, setHNine
	beq $t0, 10, setHTen
	beq $t0, 11, setHEleven
	beq $t0, 12, setHTwelve
	
	setHZero:
		la $t2, twelve
		j addHour
	setHOne:
		la $t2, one
		j addHour
	setHTwo:
		la $t2, two
		j addHour
	setHThree:
		la $t2, three
		j addHour
	setHFour:
		la $t2, four
		j addHour
	setHFive:
		la $t2, five
		j addHour
	setHSix:
		la $t2, six
		j addHour
	setHSeven:
		la $t2, seven
		j addHour
	setHEight:
		la $t2, eight
		j addHour
	setHNine:
		la $t2, nine
		j addHour
	setHTen:
		la $t2, ten
		j addHour
	setHEleven:
		la $t2, eleven
		j addHour
	setHTwelve:
		la $t2, twelve
		j addHour
	addHour:
		la $t3, hour
		sw $t2, 0($t3)
		jr $ra
		
controlMinute:
	la $t0, hour			# get hour
	lw $t3, 0($t0)			# $t3 = HOUR
	la $t4, result			# $t4 = result
	
	beq $t1, $zero, setZero
	beq $t1, 1, setOne
	beq $t1, 2, setTwo
	beq $t1, 3, setThree
	beq $t1, 4, setFour
	beq $t1, 5, setFive
	beq $t1, 6, setSix
	beq $t1, 7, setSeven
	beq $t1, 8, setEight
	beq $t1, 9, setNine
	beq $t1, 10, setTen
	beq $t1, 11, setEleven
	beq $t1, 12, setTwelve
	beq $t1, 13, setThirteen
	beq $t1, 14, setFourteen
	beq $t1, 15, setFifteen
	beq $t1, 16, setSixteen
	beq $t1, 17, setSeventeen
	beq $t1, 18, setEighteen
	beq $t1, 19, setNineteen
	beq $t1, 20, setTwenty
	beq $t1, 21, setTOne
	beq $t1, 22, setTTwo
	beq $t1, 23, setTThree
	beq $t1, 24, setTFour
	beq $t1, 25, setTFive
	beq $t1, 26, setTSix
	beq $t1, 27, setTSeven
	beq $t1, 28, setTEight
	beq $t1, 29, setTNine
	beq $t1, 30, setThirty	
	beq $t1, 31, setThOne
	beq $t1, 32, setThTwo
	beq $t1, 33, setThThree
	beq $t1, 34, setThFour
	beq $t1, 35, setThFive
	beq $t1, 36, setThSix
	beq $t1, 37, setThSeven
	beq $t1, 38, setThEight
	beq $t1, 39, setThNine
	beq $t1, 40, setForty
	beq $t1, 41, setFOne
	beq $t1, 42, setFTwo
	beq $t1, 43, setFThree
	beq $t1, 44, setFFour
	beq $t1, 45, setFFive
	beq $t1, 46, setFSix
	beq $t1, 47, setFSeven
	beq $t1, 48, setFEight
	beq $t1, 49, setFNine
	beq $t1, 50, setFifty
	beq $t1, 51, setFfOne
	beq $t1, 52, setFfTwo
	beq $t1, 53, setFfThree
	beq $t1, 54, setFfFour
	beq $t1, 55, setFfFive
	beq $t1, 56, setFfSix
	beq $t1, 57, setFfSeven
	beq $t1, 58, setFfEight
	beq $t1, 59, setFfNine
	
	setZero:
		la $t2, clock			# $t2 = Minute
		sw $t3, 0($t4)			
		sw $t2, 4($t4)			# $t2 = Minute
		li $s0, 8
		j addMinute
	setOne:
		la $t2, one
		la $t5, minute
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setTwo:
		la $t2, two
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setThree:
		la $t2, three
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFour:
		la $t2, four
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFive:
		la $t2, five
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setSix:
		la $t2, six
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setSeven:
		la $t2, seven
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setEight:
		la $t2, eight
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setNine:
		la $t2, nine
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setTen:
		la $t2, ten
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setEleven:
		la $t2, eleven
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setTwelve:
		la $t2, twelve
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setThirteen:
		la $t2, thirteen
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFourteen:
		la $t2, fourteen
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFifteen:
		la $t2, quarter
		la $t5, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)		
		sw $t3, 8($t4)
		
		li $s0, 12
		j addMinute
	setSixteen:
		la $t2, sixteen
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setSeventeen:
		la $t2, seventeen
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setEighteen:
		la $t2, eighteen
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setNineteen:
		la $t2, nineteen
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setTwenty:
		la $t2, twenty
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setTOne:
		la $t2, twenty
		la $s3, one
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTTwo:
		la $t2, twenty
		la $s3, two
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTThree:
		la $t2, twenty
		la $s3, three
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTFour:
		la $t2, twenty
		la $s3, four
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTFive:
		la $t2, twenty
		la $s3, five
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTSix:
		la $t2, twenty
		la $s3, six
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTSeven:
		la $t2, twenty
		la $s3, seven
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTEight:
		la $t2, twenty
		la $s3, eight
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setTNine:
		la $t2, twenty
		la $s3, nine
		la $t5, minutes
		la $t7, past
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThirty:
		la $t2, half
		la $t5, past
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)			
		sw $t3, 8($t4)
		
		li $s0, 12
		j addMinute	
	setThOne:
		la $t2, twenty
		la $s3, nine
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThTwo:
		la $t2, twenty
		la $s3, eight
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThThree:
		la $t2, twenty
		la $s3, seven
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThFour:
		la $t2, twenty
		la $s3, six
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThFive:
		la $t2, twenty
		la $s3, five
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThSix:
		la $t2, twenty
		la $s3, six
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThSeven:
		la $t2, twenty
		la $s3, three
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThEight:
		la $t2, twenty
		la $s3, two
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setThNine:
		la $t2, twenty
		la $s3, one
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)	
		sw $s3, 4($t4)			
		sw $t5, 8($t4)			
		sw $t7, 12($t4)			
		sw $t3, 16($t4)
		
		li $s0, 20
		j addMinute
	setForty:
		la $t2, twenty
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFOne:
		la $t2, nineteen
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFTwo:
		la $t2, eighteen
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFThree:
		la $t2, seventeen
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFFour:
		la $t2, sixteen
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFFive:
		la $t2, quarter
		la $t5, to
		
		sw $t2, 0($t4)			
		sw $t5, 4($t4)		
		sw $t3, 8($t4)
		
		li $s0, 12
		j addMinute
	setFSix:
		la $t2, fourteen
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFSeven:
		la $t2, thirteen
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFEight:
		la $t2, twelve
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFNine:
		la $t2, eleven
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFifty:
		la $t2, ten
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfOne:
		la $t2, nine
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfTwo:
		la $t2, eight
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfThree:
		la $t2, seven
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfFour:
		la $t2, six
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfFive:
		la $t2, five
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfSix:
		la $t2, four
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfSeven:
		la $t2, three
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfEight:
		la $t2, two
		la $t5, minutes
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
	setFfNine:
		la $t2, one
		la $t5, minute
		la $t7, to
		
		sw $t2, 0($t4)		
		sw $t5, 4($t4)			
		sw $t7, 8($t4)			
		sw $t3, 12($t4)
		
		li $s0, 16
		j addMinute
addMinute:
	la $t6, end			# load ending flag
	lw $t6, ($t6)			# get end data 58
	
	beq $s0, 8 , ret8
	beq $s0, 12 , ret12
	beq $s0, 16 , ret16
	beq $s0, 20 , ret20
ret8:
	sw $t6, 8($t4)			# set end string 58
	jr $ra				# return 
ret12:
	sw $t6, 12($t4)			# set end string 58
	jr $ra				# return 
ret16:
	sw $t6, 16($t4)			# set end string 58
	jr $ra				# return 
ret20:
	sw $t6, 20($t4)			# set end string 58
	jr $ra				# return 
