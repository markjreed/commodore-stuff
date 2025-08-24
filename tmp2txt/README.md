This shell script is designed to help you convert source code saved
from the C64 Turbo Macro Pro assembler onto a disk image into a plain
text file suitable for cross-assembly with other tools. In particular
Tass64 has essentially the same syntax and can assemble most TMP programs.

    Usage: tmp2txt diskimage.d64 filename [...]

The disk image must contain TMP as well as the program to convert. The
script will launch VICE for you and place commands for you to paste into
TMP to write out the source in text form back onto the image. It will then
extract the text source, convert from PETSCII to standard ASCII, and save
it as a file on the local filesystem.
