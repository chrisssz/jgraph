#!/bin/bash

checker=$(hexdump -ve '1/1 "%.2x"' $1 | tr -d '\n')
header=$(hexdump -ve '1/1 "%.2x"' -n 54 $1 | tr -d '\n')
image="$(hexdump -ve '1/1 "%.2x"' -s 54 $1 | tr -d '\n')"

w="${header:36:2}"
w=$(printf "%d" "0x$w")
h="${header:44:2}"
h=$(printf "%d" "0x$h")
pad=$(((4-((w*3)%4))*2))
wid=$((w*6))
size=$(((wid*h)))

if (( pad == 8 )); then
    pad=0
    fi

wsize=$(echo "scale=2; $w / 12" |bc)
hsize=$(echo "scale=2; $h / 12" |bc)

if (( ${#checker} != ${#image}+108)); then
    printf "Error: Improper image format\n  Usage: 24 bit .bmp file. Do not write color space information."
    fi

printf "newgraph\n" > read_bmp.jgr
printf "xaxis min 0 max %d no_draw_axis\n" "$w" >> read_bmp.jgr
printf "size %s no_draw_hash_marks no_auto_hash_labels\n" "$wsize" >> read_bmp.jgr
printf "yaxis min 0 max %d no_draw_axis\n" "$h" >> read_bmp.jgr
printf "size %s no_draw_hash_marks no_auto_hash_labels\n" "$hsize" >> read_bmp.jgr

for (( i = 0; i < ${#image}; i+=wid+pad )) do
    temp="${image:i:wid}"
    real="$real$temp"
    done

for (( i = 0; i < $size; i+=6 )) do
    red="${real:i+4:2}"
    red=$(printf "%d" "0x$red")
    red=$(echo "scale=3; $red /255" |bc)
    green="${real:i+2:2}"
    green=$(printf "%d" "0x$green")
    green=$(echo "scale=3; $green / 255" |bc)
    blue="${real:i:2}"
    blue=$(printf "%d" "0x$blue")
    blue=$(echo "scale=3; $blue / 255" |bc)
    
    lumen=$(echo "1000000*((0.2126*$red)+(0.7152*$green)+(0.0722*$blue))" |bc)
    lumen=$(printf "%.0f" "$lumen")

    if (( lumen < 50000 )); then
        ascii="@"
        fi
    if (( lumen >= 50000 && lumen < 100000 )); then
        ascii="#"
        fi
    if (( lumen >= 100000 && lumen < 150000 )); then
        ascii="$"
        fi
    if (( lumen >= 150000 && lumen < 200000 )); then
        ascii="&"
        fi
    if (( lumen >= 200000 && lumen < 250000 )); then
        ascii="%"
        fi
    if (( lumen >= 250000 && lumen < 300000 )); then
        ascii="8"
        fi
    if (( lumen >= 300000 && lumen < 350000 )); then
        ascii="o"
        fi
    if (( lumen >= 350000 && lumen < 400000 )); then
        ascii="+"
        fi
    if (( lumen >= 400000 && lumen < 450000 )); then
        ascii="="
        fi
    if (( lumen >= 450000 && lumen < 500000 )); then
        ascii="|"
        fi
    if (( lumen >= 500000 && lumen < 550000 )); then
        ascii="/"
        fi
    if (( lumen >= 550000 && lumen < 600000 )); then
        ascii="i"
        fi
    if (( lumen >= 600000 && lumen < 650000 )); then
        ascii="!"
        fi
    if (( lumen >= 650000 && lumen < 700000 )); then
        ascii=":"
        fi
    if (( lumen >= 700000 && lumen < 750000 )); then
        ascii="-"
        fi
    if (( lumen >= 750000 && lumen < 800000 )); then
        ascii="'"
        fi
    if (( lumen >= 800000 && lumen < 850000 )); then
        ascii=","
        fi
    if (( lumen >= 850000 && lumen < 900000 )); then
        ascii="."
        fi
    if (( lumen >= 900000 && lumen < 950000 )); then
        ascii="\`"
        fi
    if (( lumen >= 950000 && lumen < 1000000 )); then
        ascii=" "
        fi

    x=$(($((i/6)) %w ))
    y=$(($((i/6)) /w ))

    printf "newstring hjc vjc x %s y %s fontsize 9 lcolor %s %s %s : %s\n" "$x" "$y" "$red" "$green" "$blue" "$ascii" >> read_bmp.jgr

    done






