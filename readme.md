# 8-Bit Computer

## Introduction
This project is a simple simulator for an 8-bit computer that operates using a few basic instructions, which are discussed below.

## Instruction Set
- `load A`: Loads data from the specified address into register `A`.
- `load B`: Loads data from the specified address into register `B`.
- `load output`: Loads data from the specified address into the output register.

- `store A`: Stores the value in register `A` at the specified address.
- `store B`: Stores the value in register `B` at the specified address.
- `store input`: Stores the value in the input register at the specified address.

- `A = A + B`: Adds the value in register `B` to the value in register `A` and stores the result in register `A`.
- `A = A - B`: Subtracts the value in register `B` from the value in register `A` and stores the result in register `A`.
- `A = A + 1`: Increments the value in register `A` by 1.
- `A = A - 1`: Decrements the value in register `A` by 1.

- `A = A & B`: Performs a logical AND operation on the values in registers `A` and `B` and stores the result in register `A`.
- `A = A | B`: Performs a logical OR operation on the values in registers `A` and `B` and stores the result in register `A`.
- `A = A xor B`: Performs a logical XOR operation on the values in registers `A` and `B` and stores the result in register `A`.
- `A = !A`: Negates the value in register `A`.

- `jump address`: Jumps to the specified address in the program.
- `stop`: Stops the program.

## Instruction Format
Instructions in this 8-bit computer consist of two parts: the operation code (op code) and the address. The op code is a 4-bit code that specifies how the instruction is to be executed, while the address is a 4-bit value that specifies the location of the instruction.

The table below shows the op codes for each instruction:


<table> <thead> <tr> <th>Op Code</th> <th>Instruction</th> </tr> </thead> <tbody> <tr> <td>0000+address</td> <td>load A</td> </tr> <tr> <td>0001+address</td> <td>load B</td> </tr> <tr> <td>0010+address</td> <td>load output</td> </tr> <tr> <td>0011+address</td> <td>store A</td> </tr> <tr> <td>0100+address</td> <td>store B</td> </tr> <tr> <td>0101+address</td> <td>store input</td> </tr> <tr> <td>0110+xxxx</td> <td>A = A + B</td> </tr> <tr> <td>0111+xxxx</td> <td>A = A - B</td> </tr> <tr> <td>1000+xxxx</td> <td>A = A + 1</td> </tr> <tr> <td>1001+xxxx</td> <td>A = A - 1</td> </tr> <tr> <td>1010+xxxx</td> <td>A = A && B</td> </tr> <tr> <td>1011+xxxx</td> <td>A = A || B</td> </tr> <tr> <td>1100+xxxx</td> <td>A = A xor B</td> </tr> <tr> <td>1101+xxxx</td> <td>A = !A</td> </tr> <tr> <td>1110+address</td> <td>jump address</td> </tr> <tr> <td>1111+xxxx</td> <td>stop</td> </tr> </tbody> </table>






## Sample Code
As an example, the code below adds two numbers:

``` 0000 0001 // Load A from address 0001
0001 0010 // Load B from address 0010
0110 0000 // A = A + B
0011 0100 // Store A at address 0100
1111 0000 // Stop 
```
In this code, two numbers are loaded from addresses `0001` and `0010`, then added using the `A = A + B` instruction. The result is then stored at address `0100`, and the program is stopped using the `stop` instruction.

## Support
This project is available on GitHub at [https://github.com/Omid-Zahed/8-bit-computer](https://github.com/Omid-Zahed/8-bit-computer). If you have any questions or need help, feel free to use the `Issues` section on GitHub.