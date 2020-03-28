#/usr/bin/env bash

set -e

CLASSNAME="com.github.daimaqiao.xlog_decode_java.XlogDecode"
JAVAPATH=java/`echo "$CLASSNAME" |sed "s#\.#/#g"`.java

rm -rf out jni/javah
mkdir out
mkdir -p jni/javah
javac -d out $JAVAPATH 
javah -jni -classpath out -d jni/javah $CLASSNAME

cd jni && \
	./build.sh && \
	cp libdecode_log_file_c.* ../out/

cd ..
cp demo/a.xlog out/demo.xlog

echo "DEMO:"
echo "  cd out && \\"
if [ "`uname |tr '[A-Z]' '[a-z]'`" = "linux" ]; then
echo "  LD_LIBRARY_PATH=. java $CLASSNAME demo.xlog"
else
echo "  java $CLASSNAME demo.xlog"
fi

