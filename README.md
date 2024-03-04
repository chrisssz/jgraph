# read_bmp.sh Instructions
First off run make, and wait a bit, as it is taking time to compile all the files pretties.

The input file must be argument after read_bmp.sh. The input must be 24-bit and exported without color space information. I recommend using GIMP, as the option to "Do not write color space information" is readily available during exporting.

To prevent the graph going outside the bounds of the image, the maximum size of the bmp should be 95 x 145 pixels.

To run the program, the input must be in the same directory as "read_bmp.sh". There must also be a "read_bmp.jgr" which there should be if you've ran the make command.

The two commands to create the new image are:
"sh read_bmp.sh 'bmp-of-choice'"
"jgraph -P read_bmp.jgr | ps2pdf - | convert -density 300 - -quality 100 'custom_name'.jpg"

Of course, remove the quotations and replace 'custom_name' with your desired output file name (get rid of the single quotes as well).

Please be patient while read_bmp.sh runs, at its maximum recommended size, it is creating 13780 lines of jgraph code.
