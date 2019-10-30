package com.zm.demo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zm.demo.bean.Employee;
import com.zm.demo.bean.Message;
import com.zm.demo.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CRUDController {

    @Autowired
    EmployeeService employeeService;

    /*查询所有员工信息*/
     //@RequestMapping("/employees")
    public String getAll(@RequestParam(value = "page",defaultValue = "1") Integer page, Model model){
        /*使用分页插件(pageHelper)进行分页查询,在查询之前只需要调用,传入页码和每页索要显示的数据条数*/
        PageHelper.startPage(page,5);//从第page页开始查询,每页显示5条数据
        List<Employee> emps = employeeService.getAll();
        /*使用pageInfo包装查询结果,只需要将pageInfo交给页面.
        *
        * pageInfo中封装了详细的分页信息,包括有我们查询出来的数据,传入连续显示的页数
        * */
        /*                         需要封装的对象      连续显示多少页 */
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }

    /*查询员工所有数据，并向浏览器返回json格式的字符串*/
    @RequestMapping("/employees")
    @ResponseBody
    public Message getEmpsWithJson(@RequestParam(value = "page",defaultValue = "1") Integer page){
        PageHelper.startPage(page,5);
        List<Employee> emps = employeeService.getAll();
        /*创建PageInfo对象，并将数据封装在PageInfo对象中*/
        PageInfo pageInfo = new PageInfo(emps,5);
        return Message.success().add("pageInfo",pageInfo);
    }

    /*添加员工信息*/

    @RequestMapping(value = "/employee",method = RequestMethod.POST)
    @ResponseBody
    public Message saveEmp(@Valid Employee emp, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示晓燕失败的提示信息
            Map<String,Object> map =  new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError:errors){
                String errorName = fieldError.getField();
                String errorMsg = fieldError.getDefaultMessage();
                System.out.println("错误信息的字段名："+errorName);
                System.out.println("错误提示信息："+errorMsg);
                map.put(errorName,errorMsg);
            }
            return Message.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(emp);
            return Message.success();
        }

    }

    /*检验用户名是否可用*/
    @ResponseBody
    @RequestMapping(value = "/checkEmpName",method = RequestMethod.POST)
    public Message checkEmpName(@RequestParam("empName") String empName){
        //后端校验用户名
        String regexName = "(^[a-zA-Z0-9_-]{3,10}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regexName)){
            return Message.fail().add("tip_msg","用户名要求2-5位中文或者3-10位字母和数字的组合!");
        }
       boolean b = employeeService.checkEmpName(empName);
       if(b){//可用
           return Message.success();
       }else{//不可用
           return Message.fail().add("tip_msg","用户名不可用!");
       }
    }

//===================================修改========================================
    //查询指定id地员工信息
    @RequestMapping(value = "/employee/{id}",method = RequestMethod.GET)
    @ResponseBody  //响应返回一个json格式的数据对象
    //@PathVariable("id") 指定id字段是从路径中取得的
    public Message getEmpById(@PathVariable("id") Integer id){
        Employee emp = employeeService.getEmpById(id);
        return Message.success().add("emp",emp);
    }

    /*保存更新后的员工信息
    * @param emp
    * @return
    *
    * /employee/{empId} 将该url路径中的id设置的要与javabean中的一致
    * */
    @RequestMapping(value = "/employee/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Message saveEmp(Employee emp, HttpServletRequest req){
        System.out.println(req.getParameter("empName"));
        System.out.println(emp);
        employeeService.updateEmp(emp);
        return Message.success();
    }

    //=======================================删除======================================

    /*
    * 将批量删除与单个删除二合一
    * */
    @ResponseBody  //返回json格式的数据
    @RequestMapping(value = "/employee/{del_ids}",method = RequestMethod.DELETE)
                                 //获取url中的id值
    public Message deleteEmpById(@PathVariable("del_ids") String del_ids){
        //用来保存转换后的元素
        List<Integer> empIds = new ArrayList<>();
        if(del_ids.contains("-")){//传进来的是多个id，批量删除
            //将字符串转换成一个数组
            String[] ids = del_ids.split("-");
            //遍历这个字符串数组，将每个元素转换成int类型
            for(String id:ids){
                int empId = Integer.parseInt(id);
                empIds.add(empId);
            }
            employeeService.deleteEmpBatch(empIds);
        }else{//传进来的是一个Id，单个删除
            int id = Integer.parseInt(del_ids);
            employeeService.deleteEmpById(id);
        }
        return Message.success();
    }
}
