#! /usr/bin/bash

cd ~/blog/html

ff=`ls -1 *.html`

for mf in $ff
do
    iconv  -f gbk -t utf-8  $mf > tt.utf8
    mv tt.utf8 $mf
    echo "convert $mf is done"
done

rsync -avz *.html  wp.bagualu.net:/var/www/bagualu/markdown/

rm *.html

rsync -avz ~/blog/rfigures/*.png  wp.bagualu.net:/var/www/bagualu/wordpress/archives/rfigures/



