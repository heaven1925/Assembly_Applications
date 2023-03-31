############# Assembly Hesap Makinesi ##################
#####################################################
.data
string1:     .asciiz "Birinci Sayiyi Yaziniz \n"
opMesaj:  .asciiz "Islem Tipini Girinizi \n"  
string2:      .asciiz "Ikinci Sayiyi Yaziniz \n"
sncMesaj: .asciiz "Hesap Sonucu = "
errMesaj:  .asciiz " Hata '+,-,*,/ \n "
newLine:	  .asciiz "\n"
carryMsg:  .asciiz "B�lmeden Kalan Say�=",
##### ALINAN INPUTLAR BELLEGE KAYDED�LMEL�D�R #######
operand1: .word 1
operand2: .word 1
operator:  .word 2
out:	 .word 1	# sonu� i�in bellek tahsili
kalan:	 .word 1  # kalan i�in bellek tahsili
#####################################################
.text
main:
li    $v0 , 4
la   $a0 , string1
syscall # Operand 1 Mesaj�
li    $v0, 5
syscall # Input Okur.
sw  $v0, operand1  # Girilen de�eri operand1 kaydet
#####################################################
optype:
li    $v0 , 4
la   $a0 , opMesaj
syscall # Operator Mesaj�
la  $a0, operator
la  $a1, 2
li    $v0, 8 # String olarak kaydedilir. $a0:buffer $a1:maks.karakter - 1
syscall # Operat�r� Okur. 
lw  $t0 , 0($a0)
#####################################################
li    $v0 , 4
la   $a0 , newLine
syscall # Bo�luk Bas�ls�n
#####################################################
## Kullan�c� Operat�r� Do�ru Girdi mi? #####################
li  $t1 , '+' 		# Toplama Kontrol�
li  $t2 , '-' 		# ��karma Kontrol�
li  $t3 , '*' 		# �arpma Kontrol�
li  $t4 , '/' 		# B�lme Kontrol�

beq $t0 , $t1 , ikinciOp	# Toplamaislemi yap�lacak
beq $t0 , $t2 , ikinciOp	# Cikarmaislemi yapilacak
beq $t0 , $t3 , ikinciOp	# �arpmaislemi yapilacak
beq $t0 , $t4 , ikinciOp	# Bolmeislemi yapilacak
j hata			# Hata Label�na dallan.
#####################################################
ikinciOp:
li    $v0 , 4
la   $a0 , string2
syscall # Operand 2 Mesaj�
li    $v0 , 5
syscall # Input Okur.
sw  $v0 , operand2  # Girilen de�eri operand2 kaydet
#####################################################
lw   $s1 , operand1
lw   $s2 , operand2
lw   $s0 , out
lw   $s4 , kalan
beq $t0 , $t1 , toplama	# TOPLAMA 
beq $t0 , $t2 , cikarma	# CIKARMA
beq $t0 , $t3 , carpma	# �ARPMA
beq $t0 , $t4 , bolme	# B�LME
toplama: 
add $s0 , $s1 , $s2
sw    $s0 , out
j print
cikarma:
sub $s0 , $s1 , $s2
sw    $s0 , out
j print
carpma:
mult   $s1 , $s2	## 16 bit carpma gibi d���nelim.
mflo   $s0 
sw    $s0 , out
j print
bolme:
div   $s1 , $s2	
mflo   $s0 	# B�l�m
mfhi   $s4	# Kalan
sw    $s4 , kalan
## b�lmeye �zel kalan� yazal�m ##
li    $v0 , 4
la   $a0 , carryMsg
syscall 		# Kalan Mesaj�
li   $v0, 1
lw  $a0, kalan	# Kalan Degeri
syscall
###########################
li    $v0 , 4
la   $a0 , newLine
syscall # Bo�luk Bas�ls�n
###########################
sw    $s0 , out
j print
#####################################################
print:
li    $v0 , 4
la   $a0 , sncMesaj
syscall 		# Sonu� Mesaj�
li   $v0, 1
lw  $a0, out
syscall		# Sonu� De�eri
###########################
li    $v0 , 4
la   $a0 , newLine
syscall # Bo�luk Bas�ls�n
###########################
j main		# t�m s�re� ba�tan ba�las�n.
#####################################################
hata:
li    $v0 , 4
la   $a0 , errMesaj
syscall 		# Hata Mesaj�
j optype		# Tekrar Yeni Operat�r Girilsin.
#####################################################