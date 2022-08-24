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
project(mifsa_gnss_demo)

list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_LIST_DIR}/../../build/install/")

find_package(mifsa_base REQUIRED)
find_package(mifsa_gnss REQUIRED)

include(GNUInstallDirs)

add_executable(
    mifsa_gnss_demo
    mifsa_gnss_demo.cpp
    )

target_link_libraries(
    mifsa_gnss_demo
    PRIVATE
    mifsa_gnss
    )

install(
    TARGETS
    mifsa_gnss_demo
    RUNTIME
    DESTINATION
    ${CMAKE_INSTALL_BINDIR}
    )
