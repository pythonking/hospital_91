package com.kingit.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

@Controller
@RequestMapping("/preview")
public class PreviewController {
    @Value("${yingxiangPath}")
    private String yingxiangPath;
    @RequestMapping(value = "/yingxiang/{filename}",method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> yingxiang(@PathVariable("filename") String filename) throws FileNotFoundException {
        File file = new File(yingxiangPath,filename);
        if (!file.exists()){
           throw new com.kingit.exception.NotFoundException();
        }
        FileInputStream fileInputStream = new FileInputStream(file);
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(new InputStreamResource(fileInputStream));
    }

}
