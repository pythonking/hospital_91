package com.kingit.controller;

import com.kingit.dto.JSONResult;
import com.kingit.exception.NotFoundException;
import com.kingit.pojo.Insurance;
import com.kingit.service.InsuranceService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;

@Controller
@RequestMapping("/insurance")
public class InsuranceController {
    @Inject
    private InsuranceService insuranceService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("insuranceList", insuranceService.findAll());
        return "insurance/list";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String newInsurance(Insurance insurance){
        insuranceService.save(insurance);
        return "redirect:/insurance";
    }

    @RequestMapping(value = "/{id:\\d+}/del",method = RequestMethod.GET)
    public String delInsurance(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes){
        insuranceService.delete(id);
        redirectAttributes.addFlashAttribute("success");
        return "redirect:/insurance";
    }

    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public JSONResult edit(@PathVariable("id") Integer id){
        Insurance insurance = insuranceService.findById(id);
        if (insurance==null){
            throw new NotFoundException();
        }
        return new JSONResult(JSONResult.STATE_SUCCESS,insurance);
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    public String edit(Insurance insurance){
        if (insurance==null){
            throw new NotFoundException();
        }
        insuranceService.update(insurance);
        return "redirect:/insurance";
    }
}
