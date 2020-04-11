#!/bin/sh

DIDCOPY=0

CELESTIA_ROOT=$BUILT_PRODUCTS_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH/CelestiaResources

mkdir -p $CELESTIA_ROOT

CELESTIA_REPO_ROOT=$SRCROOT/../Celestia
CELESTIA_CONTENT_REPO_ROOT=$CELESTIA_REPO_ROOT/content

for directory in 'fonts' 'images' 'locale' 'scripts' 'shaders';do
    f=$CELESTIA_REPO_ROOT/$directory
    if [ $f -nt $CELESTIA_ROOT/$directory ];then
        echo "rsync -rv --quiet --exclude=CMakeLists.txt $f $CELESTIA_ROOT"
        rsync -rv --quiet --exclude=CMakeLists.txt $f $CELESTIA_ROOT
        DIDCOPY=1
    fi
done

for directory in 'data' 'extras' 'extras-standard' 'models' 'textures';do
    f=$CELESTIA_CONTENT_REPO_ROOT/$directory
    if [ $f -nt $CELESTIA_ROOT/$directory ];then
        echo "rsync -rv --quiet --exclude=CMakeLists.txt $f $CELESTIA_ROOT"
        rsync -rv --quiet --exclude=CMakeLists.txt $f $CELESTIA_ROOT
        DIDCOPY=1
    fi
done

for file in "celestia.cfg" "controls.txt" "demo.cel" "guide.cel" "start.cel" "COPYING" "AUTHORS" "TRANSLATORS";do
    f=$CELESTIA_REPO_ROOT/$file
    if [ $f -nt $CELESTIA_ROOT/$file ];then
        echo "cp $f $CELESTIA_ROOT/$file"
        cp $f $CELESTIA_ROOT/$file
    fi
done

if [ $DIDCOPY -eq 1 ];then
    echo "Touch $BUILT_PRODUCTS_DIR/$PRODUCT_NAME.app"
    touch -c $BUILT_PRODUCTS_DIR/$PRODUCT_NAME.app
fi

