package com.kingit.service;

import com.kingit.dao.DocumentDao;
import com.kingit.pojo.Document;
import com.kingit.pojo.Visit;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

@Named
@Transactional
public class DocumentService {
    @Value("${yingxiangPath}")
    private String yingxiangPath;
    @Inject
    private DocumentDao documentDao;

    public void saveOrUpdate(Document document) {
        documentDao.save(document);
    }

    public void delete(Integer id) {
        documentDao.delete(id);
    }

    public Document findById(Integer id) {
        return documentDao.findById(id);
    }

    public List<Document> findAll() {
        return documentDao.findAll();
    }


    public String saveFile(MultipartFile file, Visit visit) throws IOException {
        InputStream inputStream = file.getInputStream();
        String realname = file.getContentType();
        Long size = file.getSize();
        String contenttype = file.getContentType();

        String extName = "";
        File fileDir = new File(yingxiangPath);
        if (!fileDir.exists() || !fileDir.isDirectory()) {
            fileDir.mkdir();
        }
        if (realname.contains(".")) {
            extName = realname.substring(realname.lastIndexOf("."));
        }
        String fileName = UUID.randomUUID().toString();
        fileName = extName + fileName;
        FileOutputStream fileOutputStream = new FileOutputStream(new File(yingxiangPath, fileName));
        IOUtils.copy(inputStream, fileOutputStream);
        Document document = new Document();
        document.setRealname(realname);
        document.setFilename(fileName);
        document.setSize(FileUtils.byteCountToDisplaySize(size));
        document.setContenttype(contenttype);
        if (visit != null && visit.getId() != null) {
            document.setVisit(visit);
        }
        saveOrUpdate(document);
        return "/preview/yingxiang/" + fileName;
    }
}
