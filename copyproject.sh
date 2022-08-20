#!/bin/bash
#*********************************************************************************
#  *Copyright(C): Juntuan.Lu, 2020-2030, All rights reserved.
#  *Author:  Juntuan.Lu
#  *Version: 1.0
#  *Date:  2022/04/01
#  *Email: 931852884@qq.com
#  *Description:
#  *Others:
#  *Function List:
#  *History:
#**********************************************************************************

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

if [ -z $SOURCE_PROJECT_NAME ] || [ -z $TARGET_PROJECT_NAME ] || [ -z $SOURCE_REPLACE_NAME ] || [ -z $TARGET_REPLACE_NAME ];then
    read -p "Please input source project name:" SOURCE_PROJECT_NAME
    read -p "Please input target project name:" TARGET_PROJECT_NAME
    read -p "Please input source replace name:" SOURCE_REPLACE_NAME
    read -p "Please input target replace name:" TARGET_REPLACE_NAME
fi

if [ -z $SOURCE_PROJECT_NAME ] || [ -z $TARGET_PROJECT_NAME ] || [ -z $SOURCE_REPLACE_NAME ] || [ -z $TARGET_REPLACE_NAME ];then
    echo "error input!"
    exit -1
fi

if [ ! -d $CURRENT_DIR/$SOURCE_PROJECT_NAME ];then
    echo "source project not exists!"
    exit -2
fi

if [ -d $TARGET_PROJECT_NAME ];then
    read -r -p "The target project already exists, is it forced to run? [y/n]" RM_FORCE
    if [ "$RM_FORCE" = "y" ] || [ "$RM_FORCE" = "Y" ];then
        rm -rf $TARGET_PROJECT_NAME/*
    else
        exit 1
    fi
fi
mkdir -p $TARGET_PROJECT_NAME
cp -r $CURRENT_DIR/$SOURCE_PROJECT_NAME/* $TARGET_PROJECT_NAME/

if [ $? -ne 0 ];then
    echo "copy project error!"
    exit -3
fi

do_replace(){
    local _source=$1
    local _target=$2
    if [ -z $_source ] || [ -z $_target ];then
        echo "[do_replace] error input!"
        exit -4
    fi
    for name in $(find $CURRENT_DIR/$TARGET_PROJECT_NAME/ -name "*$_source*" -type d | sort -r)
    do
        local sname=${name//"$CURRENT_DIR"/"."}
        local tname=${sname//"$_source"/"$_target"}
        if [ "$sname" = "$tname" ];then
            continue
        fi
        echo "[do_replace] repleace dir [$sname | $tname]"
        cd $sname/..
        mv $(basename $sname) $(basename $tname)
        cd $CURRENT_DIR
        if [ $? -ne 0 ];then
            echo "[do_replace] error type1 !"
            exit -5
        fi
    done
    for name in $(find $CURRENT_DIR/$TARGET_PROJECT_NAME/ -name "*$_source*" -type f)
    do
        local sname=${name//"$CURRENT_DIR"/"."}
        local tname=${sname//"$_source"/"$_target"}
        if [ "$sname" = "$tname" ];then
            continue
        fi
        echo "[do_replace] repleace file [$sname | $tname]"
        mkdir -p $(dirname $tname)
        mv $sname $tname
        if [ $? -ne 0 ];then
            echo "[do_replace] error type2 !"
            exit -6
        fi
    done
    for name in $(grep $_source -rl $CURRENT_DIR/$TARGET_PROJECT_NAME/)
    do
        local name=${name//"$CURRENT_DIR"/"."}
        echo "[do_replace] repleace content [$_source | $_target] ($name)"
        sed -i "s/"$_source"/"$_target"/g" $name
        if [ $? -ne 0 ];then
            echo "[do_replace] error type2!"
            exit -7
        fi
    done
}

echo "replace content lower..."
SOURCE_REPLACE_NAME_LOWER=$(echo $SOURCE_REPLACE_NAME | tr '[A-Z]' '[a-z]')
TARGET_REPLACE_NAME_LOWER=$(echo $TARGET_REPLACE_NAME | tr '[A-Z]' '[a-z]')
do_replace $SOURCE_REPLACE_NAME_LOWER $TARGET_REPLACE_NAME_LOWER

echo "replace content upper..."
SOURCE_REPLACE_NAME_UPPER=$(echo $SOURCE_REPLACE_NAME | tr '[a-z]' '[A-Z]')
TARGET_REPLACE_NAME_UPPER=$(echo $TARGET_REPLACE_NAME | tr '[a-z]' '[A-Z]')
do_replace $SOURCE_REPLACE_NAME_UPPER $TARGET_REPLACE_NAME_UPPER

echo "replace content topper..."
SOURCE_REPLACE_NAME_TOPPER=$(echo ${SOURCE_REPLACE_NAME:0:1} | tr '[a-z]' '[A-Z]')${SOURCE_REPLACE_NAME_LOWER:1}
TARGET_REPLACE_NAME_TOPPER=$(echo ${TARGET_REPLACE_NAME:0:1} | tr '[a-z]' '[A-Z]')${TARGET_REPLACE_NAME_LOWER:1}
do_replace $SOURCE_REPLACE_NAME_TOPPER $TARGET_REPLACE_NAME_TOPPER

echo "finished!"

exit 0
