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
project(mifsa)

set(MIFSA_INTERNAL_PROJECT ON)
set(MIFSA_MODULE_PROJECT ON)
include(mifsa-base/cmake/base.cmake)

add_subdirectory(mifsa-base)
add_subdirectory(mifsa-gnss)
