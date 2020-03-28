package com.github.daimaqiao.xlog_decode_java;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class XlogDecode {
    public static native String decodeXlog(String xlog);

    public static void main(String[] args) throws IOException {
        File xlog = new File(args[0]);
        System.out.println("Decode xlog file "+ xlog.getAbsolutePath());

        String out = decodeXlog(xlog.getAbsolutePath());
        System.out.println("Read log file "+ out);

        Files.lines(Paths.get(out)).forEach(System.out::println);
    }

    static {
        System.loadLibrary("decode_log_file_c");
    }
}
