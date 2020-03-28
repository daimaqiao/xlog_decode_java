#include "out.h"

JNIEXPORT jstring JNICALL Java_com_github_daimaqiao_xlog_1decode_1java_XlogDecode_decodeXlog
  (JNIEnv* env, jclass cls, jstring j_str) {
	const char* c_str = (*env)->GetStringUTFChars(env, j_str, NULL);
	if (!c_str)
	{
		puts("out of memory.");
		return NULL;
	}

	char buff[1024] = { 0 };
	int size = snprintf(buff, sizeof(buff), "%s.log", c_str);
	if (size >= sizeof(buff)) {
		puts("path is too long.");
		return NULL;
	}

	parseFile(c_str, buff);
    (*env)->ReleaseStringUTFChars(env, j_str, c_str);
	return (*env)->NewStringUTF(env, buff);
}

