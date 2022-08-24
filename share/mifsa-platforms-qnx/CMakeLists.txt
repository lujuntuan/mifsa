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

cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(mifsa_platforms_qnx)

list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_LIST_DIR}/../../build/install/")

set(MIFSA_INTERNAL_PROJECT ON)
find_package(mifsa_base REQUIRED)

add_subdirectory(gnss)
