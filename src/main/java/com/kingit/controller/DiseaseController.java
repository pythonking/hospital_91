package com.kingit.controller;

import com.kingit.dto.DatatableResult;
import com.kingit.dto.FlashMessage;
import com.kingit.dto.JSONResult;
import com.kingit.pojo.Disease;
import com.kingit.service.DeptService;
import com.kingit.service.DiseaseService;
import com.kingit.utils.Page;
import com.kingit.utils.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/disease")
public class DiseaseController {
    @Inject
    private DiseaseService diseaseService;
    @Inject
    private DeptService deptService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("deptList", deptService.findAll());
        return "disease/list";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String newDisease(Disease disease, RedirectAttributes redirectAttributes) {
        diseaseService.save(disease);
        redirectAttributes.addFlashAttribute("message", new FlashMessage(FlashMessage.STATE_SUCCESS, "录入成功."));
        return "redirect:/disease";
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult<Disease> load(HttpServletRequest request) {
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyWord = request.getParameter("keyWord");
        keyWord = Strings.toUTF8(keyWord);


        Page<Disease> page = diseaseService.findByPageNo(start, length, keyWord);

        Long totalCount = diseaseService.count();
        Long filterCount = page.getTotalSize().longValue();
        List<Disease> diseaseList = page.getItems();

        return new DatatableResult<>(draw, filterCount, totalCount, diseaseList);
    }

    @RequestMapping(value = "/{id:\\d+}", method = RequestMethod.GET)
    @ResponseBody
    public JSONResult edit(@PathVariable("id") Integer id) {
        Disease disease = diseaseService.findById(id);
        return new JSONResult(disease);
    }

    //hibernate中这个方法可被保存方法替换,而不影响效果
    @RequestMapping(value = "/{id:\\d+}/edit", method = RequestMethod.POST)
    public String edit(Disease disease) {
        diseaseService.update(disease);
        return "redirect:/disease";
    }

    @RequestMapping(value = "/{id:\\d+}/del", method = RequestMethod.GET)
    @ResponseBody
    public String delete(@PathVariable("id") Integer id) {
        diseaseService.delete(id);
        return "success";
    }
}
