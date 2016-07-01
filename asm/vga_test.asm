.text 0x0000
lui $s1, 0xd000
addi $a2, $zero, 0x49
loop0:
  sw $a2, 4($s1)
  j loop0
