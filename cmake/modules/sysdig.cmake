#
# Copyright (C) 2019 The Falco Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#

# The sysdig git reference (branch name, commit hash, or tag) set(SYSDIG_VERSION
# "falco/${FALCO_VERSION_MAJOR}.${FALCO_VERSION_MINOR}.${FALCO_VERSION_PATCH}") # todo(leodido, fntlnz) > use this when
# FALCO_VERSION variable is ok (PR 872)
# get_cmake_property(_variableNames VARIABLES)
# list (SORT _variableNames)
# foreach (_variableName ${_variableNames})
#     message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()

if(NOT SYSDIG_VERSION)
  set(SYSDIG_VERSION "dev")
endif()

ExternalProject_Add(
  sysdig
  GIT_REPOSITORY https://github.com/draios/sysdig.git
  GIT_TAG ${SYSDIG_VERSION}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  TEST_COMMAND "")

# Fetch the sysdig source directory
ExternalProject_Get_Property(sysdig SOURCE_DIR)
set(SYSDIG_SOURCE_DIR "${SOURCE_DIR}")
unset(SOURCE_DIR)
message(STATUS "Source directory of sysdig: ${SYSDIG_SOURCE_DIR}")
message(STATUS "Sysdig version: ${SYSDIG_VERSION}")


ExternalProject_Add(
  libsinsp
  DEPENDS sysdig
  DOWNLOAD_COMMAND ""
  SOURCE_DIR "${SYSDIG_SOURCE_DIR}/userspace/libsinsp"
  # CMAKE_ARGS "-DB64_INCLUDE=${B64_INCLUDE} -DCURSES_INCLUDE_DIR=${CURSES_INCLUDE_DIR} -DGRPC_INCLUDE=${GRPC_INCLUDE} -DJQ_INCLUDE=${JQ_INCLUDE} -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DPROTOBUF_INCLUDE=${PROTOBUF_INCLUDE}"
  CMAKE_ARGS -DPROTOBUF_INCLUDE=${PROTOBUF_INCLUDE} -DB64_INCLUDE=${B64_INCLUDE} -DJSONCPP_INCLUDE=${JSONCPP_INCLUDE} -DLUAJIT_INCLUDE=${LUAJIT_INCLUDE} -DTBB_INCLUDE_DIR=${TBB_INCLUDE_DIR} -DCURSES_INCLUDE_DIR=${CURSES_INCLUDE_DIR} -DGRPC_INCLUDE=${GRPC_INCLUDE} -DJQ_INCLUDE=${JQ_INCLUDE} -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DCURL_INCLUDE_DIR=${CURL_INCLUDE_DIR} -DCURL_LIBRARIES=${CURL_LIBRARIES} -DJSONCPP_LIB=${JSONCPP_LIB} -DTBB_LIB=${TBB_LIB} -DUSE_BUNDLED_LUAJIT=OFF -DUSE_BUNDLED_OPENSSL=OFF -DUSE_BUNDLED_CURL=OFF -DUSE_BUNDLED_TBB=OFF -DUSE_BUNDLED_GRPC=OFF -DGRPC_CPP_PLUGIN=${GRPC_CPP_PLUGIN} -DPROTOC=${PROTOC} -DOPENSSL_LIBRARIES=${OPENSSL_LIBRARIES} -DLUAJIT_LIB=${LUAJIT_LIB}
)

# list(APPEND CMAKE_MODULE_PATH "${SYSDIG_SOURCE_DIR}/cmake/modules")
#


# # jsoncpp
# set(JSONCPP_SRC "${SYSDIG_SOURCE_DIR}/userspace/libsinsp/third-party/jsoncpp")
# set(JSONCPP_INCLUDE "${JSONCPP_SRC}")
# set(JSONCPP_LIB_SRC "${JSONCPP_SRC}/jsoncpp.cpp")

# # Add driver directory
# add_subdirectory("${SYSDIG_SOURCE_DIR}/driver" "${PROJECT_BINARY_DIR}/driver")

# # Add libscap directory
# add_subdirectory("${SYSDIG_SOURCE_DIR}/userspace/libscap" "${PROJECT_BINARY_DIR}/userspace/libscap")

# # Add libsinsp directory
# add_subdirectory("${SYSDIG_SOURCE_DIR}/userspace/libsinsp" "${PROJECT_BINARY_DIR}/userspace/libsinsp")