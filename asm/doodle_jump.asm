.text 0x0000

// $s0 vga address
add $s0, $zero, $zero
lui $s0, 0xd000

// $s4 btn address
add $s1, $zero, $zero
lui $s1, 0xf000

// $s5 7-seg address
add $s5, $zero, $zero
lui $s5, 0xe000

// $s6 160 * 120
addi $s6, $zero, 19200

//$s7 temp_var

addi $s7, $zero, 0x500

addi $a0, $zero, 40
addi $a1, $zero, 60

sw $a0, 0($s7)
sw $a1, 4($s7)
sw $a0, 8($s7)
sw $a1, 12($s7)

addi $t0, $zero, 50
sw $t0, 16($s7)
sw $t0, 20($s7)

addi $t0, $zero, 1
sw $t0, 24($s7)
sw $t0, 28($s7)

add $t0, $zero, $zero
sw $t0, 32($s7)
sw $t0, 36($s7)





main:

  add $t0, $zero, $zero
  addi $t1, $zero, 0x5000

  counter_timer:
  addi $t0, $t0, 1
  bne $t0, $t1, counter_timer

  lw $a0, 0($s7)
  lw $a1, 4($s7)
  addi $a2, $zero, 0x2
  jal move_plate
  sw $a0, 0($s7)
  sw $a1, 4($s7)


  lw $a0, 8($s7)
  lw $a1, 12($s7)
  addi $a2, $zero, 0x1
  jal move_plate
  sw $a0, 8($s7)
  sw $a1, 12($s7)


  lw $a0, 16($s7)
  lw $a1, 20($s7)
  lw $a2, 24($s7)
  lw $a3, 28($s7)
  jal move_ball
  sw $a0, 16($s7)
  sw $a1, 20($s7)
  sw $a2, 24($s7)
  sw $a3, 28($s7)

  jal draw_line

  lw $a0, 0($s7)
  lw $a1, 4($s7)
  addi $a2, $zero, 10
  jal draw_plate
  sw $a0, 0($s7)
  sw $a1, 4($s7)

  lw $a0, 8($s7)
  lw $a1, 12($s7)
  addi $a2, $zero, 150
  jal draw_plate
  sw $a0, 8($s7)
  sw $a1, 12($s7)

  lw $a0, 16($s7)
  lw $a1, 20($s7)
  jal draw_ball
  sw $a0, 16($s7)
  sw $a1, 20($s7)

  lw $a0, 32($s7)
  addi $a1, $zero, 40
  jal draw_score
  sw $a0, 32($s7)


  lw $a0, 36($s7)
  addi $a1, $zero, 120
  jal draw_score
  sw $a0, 36($s7)

  j main


draw_score:
  add $t0, $zero, $zero
  beq $a0, $t0, score_zero

  addi $t0, $zero, 1
  beq $a0, $t0, score_one

  addi $t0, $zero, 2
  beq $a0, $t0, score_two

  addi $t0, $zero, 3
  beq $a0, $t0, score_three

  addi $t0, $zero, 4
  beq $a0, $t0, score_four

  addi $t0, $zero, 5
  beq $a0, $t0, score_five

  addi $t0, $zero, 6
  beq $a0, $t0, score_six

  addi $t0, $zero, 7
  beq $a0, $t0, score_seven

  addi $t0, $zero, 8
  beq $a0, $t0, score_eight

  addi $t0, $zero, 9
  beq $a0, $t0, score_nine

score_done:

  add $t0, $zero, $zero
  add $t1, $zero, $zero
  add $t2, $zero, $zero
  addi $t4, $zero, 10

  score_loop:
    add $t3, $t1, $t1
    add $t3, $t3, $t3
    add $t3, $t3, $t9
    lw $t5, 0($t3)

    add $t3, $t0, $t0
    add $t3, $t3, $t3
    add $t3, $t3, $s0
    sw $t5, 0($t3)

    addi $t1, $t1, 10
    addi $t0, $t0, 1
    addi $t2, $t2, 1

    beq $t2, $t4, score_next_line

  j score_loop

score_ret:
  jr $ra

score_next_line:
  add $t2, $zero, $zero
  addi $t0, $t0, 159
  addi $t6, $t6, 1
  add $t1, $zero, $t6
  beq $t6, $t4, score_ret

score_zero:
  addi $t9, $zero, 0x600
  j score_done

score_one:
  addi $t9, $zero, 0x800
  j score_done

score_two:
  addi $t9, $zero, 0x1000
  j score_done

score_three:
  addi $t9, $zero, 0x1200
  j score_done

score_four:
  addi $t9, $zero, 0x1400
  j score_done

score_five:
  addi $t9, $zero, 0x1600
  j score_done

score_six:
  addi $t9, $zero, 0x1800
  j score_done

score_seven:
  addi $t9, $zero, 0x2000
  j score_done

score_eight:
  addi $t9, $zero, 0x2200
  j score_done

score_nine:
  addi $t9, $zero, 0x2400
  j score_done


draw_line:
  add $t0, $zero, $zero
  addi $t1, $zero, 80

  addi $t7, $zero, 120
  addi $t3, $zero, 0xff

line_loop:
  add $t2, $t1, $t1
  add $t2, $t2, $t2
  add $t2, $t2, $s0
  sw $t3, 0($t2)
  sw $zero, 160($2)

  addi $t0, $t0, 2
  addi $t1, $t1, 320
  bne $t0, $t7, line_loop

jr $ra


move_plate:
  add $t0, $zero, $zero
  add $t1, $zero, $zero

  lw $t0, 0($s1)

  add $t5, $t0, $t0
  add $t5, $t5, $t5
  sw $t5, 0($s1)

  and $t1, $t0, $a2
  addi $t2, $zero, 1
  beq $t1, $zero, plate_up
  addi $t2, $zero, -1

  plate_up:
    addi $t3, $zero, 13
    beq $a0, $t3, plate_top
    addi $t3, $zero, 120
    beq $a1, $t3, plate_bot
    plate_move:
      add $a0, $a0, $t2
      add $a1, $a1, $t2

  plate_done:

  jr $ra

  plate_top:
    addi $t3, $zero, 1
    beq $t2, $t3, plate_move
    j plate_done

  plate_bot:
    addi $t3, $zero, -1
    beq $t2, $t3, plate_move
    j plate_done


move_ball:

  addi $t0, $zero, 156
  addi $t1, $zero, 112

  add $a0, $a0, $a2
  add $a1, $a1, $a3


  beq $a0, $zero, ball_out0
  beq $a0, $t0, ball_out1

  addi $t3, $zero, 13
  beq $a1, $t3, ball_v_bounce
  beq $a1, $t1, ball_v_bounce

  addi $t2, $zero, 14
  lw $t8, 0($s7)
  lw $t9, 4($s7)
  beq $a0, $t2, ball_h_bounce

  addi $t2, $zero, 146
  lw $t8, 8($s7)
  lw $t9, 12($s7)
  beq $a0, $t2, ball_h_bounce

move_done:
  jr $ra

ball_out0:
  addi $a0, $zero, 80
  addi $a1, $zero, 60
  lw $t0, 32($s7)
  addi $t0, $t0, 1
  sw $t0, 32($s7)
  j move_done

ball_out1:
  addi $a0, $zero, 80
  addi $a1, $zero, 60
  lw $t0, 36($s7)
  addi $t0, $t0, 1
  sw $t0, 36($s7)
  j move_done

ball_v_bounce:
  xori $a3, $a3, -1
  addi $a3, $a3, 1
  j move_done

ball_h_bounce:

  slt $t5, $t8, $a1
  beq $t5, $zero, move_done
  slt $t5, $a1, $t9
  beq $t5, $zero, move_done

  xori $a2, $a2, -1
  addi $a2, $a2, 1
  j move_done


draw_ball:
  add $t0, $zero, $zero
  add $t1, $zero, $zero

  addi $t4, $zero, 0xff

  add $t7, $zero, $a0
  add $t8, $zero, $a1

  beq $t8, $zero, ball_zero
  ball_counter_loop:
    addi $t8, $t8, -1
    addi $t0, $t0, 160
    bne $t8, $zero, ball_counter_loop

  ball_zero:
    add $t0, $t0, $a0

    add $t1, $t0, $t0
    add $t1, $t1, $t1
    add $t1, $t1, $s0
    sw $zero, 0($t1)
    sw $zero, 4($t1)
    sw $zero, 8($t1)
    sw $zero, 12($t1)

    addi $t1, $t1, 640
    sw $zero, 0($t1)
    sw $t4, 4($t1)
    sw $t4, 8($t1)
    sw $zero, 12($t1)

    addi $t1, $t1, 640
    sw $zero, 0($t1)
    sw $t4, 4($t1)
    sw $t4, 8($t1)
    sw $zero, 12($t1)

    addi $t1, $t1, 640
    sw $zero, 0($t1)
    sw $zero, 4($t1)
    sw $zero, 8($t1)
    sw $zero, 12($t1)


  jr $ra


draw_plate:

  add $t0, $zero, $a2
  add $t1, $zero, $zero
  add $t2, $zero, $zero
  add $t3, $zero, $zero

  plate_loop:

    add $t4, $zero, $zero
    slt $t5, $t1, $a0
    bne $t5, $zero, plate_black
    slt $t5, $a1, $t1
    bne $t5, $zero, plate_black
    addi $t4, $zero, 0xff

    plate_black:

      add $t2, $t0, $t0
      add $t2, $t2, $t2
      add $t2, $t2, $s0
      sw $t4, 0($t2)
      sw $t4, 4($t2)
      sw $t4, 8($t2)
      sw $t4, 12($t2)

      addi $t1, $t1, 1
      addi $t0, $t0, 160

      addi $t3, $zero, 120

      slt $t5, $t1, $t3
      bne $t5, $zero, plate_loop

  jr $ra

//0
.data 0x600

 .word 0x0,0x0,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0x0,0x0

//1
.data 0x800

 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0xff,0xff,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xff
 .word 0xff,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0

//2
.data 0x1000

 .word 0xff,0xff,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0x0,0x0,0xff,0xff

//3
 .data 0x1200

 .word 0xff,0xff,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0

//4
  .data 0x1400

 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0

//5
  .data 0x1600

 .word 0xff,0xff,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0

 //6

 .data 0x1800
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0


 //7

 .data 0x2000
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0x0,0x0,0x0,0x0

 //8

 .data 0x2200
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0


 //9

 .data 0x2400
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0x0,0x0
 .word 0xff,0xff,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0x0,0x0,0xff,0xff
 .word 0x0,0x0,0xff,0xff,0xff,0xff,0xff,0xff
 .word 0x0,0x0,0x0,0x0,0xff,0xff,0xff,0xff
 .word 0xff,0xff,0x0,0x0
