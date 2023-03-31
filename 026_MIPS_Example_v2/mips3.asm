########################################
.data
string1 : .ascii "Taban sayisini giriniz : \n",
string2 : .ascii "Kuvvet sayisini giriniz : \n"
string3 : .ascii "Sonuc : \n"
########################################
.text
li  $v0 , 4
la $a0 , string1
syscall ## Taban sayisi giriþ yazýsý
li  $v0 , 5
syscall ## Taban sayýsý giriþi
add $t0 , $zero , $v0 # Tabaný t0 kaydet
#################################
li  $v0 , 4
la $a0 , string2
syscall ## Kuvvet sayisi giriþ yazýsý
li  $v0 , 5
syscall ## Kuvvet  sayýsý giriþi
add $t1 , $zero , $v0 # Kuvveti t1 kaydet
########################################
## Prosedür Sub-Routine Argümanlarý  ##
add $a0, $zero , $t0	# Taban
add $a1, $zero , $t1	# Kuvvet
## Prosedürü Çaðýralým.. 		        ##
jal recursivePowerFunction 
li  $v0 , 4
la $a0 , string3
syscall ## Sonuç yazýsý
add $a0, $zero, $v0
li $v0, 1
syscall	## iþlemin sonunda hesaplanan deðer
#########################################
li  $v0 , 10
syscall # Exit Program
#########################################
recursivePowerFunction: # Sub Routine
bne $a1 , $zero , recursion
li $v0 , 1		# return 1 dönüyor
jr $ra		# dönüþ adresine atla 
#########################################
recursion: ## Kuvvetin durumuna göre birden
## fazla kez çaðýralacaðý için ra tutulmalýdýr.
## Bu sebepten stack belleðinden yer tutulmalýdýr.
## Memory allocate yapýlmalýdýr. SP adresi bellek
## organizasyonundan dolayý yüksek deðerde baþlar.
## upside down yapýdadýr.
addi $sp , $sp , -4
## dönüþ adresi bu bölgeye kaydedilecek.
sw $ra , 0($sp)
## üst bir azaltýlýyor.
addi $a1 , $a1 , -1
jal recursivePowerFunction ## fonksiyona tekrar girildi.
############################################
mul $v0 , $v0 , $a0
lw $ra , 0( $sp)
addi $sp , $sp , 4
jr $ra
