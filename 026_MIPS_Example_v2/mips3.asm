########################################
.data
string1 : .ascii "Taban sayisini giriniz : \n",
string2 : .ascii "Kuvvet sayisini giriniz : \n"
string3 : .ascii "Sonuc : \n"
########################################
.text
li  $v0 , 4
la $a0 , string1
syscall ## Taban sayisi giri� yaz�s�
li  $v0 , 5
syscall ## Taban say�s� giri�i
add $t0 , $zero , $v0 # Taban� t0 kaydet
#################################
li  $v0 , 4
la $a0 , string2
syscall ## Kuvvet sayisi giri� yaz�s�
li  $v0 , 5
syscall ## Kuvvet  say�s� giri�i
add $t1 , $zero , $v0 # Kuvveti t1 kaydet
########################################
## Prosed�r Sub-Routine Arg�manlar�  ##
add $a0, $zero , $t0	# Taban
add $a1, $zero , $t1	# Kuvvet
## Prosed�r� �a��ral�m.. 		        ##
jal recursivePowerFunction 
li  $v0 , 4
la $a0 , string3
syscall ## Sonu� yaz�s�
add $a0, $zero, $v0
li $v0, 1
syscall	## i�lemin sonunda hesaplanan de�er
#########################################
li  $v0 , 10
syscall # Exit Program
#########################################
recursivePowerFunction: # Sub Routine
bne $a1 , $zero , recursion
li $v0 , 1		# return 1 d�n�yor
jr $ra		# d�n�� adresine atla 
#########################################
recursion: ## Kuvvetin durumuna g�re birden
## fazla kez �a��ralaca�� i�in ra tutulmal�d�r.
## Bu sebepten stack belle�inden yer tutulmal�d�r.
## Memory allocate yap�lmal�d�r. SP adresi bellek
## organizasyonundan dolay� y�ksek de�erde ba�lar.
## upside down yap�dad�r.
addi $sp , $sp , -4
## d�n�� adresi bu b�lgeye kaydedilecek.
sw $ra , 0($sp)
## �st bir azalt�l�yor.
addi $a1 , $a1 , -1
jal recursivePowerFunction ## fonksiyona tekrar girildi.
############################################
mul $v0 , $v0 , $a0
lw $ra , 0( $sp)
addi $sp , $sp , 4
jr $ra
