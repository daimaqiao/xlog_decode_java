#!/usr/bin/env bash

if [ -z $JAVA_HOME ]; then
	echo "JAVA_HOME not set"
	exit 1
fi

OS=`uname |tr '[A-Z]' '[a-z]'`
if [ "$OS" == "darwin" ]; then
OPT="-dynamiclib -framework JavaVM"
OUT="libdecode_log_file_c.jnilib"
elif [ "$OS" == "linux" ]; then
OPT="-shared -fPIC"
OUT="libdecode_log_file_c.so"
else
	echo "Not support $OS"
	exit 1
fi

SRC="out.c decode_log_file_c_impl/decode_log_file.c decode_log_file_c_impl/micro-ecc-master/uECC.c"
INC="-I$JAVA_HOME/include -I$JAVA_HOME/include/$OS"
LIB="-lz"

rm -rf $OUT
gcc $OPT -o $OUT $SRC $INC $LIB

