# Lab4 Pipelined CPU

 implementing a simple version 5-stage pipelined CPU

![](./lab4_arichitecture.png)

[implementation_elaboration](./implementation_elaboration.md)
## basic instructions supported

+ ADD
+ ADDI
+ SUB
+ AND
+ OR
+ SLT
+ SLTU
+ SLL
+ SLLV
+ LUI
+ ORI
+ LW
+ SW
+ MUL

## Advanced feature

BEQ, BNE insrtuctions added 

Having **Hazard Detection** and **Forwarding machanism**



# instruction format

## R-type

|Instruciton | Example | Meaning | OP field | Function field |check|
|:-:        |:-:   |:-:| :-:|:-:|:-:|
|SLL| sll r1,r2,10| r1 = r2<<10 | 0 | 0 | ok|
|SLLV| sllv r1,r2,r3| r1 = r2<<r3 | 0 | 4 |ok|
|MUL| mul r1,r2,r3| r1 = r2*r3| 0 | 24(0x18) |ok|
|ADD| add r1,r2,r3| r1 = r2+r3| 0 | 32(0x20) | ok| 
|SUB| sub r1,r2,r3| r1 = r2-r3| 0 | 34(0x22) |ok|
|AND| and r1,r2,r3| r1 = r2&r3| 0 | 36(0x24) |ok| 
|OR| or r1,r2,r3| r1 = r2\|r3| 0 | 37(0x25) | ok|
|SLT| slt r1,r2,r3| r1 = (r2<r3) ? 1:0 | 0 | 42(0x2a) |ok|
|SLTU| sltu r1,r2, r3(unsigned)| r1 = (r2<r3) ? 1:0 | 0 | 43(0x2b) |ok|



## I-type
**No funct field exists** 

|Instruciton|Example | Meaning | OP field| Rs | Rt| immdt(in example) |check|
|:-:|:-:|:-:|:-:|:-:| :-:|:-:|:-:|
|BEQ|bne r1,r2,25 |if( r1==r2) goto **(PC+4)**+100| 4 |r2|r1|25|ok|
|BNE|bne r1,r2,30 |if( r1!=r2) goto **(PC+4)**+120| 5 |r2|r1|30|ok|
|ADDI|addi r1,r2,100 |r1=r2+100| 8 |r2|r1|100|ok|
|ORI|ori r1,r2,100 |r1=r2\|100| 13 |r2|r1|100|ok|
|LUI|lui r1,10 | r1 = 10<<16| 15 |x|r1|10|ok|
|LW|lw r1,r2,12| r1=MEM[r2+12]| 35 |r2|r1|12|ok|
|SW|sw r1,r2,12| MEM[r2+12]=r1| 43 |r2|r1|12|ok|


 