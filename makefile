.PHONY: all clean

all:read_bmp.jgr
	@echo "Compiling..."
	@gcc -o read_bmp read_bmp.c
	@echo "Complete!"
	@echo "Creating example0.jpg"
	@./read_bmp ./examples/colors.bmp
	@jgraph read_bmp.jgr | convert -density 300 - -quality 100 example0.jpg
	@echo "Complete!"
	@echo "Creating example1.jpg"
	@./read_bmp ./examples/200x200.bmp
	@jgraph read_bmp.jgr | convert -density 300 - -quality 100 example1.jpg		
	@echo "Complete!"
	@echo "Creating example2.jpg"
	@./read_bmp ./examples/ex-ha.bmp
	@jgraph read_bmp.jgr | convert -density 300 - -quality 100 example2.jpg
	@echo "Complete!"
	@echo "Creating example3.jpg"
	@./read_bmp ./examples/ex-mon.bmp
	@jgraph read_bmp.jgr | convert -density 300 - -quality 100 example3.jpg
	@echo "Complete!"
	@echo "Creating example4.jpg"
	@./read_bmp ./examples/ex-adv.bmp
	@jgraph read_bmp.jgr | convert -density 300 - -quality 100 example4.jpg
	@echo "Complete!"

read_bmp.jgr:
	touch read_bmp.jgr


clean:
	rm -f read_bmp
	rm -f read_bmp.jgr
	rm -f example0.jpg
	rm -f example1.jpg
	rm -f example2.jpg
	rm -f example3.jpg
	rm -f example4.jpg
	
