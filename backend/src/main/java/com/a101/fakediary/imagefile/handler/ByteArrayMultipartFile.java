package com.a101.fakediary.imagefile.handler;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

public class ByteArrayMultipartFile implements MultipartFile {
    private final String name;
    private final byte[] content;

    public ByteArrayMultipartFile(String name, byte[] content) {
        this.name = name;
        this.content = content;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getOriginalFilename() {
        return name;
    }

    @Override
    public String getContentType() {
        return null;
    }

    @Override
    public boolean isEmpty() {
        return content.length == 0;
    }

    @Override
    public long getSize() {
        return content.length;
    }

    @Override
    public byte[] getBytes() throws IOException {
        return content;
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return new ByteArrayInputStream(content);
    }

    @Override
    public void transferTo(File dest) throws IOException, IllegalStateException {
        if (dest.exists()) {
            if (!dest.delete()) {
                throw new IllegalStateException(String.format("Failed to delete file '%s'", dest.getAbsolutePath()));
            }
        }
        if (!dest.createNewFile()) {
            throw new IllegalStateException(String.format("Failed to create file '%s'", dest.getAbsolutePath()));
        }
        FileUtils.writeByteArrayToFile(dest, content);
    }

}
