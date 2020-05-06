#!/bin/sh

export PATH="/usr/local/opt/gettext/bin:$PATH"

DIDBUILD=0

CELESTIA_ROOT=$BUILT_PRODUCTS_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH/CelestiaResources
CELESTIA_REPO_ROOT=`pwd`/../Celestia

LOCALE_ROOT=$CELESTIA_ROOT/locale

mkdir -p $LOCALE_ROOT

convert_po()
{
    POT=$CELESTIA_REPO_ROOT/$1/$2.pot
    for po in $CELESTIA_REPO_ROOT/$1/*.po; do
        f=${po##*/};f=${f%.*}
        LANG_ROOT=$LOCALE_ROOT/$f/LC_MESSAGES
        mkdir -p $LANG_ROOT
        if [ $po -nt $LANG_ROOT/$2.mo ];then
            echo "Create $LANG_ROOT/$2.mo"
            msgmerge --quiet --output-file=$PROJECT_TEMP_DIR/$f.po --lang=$f --sort-output $po $POT
            msgfmt -o $LANG_ROOT/$2.mo $PROJECT_TEMP_DIR/$f.po
            DIDBUILD=1
        fi
    done
}

convert_po "po" "celestia"
convert_po "po2" "celestia_constellations"
convert_po "po3" "celestia_ui"

if [ $DIDBUILD -eq 1 ];then
    echo "Touch $BUILT_PRODUCTS_DIR/$PRODUCT_NAME.app"
    touch -c $BUILT_PRODUCTS_DIR/$PRODUCT_NAME.app
fi
