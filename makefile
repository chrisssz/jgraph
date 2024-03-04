.PHONY: all clean

all:read_bmp.jgr
	@sh read_bmp.sh ./examples/colors.bmp
	@jgraph -P read_bmp.jgr | ps2pdf - | convert -density 300 - -quality 100 example0.jpg
	@sh read_bmp.sh ./examples/9x9.bmp
	@jgraph -P read_bmp.jgr | ps2pdf - | convert -density 300 - -quality 100 example1.jpg
	@sh read_bmp.sh ./examples/10x10.bmp
	@jgraph -P read_bmp.jgr | ps2pdf - | convert -density 300 - -quality 100 example2.jpg
	@sh read_bmp.sh ./examples/weird1.bmp
	@jgraph -P read_bmp.jgr | ps2pdf - | convert -density 300 - -quality 100 example3.jpg
	@sh read_bmp.sh ./examples/ex-ha.bmp
	@jgraph -P read_bmp.jgr | ps2pdf - | convert -density 300 - -quality 100 example4.jpg

read_bmp.jgr:
	touch read_bmp.jgr


clean:
	rm -f read_bmp.jgr
	rm -f example0.jpg
	rm -f example1.jpg
	rm -f example2.jpg
	rm -f example3.jpg
	rm -f example4.jpg
