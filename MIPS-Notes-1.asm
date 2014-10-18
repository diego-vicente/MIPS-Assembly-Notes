# Calculate 1+2+3+4...+10

            li      $t0     0                   # // index
            li      $t1     0                   # // result
            li      $t2     10                  # // condition

while:      bge     $t0     $t2     end         # while (t0>=t2) {
            add     $t1     $t1     $t0         #   t1 += t0;
            addi    $t0     $t0     $t1         #   t0++
            b       while                       # }
end:        ...

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
end:        ...

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
end:        ...
