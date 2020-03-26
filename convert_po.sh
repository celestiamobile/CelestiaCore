#!/bin/sh

DIDBUILD=0

CELESTIA_ROOT=$BUILT_PRODUCTS_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH/CelestiaResources
LOCALE_ROOT=$CELESTIA_ROOT/locale

mkdir -p $LOCALE_ROOT

POT=$SRCROOT/../Celestia/po/celestia.pot

for po in $SRCROOT/../Celestia/po/*.po; do
    f=${po##*/};f=${f%.*}
    LANG_ROOT=$LOCALE_ROOT/$f/LC_MESSAGES
    mkdir -p $LANG_ROOT
    if [ $po -nt $LANG_ROOT/celestia.mo ];then
        echo "Create $LANG_ROOT/celestia.mo"
        msgmerge --quiet --output-file=$PROJECT_TEMP_DIR/$f.po --lang=$f --sort-output $po $POT
        msgfmt -o $LANG_ROOT/celestia.mo $PROJECT_TEMP_DIR/$f.po
        DIDBUILD=1
    fi
done

POT=$SRCROOT/../Celestia/po2/celestia_constellations.pot

for po in $SRCROOT/../Celestia/po2/*.po; do
    f=${po##*/};f=${f%.*}
    LANG_ROOT=$LOCALE_ROOT/$f/LC_MESSAGES
    mkdir -p $LANG_ROOT
    if [ $po -nt $LANG_ROOT/celestia_constellations.mo ];then
        echo "Create $LANG_ROOT/celestia_constellations.mo"
        msgmerge --quiet --output-file=$PROJECT_TEMP_DIR/$f.po --lang=$f --sort-output $po $POT
        msgfmt -o $LANG_ROOT/celestia_constellations.mo $PROJECT_TEMP_DIR/$f.po
        DIDBUILD=1
    fi
done
if [ $DIDBUILD -eq 1 ];then
    echo "Touch $BUILT_PRODUCTS_DIR/$PRODUCT_NAME.app"
    touch -c $BUILT_PRODUCTS_DIR/$PRODUCT_NAME.app
fi

