# Lab1  
## implement a basic 32-bit ALU

**1. The Source Codes are in the "sourceCode" directory**

# Architecture Diagrams
![ALU.png](./ALU.png)
![small_modules](./small_module.png)

## ALU I/O
```Verilog
    module alu(

           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
           bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );
``` 
### Supported instructions 
+ And 
+ Or 
+ Add
+ Sub 
+ Nor
+ Nand
+ SET ( with bonus_control input ) 

|ALU action | Name | ALU_control |
|:-:        |:-:   |:-:|
|And|And|0000|
|Or|Or|0001|
|Add|Addition|0010|
|Sub|Substract|0110|
|Nor|Nor|1100|
|Nand|Nand|1101|
|Set|Set|0111|

__Bonus_instruction_set__

|ALU action | Name | ALU_control |
|:-:        |:-:   |:-:|
|Slt|Set less than|0111_000|
|Sgt|Set great than|0111_001|
|Sle|Set less equal|0111_010|
|Sge|Set great equal|0111_011|
|Seq|Set equal|0111_110|
|Sne|Set not equal|0111_100|

## Specification:
1. Start to work after rst_n raised 
