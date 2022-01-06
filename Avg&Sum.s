.section .data

_sum:.double 0    
_n:.int 0    
_tmp: .double 0    
_avg: .double 0
_count: .int 0
_input:.asciz "%d\0"
_inputnum: .asciz "%lf\0"
_output: .asciz "sum=%lf avg=%lf\0"

    .section .text
    .globl    _main
_main:
    pushl    $_n          # scanf with input n;
    pushl    $_input
    call    _scanf
    addl    $8, %esp

    movl    _n, %eax            # count = n
    movl    %eax, _count

    jmp        comp_loop
loop1:
    pushl    $_tmp + 4       # scanf with inputnum  and tmp
    pushl    $_tmp
    pushl    $_inputnum
    call    _scanf
    addl    $12, %esp

    fldl    _sum
    fldl    _tmp
    faddp    %st, %st(1)            # sum = sum + tmp
    fstpl    _sum
    
    movl    _count, %eax        
    dec        %eax            # count = count - 1
    movl    %eax, _count

comp_loop:
    movl    _count, %eax        # while count != 0
    testl    %eax, %eax            # tests whether eax is 0, or above, or below.
    jne    loop1

    fldl    _sum
    fildl    _n
    fdivrp    %st, %st(1)
    fstpl    _avg

    
    pushl    _avg + 4           # print the sum and avg in output format 
    pushl   _avg
    pushl   _sum + 4
    pushl   _sum
    pushl   $_output
    call    _printf
    addl $20, %esp
    movl    $0, %eax
    ret
    