package com.kingit.controller;

import com.kingit.pojo.Visit;
import com.kingit.service.*;
import com.kingit.utils.Page;
import com.kingit.utils.SearchParam;
import com.kingit.utils.TimestampUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/visit")
public class VisitController {
    @Inject
    private VisitService visitService;
    @Inject
    private DiseaseService diseaseService;
    @Inject
    private PatientService patientService;
    @Inject
    private DocumentService documentService;
    @Inject
    private DeptService deptService;
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String list(@RequestParam(name = "p",required = false,defaultValue = "1") Integer pageNo, HttpServletRequest request, Model model){
        List<SearchParam> searchParamList = SearchParam.buildSearchParam(request);
        Page<Visit> visitPage = visitService.findBySearchParam(pageNo,searchParamList);
        model.addAttribute("patientList",patientService.findAll());
        model.addAttribute("visitPage",visitPage);
        return "visit/list";
    }
    @RequestMapping(value = "/{id:\\d+}/new",method = RequestMethod.GET)
    public String newVisit(@PathVariable("id") Integer id, Model model){
        model.addAttribute("patient",patientService.findById(id));
        model.addAttribute("deptList",deptService.findAll());
        model.addAttribute("diseaseList",diseaseService.findAll());
        return "visit/new";
    }
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    public String newVisit(Visit visit,String nexttimeStr){
        nexttimeStr = nexttimeStr + " 00:00:00";
        visit.setNexttime(TimestampUtil.stringToTimestamp(nexttimeStr));
        visitService.saveOrUpdate(visit);
//        documentService.saveFile(file,visit);
        return "redirect:/visit/list";
    }

}
