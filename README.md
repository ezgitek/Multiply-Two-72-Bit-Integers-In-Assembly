# Multiply two 72 bit integers in Assembly

This program takes two 18-digit hex numbers as user input, multiplies them and gives output. 

To compile and run the program with a86, write to terminal:

> a86 multiply.asm
> multiply
> <first number> 
> <second number>

1. Note that in order to get correct output, you should write A-F hex digits 
as uppercase characters. abcdef * abcdef will not give correct output 
but ABCDEF * ABCDEF will.
You should use CAPSLOCK instead of SHIFT in order to use uppercase letters. 

2. If the output is less than 36 digits, zeros will be padded to left of output 
(example: 10 * 10 = 00000000000000000000000000000100).

3. You should not give the terminal any other character than ENTER,letters 
or numbers. 
If you try to use one (ex. DELETE), please restart the program. 

4. Numbers more than 18 digits will not give correct output but it will still 
give the last digits of the output. 

5. If you give no input, answer will be 32 digits of 0.
