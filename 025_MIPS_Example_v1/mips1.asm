.data
### Data seg. kaydedilecek de�erler ####
string_1:   .asciiz  "enter a number : \n"
.text
addi $t0,$zero,150
addi $t1,$zero,250
add  $t2,$t0,$t1 
### Basit Toplama i�lemi #############
li $v0,4
la $a0,string_1
syscall
#### Hello World Yaz�s�n� Bas ########
li $v0,5
syscall
### Giri� Al #######################
add $t3,$zero,$v0
li $v0,1
move $a0, $t3
syscall
### Girilen Say�y� Tekrar Bas ########
