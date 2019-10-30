package com.zm.demo.service.imp;

import com.zm.demo.bean.Dept;
import com.zm.demo.dao.DeptMapper;
import com.zm.demo.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImp implements DeptService {

    @Autowired
    DeptMapper deptMapper;

    /*查询部门的所有信息*/
    @Override
    public List<Dept> getDepts() {
        List<Dept> list = deptMapper.selectByExample(null);
        return list;
    }
}
