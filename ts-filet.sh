#!/bin/sh
#

LUPDATE="/Users/Tero/QtSDK/Desktop/Qt/4.8.0/gcc/bin/lupdate"
#LUPDATE="/c/QtSDK/Desktop/Qt/4.8.1/mingw/bin/lupdate"
`echo $LUPDATE . -recursive -no-obsolete -ts tolppa-apuri_fi.ts`
`echo $LUPDATE . -recursive -no-obsolete -ts tolppa-apuri_en.ts`
`echo $LUPDATE . -recursive -no-obsolete -ts tolppa-apuri_sv.ts`
