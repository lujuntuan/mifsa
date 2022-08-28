# MIFSA - The middleware framework for SOA-based automotive

The middleware framework of in-vehicle soa, based on C++.

Note: This is a top-layer project, you can enter the subproject to build separately.

The source code is here:

 [mifsa-base](https://github.com/lujuntuan/mifsa-base)

 [mifsa-gnss](https://github.com/lujuntuan/mifsa-gnss)

 [mifsa-ota](https://github.com/lujuntuan/mifsa-ota)

The yocto-layer is here:

 [meta-mifsa](https://github.com/lujuntuan/meta-mifsa)

The yocto-build-project is here:

 [mifsa-yocto-build](https://github.com/lujuntuan/mifsa-yocto-build)

## So what is this about?

Documentation is found in [introduction](doc/introduction-zh.md)(中文).

## Features:

- Implementation based on Modern c++ （c++14）.
- Soa-based architecture design, support `dds` `someip` `fdbus` .
- Hierarchical design, low in coupling, support non-intrusive development
- Modern cmake project management, standard export of support libraries.
- Platform abstraction and plug-in, with good portability.
- Cross-platform support
- Fewer dependencies on 3rd party libraries (only `hpp`).
- Support Fuzz-test (TODO).

## Requirements:

Compiler: this makes heavy use of C++11 and requires a recent compiler and STL. The following compilers are known to compile the test programs:

- msvc2015+ on Windows7
- clang-3.4+ on Ubuntu-14.04
- g++-4.9+ on Ubuntu-14.04
- qcc7.0.0+ on Qnx7.0.0
- ndk r12+ on Android8

This repository uses the following header only C++ library:

- [dylib](https://github.com/martin-olivier/dylib)

- [ghc](https://github.com/gulrak/filesystem)

- [popl](https://github.com/badaix/popl)

One of the following rpc communication libraries is required: 

- [fdbus](https://gitee.com/jeremyczhen/fdbus) [protobuf](https://github.com/protocolbuffers/protobuf)

- [commonapi-core-runtime](https://github.com/COVESA/capicxx-core-runtime) [commonapi-someip-runtime](https://github.com/COVESA/capicxx-someip-runtime) [capicxx-core-tools](https://github.com/COVESA/capicxx-core-tools) [capicxx-someip-tools](https://github.com/COVESA/capicxx-someip-tools)

- [rclcpp(ros2)](https://github.com/ros2/rclcpp)

Note: Support custom rpc

## How to build:

```cmake
cmake -B build
cmake --build build --target install
```

Optional:

- -DMIFSA_BUILD_EXAMPLES: 

  whether to compile the examples, default is on.

- -DMIFSA_BUILD_TESTS :

   whether to compile the tests, default is on.

- -DMIFSA_IDL_TYPE: 

  Select the rpc communication component (idl), support auto/ros/vsomeip/fdbus/custom, default is auto.

Examples:

```shell
cmake -B build \
	-DCMAKE_INSTALL_PREFIX=build/install \
	-DMIFSA_BUILD_EXAMPLES=ON \
	-DMIFSA_BUILD_TESTS=OFF \
	-DMIFSA_IDL_TYPE=fdbus
cmake --build build --target install -j8
```

```shell
Note:
For vsomeip support, capicxx-core-tools Need to link to the bin directory.
Example:
ln -sf [capicxx-core-tools dir]/commonapi-core-generator-linux-x86_64 /usr/local/bin/capicxx-core-gen
ln -sf [capicxx-core-tools dir]/commonapi-someip-generator-linux-x86_64 /usr/local/bin/capicxx-someip-gen

For ros2 support, you should set following environment
export AMENT_PREFIX_PATH=[ros2 install dir] #example: opt/ros2_install
export CMAKE_PREFIX_PATH=[ros2 install dir] #example: opt/ros2_install
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH;[ros2 lib install dir] #example: opt/ros2_install/lib
export PYTHONPATH=[ros2 python install path] #example: opt/ros2_install/lib/python3.10/site-packages
```

## How to add modules:

Note: Only support in linux.

```shell
./copyproject.sh
#inpurt project name to copy
#inpurt target project name
#inpurt string to replace
#inpurt target string
```

Examples:

```shell
./copyproject.sh
mifsa_gnss
mifsa_media
gnss
media
```

Then，modify other content to complete the adaptation of the module.

## Copyright:

Juntuan.Lu, 2020-2030, All rights reserved.
