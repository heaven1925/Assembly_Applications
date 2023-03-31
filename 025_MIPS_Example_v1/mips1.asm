.data
### Data seg. kaydedilecek deðerler ####
string_1:   .asciiz  "enter a number : \n"
.text
addi $t0,$zero,150
addi $t1,$zero,250
add  $t2,$t0,$t1 
### Basit Toplama iþlemi #############
li $v0,4
la $a0,string_1
syscall
#### Hello World Yazýsýný Bas ########
li $v0,5
syscall
### Giriþ Al #######################
add $t3,$zero,$v0
li $v0,1
move $a0, $t3
syscall
### Girilen Sayýyý Tekrar Bas ########
