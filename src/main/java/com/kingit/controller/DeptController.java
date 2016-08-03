package com.kingit.controller;

import com.kingit.exception.NotFoundException;
import com.kingit.pojo.Dept;
import com.kingit.service.DeptService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/dept")
public class DeptController {
    @Inject
    private DeptService deptService;
    @RequestMapping(method = RequestMethod.GET)
    public String deptList(Model model){
        List<Dept> deptList = deptService.findAll();
        model.addAttribute("deptList",deptList);
        return "dept/list";
    }
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String newDept(Dept dept){
        if (dept==null){
            throw new NotFoundException();
        }
        deptService.save(dept);
        return "success";
    }
    @RequestMapping(value = "/{id:\\d+}/del",method = RequestMethod.GET)
    @ResponseBody
    public String delDept(@PathVariable("id") Integer id){
        deptService.delete(id);
        return "success";
    }
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public Dept editForm(@PathVariable("id") Integer id){
        Dept dept = deptService.findById(id);
        if(dept==null){
            throw new NotFoundException();
        }
        return dept;
    }
    @RequestMapping(value = "/{id:\\d+}/edit",method = RequestMethod.POST)
    @ResponseBody
    public String editDept(Dept dept){
        if(dept==null){
            throw new NotFoundException();
        }
        deptService.update(dept);
        return "success";
    }
}
