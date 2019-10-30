package com.zm.demo.service.imp;

import com.zm.demo.bean.Employee;
import com.zm.demo.bean.EmployeeExample;
import com.zm.demo.dao.EmployeeMapper;
import com.zm.demo.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImp implements EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /*查询所有员工信息*/
    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
    
   /*插入一条员工信息*/
    @Override
    public void saveEmp(Employee emp) {
        int i = employeeMapper.insertSelective(emp);
    }

    /*检查数据库中的用户名是否有与输入的文本框里的用户名重复的*/
    @Override
    public boolean checkEmpName(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    @Override
    public Employee getEmpById(Integer id) {
        Employee emp = employeeMapper.selectByPrimaryKey(id);
        return emp;
    }

    /*
    * 按照主键有选择地更新
    * @param emp 员工对象
    * */
    @Override
    public void updateEmp(Employee emp) {
        employeeMapper.updateByPrimaryKeySelective(emp);
    }
  /*
   * 单个删除:根据id删除员工信息
   * @param id 员工id
  * */
    @Override
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
    
    //批量删除

    @Override
    public void deleteEmpBatch(List<Integer> empIds) {
        EmployeeExample empExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = empExample.createCriteria();
        criteria.andEmpIdIn(empIds);
        employeeMapper.deleteByExample(empExample);
    }
}
