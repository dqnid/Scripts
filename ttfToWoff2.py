from fontTools.ttLib import TTFont
f = TTFont('.otf')
f.flavor='woff2'
f.save('path/file.woff2')
