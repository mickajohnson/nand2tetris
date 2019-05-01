// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(LOOP)
    @KBD
    D=M
    @KEY_PRESSED
    D;JGT
    @KEY_UNPRESSED
    @LOOP
    0;JMP

(KEY_PRESSED)
    // set screen address to new var so dont mutate sacred var
    @SCREEN
    D=A
    @address
    M=D

(DRAWING_LOOP)
    @KBD
    D=A-1 // set d to end of screen map (right before start of keyboard)
    
    @address
    D=D-M
    @LOOP
    D;JLE

    // Meat of loop
    @address
    M=M+1 // current address is base address + current iteration
    A=M
    M=-1

    @i
    M=M+1 // i++
    @DRAWING_LOOP
    0;JMP

// Ideally dry this up

(KEY_UNPRESSED)
    // set screen address to new var so dont mutate sacred var
    @SCREEN
    D=A
    @address
    M=D

(UNDRAWING_LOOP)
    @KBD
    D=A-1 // set d to end of screen map (right before start of keyboard)
    
    @address
    D=D-M
    @LOOP
    D;JLE

    // Meat of loop
    @address
    M=M+1 // current address is base address + current iteration
    A=M
    M=0

    @i
    M=M+1 // i++
    @UNDRAWING_LOOP
    0;JMP