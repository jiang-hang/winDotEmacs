#! /usr/bin/bash

echo "ad Conv Sync"

cd ~/blog/html

ff=`ls -1 *.html`

for mf in $ff
do
    utf=`enca -L zh_CN $mf | grep -i UTF`
    if [ -z "$utf" ] ; then
    iconv  -f gbk -t utf-8  $mf > tt.utf8
    mv tt.utf8 $mf
    echo "convert $mf is done"
    fi
done

chmod 644 *.html

rsync -avz *.html  wp.bagualu.net:/var/www/bagualu/markdown/

rm *.html

rsync -avz ~/blog/rfigures/*.png  wp.bagualu.net:/var/www/bagualu/wordpress/archives/rfigures/



