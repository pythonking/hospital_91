package com.kingit.controller;

import com.google.common.collect.Maps;
import com.kingit.dto.DatatableResult;
import com.kingit.dto.JSONResult;
import com.kingit.pojo.Patient;
import com.kingit.service.InsuranceService;
import com.kingit.service.PatientService;
import com.kingit.utils.Page;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/patient")
public class PatientController {
    @Inject
    private PatientService patientService;
    @Inject
    private InsuranceService insuranceService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(){
        return "patient/list";
    }
    @RequestMapping(value = "/list.json",method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult<Patient> load(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("keyword");
        Map<String,Object> param = Maps.newHashMap();
        param.put("start",start);
        param.put("length",length);
        param.put("keyword",keyword);

        Page<Patient> patientPage = patientService.fingByParam(param);
        Long filterCount = patientPage.getTotalSize().longValue();
        Long totalCount = patientService.count();
        List<Patient> patientList = patientPage.getItems();

        return new DatatableResult<>(draw,filterCount,totalCount,patientList);
    }
    @RequestMapping(value = "/new",method = RequestMethod.GET)
    public String newPatient(Model model){
        model.addAttribute("insuranceList",insuranceService.findAll());
        return "patient/new";
    }
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public JSONResult newPatient(Patient patient){
        if (patient.getState()==null){
            patient.setState(Patient.STATE_ONLINE);
        }
        patientService.saveOrUpdate(patient);
        return new JSONResult(JSONResult.STATE_SUCCESS,"新建病人信息成功.");
    }
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String show(@PathVariable("id") Integer id, Model model){
        model.addAttribute("patient",patientService.findById(id));
        return "patient/show";
    }
    @RequestMapping(value = "/{id:\\d+}/edit",method = RequestMethod.GET)
    public String editPatient(@PathVariable("id") Integer id, Model model){
        model.addAttribute("insuranceList",insuranceService.findAll());
        model.addAttribute("patient",patientService.findById(id));
        return "patient/edit";
    }
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ResponseBody
    public JSONResult edit(Patient patient,Integer id){
        System.out.println(id);
        System.out.println("================");
        if (patient.getState()==null){
            patient.setState(Patient.STATE_ONLINE);
        }
        Patient persistent = patientService.loadById(id);
        BeanUtils.copyProperties(patient,persistent,new String[]{"id","creattime"});
        patientService.saveOrUpdate(persistent);
        return new JSONResult(JSONResult.STATE_SUCCESS,"编辑病人信息成功.");
    }

    @RequestMapping(value = "/{id:\\d+}/del",method = RequestMethod.GET)
    @ResponseBody
    public JSONResult delete(@PathVariable("id") Integer id){
        patientService.delete(id);
        return new JSONResult(JSONResult.STATE_SUCCESS,"删除病人信息成功");
    }
}
