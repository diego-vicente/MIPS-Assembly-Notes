# Calculate 1+2+3+4...+10

            li      $t0     0
            li      $t1     0
            li      $t2     10

while:      bge     $t0     $t2     end         # while (t0>=t2) {
            add     $t1     $t1     $t0         #   t1 += t0;
            addi    $t0     $t0     $t1         #   t0++
            b       while                       # }
end:        ...
