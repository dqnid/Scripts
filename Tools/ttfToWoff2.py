#!/bin/bash
# Dependencies:
# $ pip install fontTools
# $ pip install brotli
from fontTools.ttLib import TTFont
import sys
if len(sys.argv) != 2:
    raise ValueError('Argumentos incorrectos:\n $ python ttfToWoff2.py fuente.tipo')
f = TTFont(sys.argv[1])
f.flavor='woff2'
f.save(sys.argv[1]+'.woff2')
