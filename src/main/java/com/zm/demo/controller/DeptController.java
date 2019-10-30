package com.zm.demo.controller;

import com.zm.demo.bean.Dept;
import com.zm.demo.dao.DeptMapper;
import com.zm.demo.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    @ResponseBody
    @RequestMapping("/depts")
    public List<Dept> getDepts(){
        List<Dept> list = deptService.getDepts();
        return list;
    }
}
