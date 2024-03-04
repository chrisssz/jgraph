# read_bmp Instructions
To initially compile, run make. Ensure the "examples" file is in the same directory as the makefile and read_bmp.c

The input file must be argument after read_bmp. The input must be 24-bit and exported without color space information. I recommend using GIMP, as the option to "Do not write color space information" is readily available during exporting.

To avoid a Floating Point Exception keep the image around 200x200px. I recommend hard capping at 200x200.

To run the program, the input must be the correct path to your input image. There must also be a "read_bmp.jgr" which there should be if you've ran the make command.

The two commands to create the new image are:
"./read_bmp 'input_bmp'.bmp"
"jgraph read_bmp.jgr | convert -density 300 - -quality 100 'custom_name'.jpg"

Of course, remove the quotations and replace'input_bmp' and 'custom_name' with your desired input file and output file name (get rid of the single quotes as well).

Update - 1


