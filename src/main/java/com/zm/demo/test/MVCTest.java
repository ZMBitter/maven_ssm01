package com.zm.demo.test;

/*
* 在springmvc的测试模块中,可以测试controller发送的请求信息
*
* */

import com.github.pagehelper.PageInfo;
import com.zm.demo.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //引用注解,以获得spring容器中WebApplicationContext对象
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml"})
public class MVCTest {
    /*spring4单元测试请求需要引入servlet3.0版本的servlet-api*/


    /*使用虚拟mvc请求,获取请求处理结果*/
    MockMvc mockMvc;
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        /*模拟请求拿到返回值*/
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/employees").
                param("page", "1")).andReturn();
        /*请求成功以后,获取pageInfo对象中的值,获取封装在pageInfo对象中的数据*/
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码:"+pageInfo.getPageNum());//当前页码p
        System.out.println("总页码数:"+pageInfo.getPages());
        System.out.println("每页显示的记录数:"+pageInfo.getPageSize());
        System.out.println("总记录数:"+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码:");
        int[] nums = pageInfo.getNavigatepageNums();
        for(int num:nums){
            System.out.print(num+"  ");
        }

        /*System.out.println("最后一页"+pageInfo.getLastPage());
        System.out.println("第一页"+pageInfo.getFirstPage());*/
        /*获取员工数据*/
        List<Employee> list = pageInfo.getList();
        for(Employee emp:list){
            System.out.println("员工姓名:"+emp.getEmpName());
            System.out.println("员工性别:"+emp.getEmpGender());
        }
    }
}
