package com.kingit.service;

import com.kingit.pojo.Document;
import com.kingit.pojo.Visit;
import com.kingit.utils.TimestampUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContent.xml")
public class UserServiceTestCase {
    @Inject
    private RoleService roleService;
    @Inject
    private DeptService deptService;
    @Inject
    private UserService userService;
    @Inject
    private InsuranceService insuranceService;
    @Inject
    private DiseaseService diseaseService;
    @Inject
    private PatientService patientService;
    @Inject
    private VisitService visitService;
    @Inject
    private DocumentService documentService;
    @Test
    public void testFindAll(){
     userService.delete(5);
    }
    @Test
    public void testFindByUserId(){
        System.out.println(userService.findByUserName(""));
        System.out.println("=============");
    }

    @Test
    public void test1(){
        Document document = new Document();
        document.setFilename("8757577");
        document.setRealname("病理报告");
        document.setVisit(visitService.findById(1));
        documentService.saveOrUpdate(document);
        System.out.println("=============");
    }

    @Test
    public void test2(){
        Visit visit = new Visit();
        visit.setDept(deptService.findById(6));
        visit.setBeddoctor("韩娜娜");
        visit.setDisease(diseaseService.findById(11));
        visit.setPatient(patientService.findById(2));
        visitService.saveOrUpdate(visit);
    }

    @Test
    public void testTimestamp(){
        System.out.println(TimestampUtil.stringToTimestamp("2016-12-23 "));
    }

    @Test
    public void testReverse(){
        Date date = new Date();
        System.out.println(date.getTime());
        System.out.println("======================");
    }

}
