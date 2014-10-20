# Calculate 1+2+3+4...+10

            li      $t0     0                   # // index
            li      $t1     0                   # // result
            li      $t2     10                  # // condition

while:      bge     $t0     $t2     end         # while (t0>=t2) {
            add     $t1     $t1     $t0         #   t1 += t0;
            addi    $t0     $t0     1           #   t0++
            b       while                       # }
end:                                            # ...

# Calculate the number of 1's in register $t0 and store the result in $t3

            li      $t0     0                   # // index
            li      $t1     42                  # // number
            li      $t2     32                  # // condition
            li      $t3     0                   # // result

while:      bge     $t0     $t2     end         # while (i<t2){
            and     $t4     $t1     1           #   b = last bit in t1;
            add     $t3     $t3     $t4         #   t3 += b;
            srl     $t1     $t1     1           #   t1 = t1 right shift;
            addi    $t0     1                   #   i++;
            b       while                       # }
end:                                            #...

# Obtain the 16 first bits of a register ($t0) and store them in the 16 last
# bits of other register ($t1)

            srl     $t1     $t0     16          # // Shifting in other register

# Determine if the number stored in $t2 is even. If $t2 is even the program
# stores 1 in $t1, else stores 0 in $t1

            li      $t2     15                  # // number
            li      $t1     2                   # // result

            rem     $t2     $t2     2           # t2 %= 2;
            beq     $t2     $0      then        # if (t2==0)... //After else
else:       li      $t1     0                   # else {t1=0}
            b       end                         # return
then:       li      $t1     1                   # if (t2==0){t1=1}
end:                                            # ...

# Compute the length of a String and print it

.data
string:    .asciiz     "hello"                  # // string

.text
            .globl main
main:       li      $a0     0                   # a0 = 0;
            lbu     $t1     string              # *t1 = &string;
while:      beqz    $t1     end                 # while (t1=!null){
            addi    $a0     $a0     1           # a0++;
            lbu     $t1     string($a0)         # *t1 = next byte;
            b       while                       # }
end:        li      $v0     1                   # printf(a0);
            syscall

# Translate the following C code into Assembler

# int r;
# int a = 9;
# int b = 7;
#
# main (){
#   int c = a + b;
#   int d = a - b;
#   r = f(a, b, c, d);
#   print(r);
# }
#
# int f (int x, int y, int z, int w){
#   if (x + y == z + w)
#       return (x + y);
#   else
#       return (z + w);
# }

.data
A:          .word       9
B:          .word       7

.text
            .globl main
main:       lw      $a0     A
            lw      $a1     B
            add     $a2     $a0     $a1
            sub     $a3     $a0     $a1
            jal     F
            move    $a0     $v0
            li      $v0     1
            syscall
            li      $v0     10
            syscall

F:          add     $t0     $a0     $a1         # x + y -> a + b
            sub     $t1     $a2     $a3         # z + w -> c + d
            beq     $t0     $t1     if
else:       move    $v0     $t1
            b       endif
if:         move    $v0     $t0
endif:      jr      $ra

# Write a recursive implementation of Fibonacci Code for MIPS give that n = 10

.data

.text
            .globl main
main:       li      $a0     10                  # a0 = 10
            jal     Fibonacci                   # Fibonacci ()

Fibonacci:  subu    $sp     $sp     20          # Stack pointer reserve 4B*5reg.
            sw      $a0     ($sp)               # S
            sw      $s0     4($sp)              # T
            sw      $s1     8($sp)              # A
            sw      $s2     12($sp)             # C
            sw      $ra     16($sp)             # K
            li      $s0     2                   # s0 = 2;
            li      $s1     1                   # s1 = 1;
            bge     $a0     $s0     getwo       # if (a0>=2){...
            bge     $a0     $s1     getone      # if (a0>=1){...
            li      $v0     0                   # return 0
            b       end

gettwo:     subu    $a0     $a0     1           # $a0--;
            jal     Fibonacci                   # v0 = Fibonacci (a0)
            move    $s2     $v0                 # v0 = s2
            subu    $a0     $a0     1           # a0--
            jal     Fibonacci                   # v0 = Fibonacci (a0)
            add     $v0     $v0     $s2         # v0 += s2
            b       end

getone:     li      $v0     1                   # return 1

end:        lw      $a0     ($sp)               # S
            lw      $s0     4($sp)              # T
            lw      $s1     8($sp)              # A
            lw      $s2     12($sp)             # C
            lw      $ra     16($sp)             # K
            addu    $sp     $sp     20          # Restore stack


# Translate the following C code into Assembler

# int f (int k) {
#   int v[100];
#   int i = 0;
#   int s = 0;
#
#   for (i = 0; i<k; i = i+2)
#       v[i] = g(k+2);
#
#   for (i = 0; i<k; i = i +2)
#       s = s + v[i];
#
#   return (s);
# }
#
# int g (int k) {
#   if(k%2 == 0)
#       return (k*k+2);
#   else
#       return k*(-1);
#
.data
v:          space   400

.text
f:          subu    $sp     $sp     20
            sw      $ra     ($sp)               # S
            sw      $a0     4($sp)              # T
            sw      $s0     8($sp)              # A
            sw      $s1     12($sp)             # C
            sw      $s2     16($sp)             # K
            la      $s0     v                   # s0 pointer
            li      $s1     0                   # i = 0
            li      $s2     0                   # s = 0

            move    $s3     $a0
for1:       beq     $s3     $s1     endfor
            add     $a0     $s3     2
            jal     g
            sw      $v0     ($s0)
            addi    $s0     $s0     8           #4B * 2
            addi    $s1     $s1     2
            b       for1

g:          li      $t0     2
            rem     $t1     $a0     $t0
            beqz    $t1     if
else:       li      $t2     -1
            mult    $v0     $a0     $t2
            b       endg
if:         mult    $v0     $a0     $a0
            addi    $v0     $v0     2
endg:       jr      $ra
