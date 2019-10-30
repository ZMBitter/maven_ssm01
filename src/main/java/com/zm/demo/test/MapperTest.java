package com.zm.demo.test;

import com.zm.demo.bean.Dept;
import com.zm.demo.bean.Employee;
import com.zm.demo.dao.DeptMapper;
import com.zm.demo.dao.EmployeeMapper;
import com.zm.demo.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/*
* dao层的测试
*
* spring的项目推荐使用spring单元测试
* 使用步骤:
*    1.引入spring单元测试模块(spring-test)
*    2.使用@ContextConfiguration指定配置文件的位置
*    3.使用@Autowired注解装配要使用的组件
* */
@RunWith(SpringJUnit4ClassRunner.class)  //指定单元测试的方法
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"}) //指定spring配置文件的位置
public class MapperTest {

    @Test
    public void test01(){
        /*原生junit测试*/
        //创建spring的ioc容器
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
       //从容器中获取mapper对象
        DeptMapper deptMapper = context.getBean(DeptMapper.class);
        System.out.println(deptMapper);
    }

    @Autowired
    DeptMapper deptMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void test02(){
       //System.out.println(deptMapper);
        //往dept表中插入一条数据
       // int i = deptMapper.insert(new Dept(1,"技术部"));
       // System.out.println(i);
       // employeeMapper.insert(new Employee(1,"萧恩","男","123456@qq.com",1));

       //批量插入多个员工数据
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<100;i++){
        String uid = UUID.randomUUID().toString().substring(0,5);
        System.out.println(uid);
        mapper.insertSelective(new Employee(null,uid,"女",uid+"@163.com",1));}
    }

    @Test
    public void test03(){
        List<Dept> list = deptMapper.selectByExample(null);
        for(Dept dept:list){
            System.out.println("部门编号："+dept.getDeptId()+" 部门名称："+dept.getDeptName());
        }
    }

    /*测试输入的用户名是否已经在数据库里存在*/
    @Autowired
    EmployeeService employeeService;
    @Test
    public void test04(){
        boolean b = employeeService.checkEmpName("李明");
        System.out.println(b);
    }
}
