#!/bin/sh

PATH="$PATH:~/Qt/5.12.9/ios/bin"

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_de.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_de.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_es.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_es.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_fr.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_fr.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_it.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_it.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_ja.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_ja.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_ko.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_ko.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_ru.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_ru.qml.ts

lupdate -locations absolute ../sakura.pro -ts ../translations/sakura_zh.src.ts
lupdate -locations absolute ../qml        -ts ../translations/sakura_zh.qml.ts

lconvert ../translations/sakura_de.src.ts ../translations/sakura_de.qml.ts -o ../translations/sakura_de.ts
lconvert ../translations/sakura_es.src.ts ../translations/sakura_es.qml.ts -o ../translations/sakura_es.ts
lconvert ../translations/sakura_fr.src.ts ../translations/sakura_fr.qml.ts -o ../translations/sakura_fr.ts
lconvert ../translations/sakura_it.src.ts ../translations/sakura_it.qml.ts -o ../translations/sakura_it.ts
lconvert ../translations/sakura_ja.src.ts ../translations/sakura_ja.qml.ts -o ../translations/sakura_ja.ts
lconvert ../translations/sakura_ko.src.ts ../translations/sakura_ko.qml.ts -o ../translations/sakura_ko.ts
lconvert ../translations/sakura_ru.src.ts ../translations/sakura_ru.qml.ts -o ../translations/sakura_ru.ts
lconvert ../translations/sakura_zh.src.ts ../translations/sakura_zh.qml.ts -o ../translations/sakura_zh.ts
