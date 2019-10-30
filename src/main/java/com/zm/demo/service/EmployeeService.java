package com.zm.demo.service;

import com.zm.demo.bean.Employee;
import java.util.List;

public interface EmployeeService {
    /*查询所有员工信息*/
    List<Employee> getAll();
    /*插入员工信息*/
    void saveEmp(Employee emp);
    /*检查输入的用户名是否与数据库中的用户名有重复的*/
    boolean checkEmpName(String empName);
    Employee getEmpById(Integer id);
    void updateEmp(Employee emp);
    //单个删除
    void deleteEmpById(Integer id);

    void deleteEmpBatch(List<Integer> empIds);
}
