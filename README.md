# MIPS Text message Encryption & Decryption

## Overview

MIPS Assembly implementation of a Caesar cipher encryption and
decryption system for English text files.

The project uses a dynamic shift value based on the maximum word
length of the input text and supports both encryption and decryption.

## Features

- Caesar cipher encryption and decryption
- Dynamic shift value based on maximum word length
- File-based input and output
- Removal of non-alphabetic characters
- Conversion of uppercase characters to lowercase
- Alphabet wrapping during encryption and decryption
- User selection between encryption and decryption

## How It Works

### Encryption

1. The user selects encryption mode.
2. The program reads the input text file.
3. Non-alphabetic characters are removed.
4. Uppercase letters are converted to lowercase.
5. The maximum word length is calculated and used as the shift value.
6. Each character is shifted using the Caesar cipher.
7. The encrypted text is written to the output file.

### Decryption

1. The user selects decryption mode.
2. The program reads the cipher text file.
3. The maximum word length is calculated to determine the shift value.
4. The Caesar shift is reversed.
5. The decrypted text is written to the output file.

## Main Procedures

| Procedure | Description |
|---|---|
| `RemoveNonAlpha` | Removes non-alphabetic characters from the input |
| `UppertoLower` | Converts uppercase letters to lowercase |
| `ShiftValue` | Calculates the maximum word length used as the shift value |
| `ShiftString` | Encrypts the input using the Caesar cipher |
| `UndoShiftString` | Decrypts the encrypted text |

## Technologies

- MIPS Assembly
- Low-level programming
- ASCII character processing
- File I/O
- String manipulation

## What I Learned

- Working with MIPS registers and memory
- Implementing string-processing algorithms in Assembly
- Handling file input/output using system calls
- Working with ASCII character representations
- Implementing loops, branches, and subroutines
- Designing encryption and decryption logic at the assembly level
