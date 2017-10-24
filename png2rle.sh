TEMP=$(mktemp)

sh png2raw.sh $1 > $TEMP.raw
lua raw2gfx.lua $TEMP.raw > $TEMP.gfx
lua gfx2rle.lua $TEMP.gfx > $TEMP.rle
cat $TEMP.rle
