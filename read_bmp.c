#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv){
const int BUFFER_SIZE = 250000;
int track, pad, pixw, size, padt, lumen, x, y;
long w, h, s, r,b,g;
double red, green, blue;
char c, ascii, cbuf[2], *buf, *wid, *height, *endp, *real, thex[500];
FILE* f, *write;

f = fopen(argv[1], "r");
if(f == NULL){
	printf("Can't open image\n");
	exit(1);
	}
write = fopen("read_bmp.jgr", "w");
if(write == NULL){
	printf("Can't openj read_bmp.jgr\n");
	exit(1);
}

cbuf[1] = '\0';
track = 0;
buf = (char *)malloc(sizeof(char)*500);
wid = (char *)malloc(sizeof(char)*10);
height = (char *)malloc(sizeof(char)*10);
real = (char *)malloc(sizeof(char)*BUFFER_SIZE);


while(!feof(f)){
	c = fgetc(f);
	cbuf[0] = c;
	sprintf(buf, "%.2x", (unsigned char) c);
	if(track == 28){
		if((unsigned char) c != 24){
			printf("Error: Improper image format\n  Usage: 24 bit .bmp file. Do not write color space information");
		}
	}
	if(track == 18){
		strcat(wid,buf);
		w = strtol(wid, &endp, 16);
		free(wid);
		}
	if(track == 22){
		strcat(height,buf);
		h = strtol(height, &endp, 16);
		free(height);
		}
	if(track == 53){
		pad=4-((w*3)%4);
		pixw= w*3;
		size= pixw*h;
		if(pad == 4) pad = 0;
		//printf("Pad = %d\n", pad);
		padt = 0;
		break;
		}

	track++;
	buf[0] = '\0';
	buf[1]='\0';
	}
while(!feof(f)){
	c = fgetc(f);
	cbuf[0] = c;
	sprintf(buf, "%.2x", (unsigned char) c);	
	if((padt%pixw)-((padt/pixw)-1) != 0 && pad != 0){
		//real[realt] = c;
		strcat(real,cbuf);
		if(!strcmp(buf, "00")){
			int t = 0x01;
			c = (unsigned char) t;
			cbuf[0] = c;
			strcat(real, cbuf);
			}
		padt++;
		}
	else if((padt%pixw)-((padt/pixw)-1) == 0 && pad != 0){
		//printf("Pad: %d %d %s", track, padt, buf);
		padt++;
		for(int i = 0; i < pad-1; i++){
			c=fgetc(f);
			//padt++;
			}
		}
	if(pad == 0){
		strcat(real,cbuf);//real[realt] = c;
		if(!strcmp(buf, "00")){
			int t = 0x01;
			c = (unsigned char) t;
			cbuf[0] = c;
			strcat(real, cbuf);
			}
		padt++;
		}	
	buf[0] = '\0';
	buf[1]='\0';
	}

free(buf);

s=strlen(real);

fprintf(write, "newgraph\n");
fprintf(write, "xaxis min 0 max %ld no_draw_axis\n", w);
fprintf(write, "size %ld no_draw_hash_marks no_auto_hash_labels\n", w/12);
fprintf(write, "yaxis min 0 max %ld no_draw_axis\n", h);
fprintf(write, "size %ld no_draw_hash_marks no_auto_hash_labels\n", h/12);

for(int i = 0; i < s-3; i+=3){
	sprintf(thex, "%.2x", (unsigned char) real[i+2]);
	r = strtol(thex, &endp, 16);
	red = (double) r/255;
	thex[0] = '\0';
	thex[1] = '\0';
	sprintf(thex, "%.2x", (unsigned char) real[i+1]);
	g = strtol(thex, &endp, 16);
	green = (double) g/255;
	thex[0] = '\0';
	thex[1] = '\0';
	sprintf(thex, "%.2x", (unsigned char) real[i]);
	b = strtol(thex, &endp, 16);
    blue = (double) b/255;
	thex[0] = '\0';
	thex[1] = '\0';
	lumen=1000000*((0.2126*red)+(0.7152*green)+(0.0722*blue));


	if (lumen < 50000 ){
        ascii='@';
		}
    if (lumen >= 50000 && lumen < 100000){
        ascii='#';
        }
    if(lumen >= 100000 && lumen < 150000 ){
        ascii='$';
        }
    if(lumen >= 150000 && lumen < 200000 ){
        ascii='&';
        }
    if(lumen >= 200000 && lumen < 250000 ){
        ascii='%';
        }
    if(lumen >= 250000 && lumen < 300000 ){
        ascii='8';
        }
    if(lumen >= 300000 && lumen < 350000 ){
        ascii='o';
        }
    if(lumen >= 350000 && lumen < 400000 ){
        ascii='+';
        }
    if(lumen >= 400000 && lumen < 450000 ){
        ascii='=';
        }
    if(lumen >= 450000 && lumen < 500000 ){
        ascii='|';
        }
    if(lumen >= 500000 && lumen < 550000 ){
        ascii='/';
        }
    if(lumen >= 550000 && lumen < 600000 ){
        ascii='i';
        }
    if(lumen >= 600000 && lumen < 650000 ){
        ascii='!';
        }
    if(lumen >= 650000 && lumen < 700000 ){
        ascii=':';
        }
    if(lumen >= 700000 && lumen < 750000 ){
        ascii='-';
        }
    if(lumen >= 750000 && lumen < 800000 ){
        ascii='*';
        }
    if(lumen >= 800000 && lumen < 850000 ){
        ascii=',';
        }
    if(lumen >= 850000 && lumen < 900000 ){
        ascii='.';
        }
    if(lumen >= 900000 && lumen < 950000 ){
        ascii='\'';
        }
    if(lumen >= 950000 && lumen <= 1000000 ){
        ascii=' ';
        }

	x = (i/3)%w;
	y = (i/3)/w;

	fprintf(write, "newstring hjc vjc x %d y %d fontsize 9 lcolor %f %f %f : %c\n", x, y, red, green, blue, ascii);

}

fclose(f);
fclose(write);

}
