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

addi $s7, $zero, 0x550

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

  addi $a2, $zero, 80
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


  addi $a0, $zero, 0
  addi $a1, $zero, 0
  addi $a2, $zero, 0
  jal draw_plate

  lw $a0, 32($s7)
  addi $a1, $zero, 40
  jal draw_score
  sw $a0, 32($s7)

  lw $a0, 36($s7)
  addi $a1, $zero, 100
  jal draw_score
  sw $a0, 36($s7)


  j main

draw_score:
  add $t3, $zero, $a1

  add $t1, $zero, $zero
  beq $a0, $t1, score_zero

  addi $t1, $zero, 1
  beq $a0, $t1, score_one

  addi $t1, $zero, 2
  beq $a0, $t1, score_two

  addi $t1, $zero, 3
  beq $a0, $t1, score_three

  addi $t1, $zero, 4
  beq $a0, $t1, score_four

  addi $t1, $zero, 5
  beq $a0, $t1, score_five

  addi $t1, $zero, 6
  beq $a0, $t1, score_six

  score_done:
    add $t0, $zero, $zero
    add $t6, $zero, $zero

  score_loop:
    add $t1, $t0, $t0
    add $t1, $t1, $t1
    add $t1, $t1, $t8
    lw $t2, 0($t1)

    add $t1, $t3, $t3
    add $t1, $t1, $t1
    add $t1, $t1, $s0

    srl $t7, $t2, 24
    sw $t7, 0($t1)

    addi $t4, $t4, 1
    addi $t3, $t3, 160

    add $t1, $t3, $t3
    add $t1, $t1, $t1
    add $t1, $t1, $s0
    srl $t7, $t2, 16

    sw $t7, 0($t1)

    addi $t4, $t4, 1
    addi $t3, $t3, 160

    addi $t9, $zero, 10
    beq $t4, $t9, score_next_line1

score_loop1:
    add $t1, $t3, $t3
    add $t1, $t1, $t1
    add $t1, $t1, $s0
    srl $t7, $t2, 8

    sw $t7, 0($t1)

    addi $t4, $t4, 1
    addi $t3, $t3, 160

    add $t1, $t3, $t3
    add $t1, $t1, $t1
    add $t1, $t1, $s0
    add $t7, $zero, $t2

    sw $t7, 0($t1)

    addi $t9, $zero, 10
    beq $t4, $t9, score_next_line2

    addi $t0, $t0, 1
    addi $t9, $zero, 25
    beq $t0, $t9, score_ret

  j score_loop

score_ret:
  jr $ra

score_next_line1:
  add $t4, $zero, $zero
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, 1
  j score_loop1

score_next_line2:
  add $t4, $zero, $zero
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, -320
  addi $t3, $t3, 1
  j score_loop1

  j score_loop


score_zero:
  addi $t8, $zero, 0x600
  j score_done

score_one:
  addi $t8, $zero, 0x670
  j score_done

score_two:
  addi $t8, $zero, 0x700
  j score_done

score_three:
  addi $t8, $zero, 0x780
  j score_done

score_four:
  addi $t8, $zero, 0x800
  j score_done

score_five:
  addi $t8, $zero, 0x870
  j score_done

score_six:
  addi $t8, $zero, 0x900
  j score_done


draw_line:

  add $t0, $zero, $a2
  add $t1, $zero, $zero
  add $t2, $zero, $zero
  add $t3, $zero, $zero
  addi $t4, $zero, 0xff

  line_loop:

      add $t2, $t0, $t0
      add $t2, $t2, $t2
      add $t2, $t2, $s0
      sw $t4, 0($t2)
      sw $t4, 640($t2)
      sw $zero, 1280($t2)


      addi $t1, $t1, 3
      addi $t0, $t0, 480

      addi $t3, $zero, 120

      slt $t5, $t1, $t3
      bne $t5, $zero, line_loop

  jr $ra

move_plate:
  add $t0, $zero, $zero
  add $t1, $zero, $zero
  add $t2, $zero, $zero
  lui $t2, 0xf000


  sw $t0, 0($t2)
  addi $t3, $zero, -1

  plate_looop:
  lw $t0, 0($t2)
  beq $t0, $t3, plate_looop

  add $t5, $t0, $t0
  add $t5, $t5, $t5
  sw $t5, 0($s1)

  and $t1, $t0, $a2
  addi $t2, $zero, 1
  beq $t1, $zero, plate_up
  addi $t2, $zero, -1

  plate_up:
    beq $a0, $zero, plate_top
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

  beq $a1, $zero, ball_v_bounce
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
  addi $t1, $zero, 7
  addi $t0, $t0, 1
  bne $t0, $t1, not_over
  add $t0, $zero, $zero
  not_over:
  sw $t0, 32($s7)
  j move_done

ball_out1:
  addi $a0, $zero, 80
  addi $a1, $zero, 60
  lw $t0, 36($s7)
  addi $t1, $zero, 7
  addi $t0, $t0, 1
  bne $t0, $t1, not_over2
  add $t0, $zero, $zero
  not_over2:
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
 .word 0xffff,0xffffffff,0x0,0xffffffff,0xffff0000,0xffff0000,0x0,0xffffffff
 .word 0x0,0xffff,0xffff0000,0xffff0000,0xffffffff,0xffff,0xffff,0xffff0000
 .word 0x0,0xffffffff,0x0,0xffff,0xffff,0xffffffff,0x0,0xffffffff
 .word 0xffff0000

//1
.data 0x670
 .word 0x0,0x0,0x0,0x0,0x0,0xffff00,0x0,0xff
 .word 0xff000000,0x0,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0x0
 .word 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
 .word 0x0



 //2
 .data 0x700

 .word 0xffff0000,0xffff,0xffffffff,0x0,0xffffffff,0xffff0000,0xffff0000,0xffffffff
 .word 0xffff,0xffff,0xffff0000,0xffff0000,0xffffffff,0xffff,0xffff,0xffff0000
 .word 0xffff0000,0xffffffff,0xffff,0xffff,0xffff,0x0,0xffff0000,0xffff0000
 .word 0xffff

 .data 0x780

 .word 0xffff0000,0x0,0xffffffff,0x0,0xffff,0xffff0000,0xffff0000,0xffffffff
 .word 0xffff,0xffff,0xffff0000,0xffff0000,0xffffffff,0xffff,0xffff,0xffff0000
 .word 0xffff0000,0xffffffff,0xffff,0xffff,0xffff,0xffff,0x0,0xffff0000
 .word 0xffff0000

 .data 0x800

 .word 0x0,0xffffffff,0x0,0xffff,0xffff0000,0xffff,0xffff,0x0
 .word 0xffff0000,0xffff0000,0xffff0000,0xffff,0xffff,0x0,0xffff0000,0xffffffff
 .word 0xffffffff,0xffffffff,0xffffffff,0xffffffff,0x0,0xffff,0x0,0x0
 .word 0xffff0000

 .data 0x870

 .word 0xffffffff,0xffff0000,0xffffffff,0xffffffff,0xffff,0xffff0000,0xffff0000,0xffffffff
 .word 0xffff,0xffff,0xffff0000,0xffff0000,0xffffffff,0xffff,0xffff,0xffff0000
 .word 0xffff0000,0xffffffff,0xffff,0xffff,0xffff0000,0xffff,0xffff,0x0
 .word 0xffff0000

 .data 0x900

 .word 0xffff,0xffffffff,0x0,0xffffffff,0xffff0000,0xffff0000,0xffff0000,0xffffffff
 .word 0xffff,0xffff,0xffff0000,0xffff0000,0xffffffff,0xffff,0xffff,0xffff0000
 .word 0xffff0000,0xffffffff,0xffff,0xffff,0x0,0xffff,0x0,0x0
 .word 0xffff0000
