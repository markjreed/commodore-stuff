This is a VIC-20 port of a small routine to add hexadecimal literals to BASIC
2.0, as featured in Raeto Collin West's [Programming the Commmodore 64: The
Definitive
Guide](https://www.amazon.com/Programming-Commodore-64-definitive-guide/dp/0874550815)
and improved by Robin Harbron in [this 8-Bit Show and Tell
video](https://www.youtube.com/watch?v=I8GuyK-1DmQ).

The VIC-20 has the same indirect vectors as the C-64 and corresponding ROM
routines, but with one significant difference: the ROM routine to convert an
integer to floating-point treats the integer as signed instead of unsigned.  If you
ran the original port and then tried to set the screen colors with something
like `POKE $900F, 8` it would be read as `POKE -28657, 8` and generate an
`?ILLEGAL QUANTITY ERROR`! So I added a check of the sign bit and a call
to the floating point add routine with a constant 65536.0 whenever hte
result was negative. Now it works the same on the VIC as on the 64.

Files:

| File | Description |
|------| -------     |
| evalhex.s          | CA65-formatted assembly source for the raw routine
| evalhex.seq        | The same, but in PETSCII format
| evalhex.bin        | Compiled binary built from the above; loads directly into the cassette buffer via `LOAD,8,1`
| evalhex\_poker.p00 | A BASIC program that POKEs the routine into memory and then calls it.
| evalhex.d64        | Diskette image with all of the above files
| evalhex\_poker.bas | ASCII source for the above BASIC program
| makepoker.sh       | A script to generate the ASCII BASIC from the compiled binary



