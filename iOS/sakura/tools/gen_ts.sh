#!/bin/sh

PATH=$PATH:~/Qt/5.9.1/ios/bin

lupdate ../sakura.pro -ts ../translations/sakura_ru.src.ts
lupdate ../qml        -ts ../translations/sakura_ru.qml.ts

lupdate ../sakura.pro -ts ../translations/sakura_ja.src.ts
lupdate ../qml        -ts ../translations/sakura_ja.qml.ts

lconvert ../translations/sakura_ru.src.ts ../translations/sakura_ru.qml.ts -o ../translations/sakura_ru.ts
lconvert ../translations/sakura_ja.src.ts ../translations/sakura_ja.qml.ts -o ../translations/sakura_ja.ts
