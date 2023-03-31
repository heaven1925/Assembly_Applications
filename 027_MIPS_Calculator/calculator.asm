############# Assembly Hesap Makinesi ##################
#####################################################
.data
string1:     .asciiz "Birinci Sayiyi Yaziniz \n"
opMesaj:  .asciiz "Islem Tipini Girinizi \n"  
string2:      .asciiz "Ikinci Sayiyi Yaziniz \n"
sncMesaj: .asciiz "Hesap Sonucu = "
errMesaj:  .asciiz " Hata '+,-,*,/ \n "
newLine:	  .asciiz "\n"
carryMsg:  .asciiz "Bölmeden Kalan Sayý=",
##### ALINAN INPUTLAR BELLEGE KAYDEDÝLMELÝDÝR #######
operand1: .word 1
operand2: .word 1
operator:  .word 2
out:	 .word 1	# sonuç için bellek tahsili
kalan:	 .word 1  # kalan için bellek tahsili
#####################################################
.text
main:
li    $v0 , 4
la   $a0 , string1
syscall # Operand 1 Mesajý
li    $v0, 5
syscall # Input Okur.
sw  $v0, operand1  # Girilen deðeri operand1 kaydet
#####################################################
optype:
li    $v0 , 4
la   $a0 , opMesaj
syscall # Operator Mesajý
la  $a0, operator
la  $a1, 2
li    $v0, 8 # String olarak kaydedilir. $a0:buffer $a1:maks.karakter - 1
syscall # Operatörü Okur. 
lw  $t0 , 0($a0)
#####################################################
li    $v0 , 4
la   $a0 , newLine
syscall # Boþluk Basýlsýn
#####################################################
## Kullanýcý Operatörü Doðru Girdi mi? #####################
li  $t1 , '+' 		# Toplama Kontrolü
li  $t2 , '-' 		# Çýkarma Kontrolü
li  $t3 , '*' 		# Çarpma Kontrolü
li  $t4 , '/' 		# Bölme Kontrolü

beq $t0 , $t1 , ikinciOp	# Toplamaislemi yapýlacak
beq $t0 , $t2 , ikinciOp	# Cikarmaislemi yapilacak
beq $t0 , $t3 , ikinciOp	# Çarpmaislemi yapilacak
beq $t0 , $t4 , ikinciOp	# Bolmeislemi yapilacak
j hata			# Hata Labelýna dallan.
#####################################################
ikinciOp:
li    $v0 , 4
la   $a0 , string2
syscall # Operand 2 Mesajý
li    $v0 , 5
syscall # Input Okur.
sw  $v0 , operand2  # Girilen deðeri operand2 kaydet
#####################################################
lw   $s1 , operand1
lw   $s2 , operand2
lw   $s0 , out
lw   $s4 , kalan
beq $t0 , $t1 , toplama	# TOPLAMA 
beq $t0 , $t2 , cikarma	# CIKARMA
beq $t0 , $t3 , carpma	# ÇARPMA
beq $t0 , $t4 , bolme	# BÖLME
toplama: 
add $s0 , $s1 , $s2
sw    $s0 , out
j print
cikarma:
sub $s0 , $s1 , $s2
sw    $s0 , out
j print
carpma:
mult   $s1 , $s2	## 16 bit carpma gibi düþünelim.
mflo   $s0 
sw    $s0 , out
j print
bolme:
div   $s1 , $s2	
mflo   $s0 	# Bölüm
mfhi   $s4	# Kalan
sw    $s4 , kalan
## bölmeye özel kalaný yazalým ##
li    $v0 , 4
la   $a0 , carryMsg
syscall 		# Kalan Mesajý
li   $v0, 1
lw  $a0, kalan	# Kalan Degeri
syscall
###########################
li    $v0 , 4
la   $a0 , newLine
syscall # Boþluk Basýlsýn
###########################
sw    $s0 , out
j print
#####################################################
print:
li    $v0 , 4
la   $a0 , sncMesaj
syscall 		# Sonuç Mesajý
li   $v0, 1
lw  $a0, out
syscall		# Sonuç Deðeri
###########################
li    $v0 , 4
la   $a0 , newLine
syscall # Boþluk Basýlsýn
###########################
j main		# tüm süreç baþtan baþlasýn.
#####################################################
hata:
li    $v0 , 4
la   $a0 , errMesaj
syscall 		# Hata Mesajý
j optype		# Tekrar Yeni Operatör Girilsin.
#####################################################