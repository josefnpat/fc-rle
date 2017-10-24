cat demo.lua > demo_full.lua

for f in images/*.png; do
  echo "processing $f"
  if [ ! -f ${f%.png}.rle ]; then
    sh png2rle.sh $f > "${f%.png}.rle";
  fi
  echo -n "a(d,'" >> demo_full.lua
  cat "${f%.png}.rle" | tr -d '\n' >> demo_full.lua
  echo "')" >> demo_full.lua
done
