<h2>restful风格的URI路径</h2>
URI：<br/>
  /employees        get        查询所有员工信息<br/>
  /employee/{id}    get        根据员工id查询员工信息<br/>
  /employee/{id}    put        根据员工id修改员工信息<br/>
  /employee/{id}    delete     根据员工id删除员工信息<br/>
  /employee         post       添加员工信息
  <hr/>

<h2>使用分页插件分页显示员工数据</h2>

方式1：通过url进行页面跳转

1）访问index.jsp页面<br>
2）index.jsp页面发送出查询员工列表请求<br/>
3）EmployeeController来接受请求，查出员工数据<br/>
4）来到list.jsp页面进行展示<br/>
5）pageHelper分页插件完成分页查询功能

index.jsp页面的设置
```html
<jsp:forward page="/employees"></jsp:forward>
```
&emsp;&emsp;WEB-INF下员工信息展示页面(list.jsp)：在显示数据的地方，使用EL表达式获取表存在Model中的数据。

方式2：通过ajax发送数据请求，显示员工信息

 1）index.jsp页面直接发送ajax请求进行员工分页数据的查询<br/>
 2）服务器将查出的数据，以json字符串的形式返回给浏览器<br/>
 3）浏览器收到js字符串。可以使用js对json进行解析，使用js通过
dom增删改改变页面。<br/>
 4）返回json。实现客户端的无关性。
```html
 function to_page(page) {
        $.ajax({
            url:"${PATH}/employees",
            data:"page="+page,
            type:"GET",
            success:function (result) {//响应成功,返回数据
                //console.log(result);
                //解析并显示员工数据
                build_table_td(result)
                //解析并显示分工信息
                build_page_msg(result);
                build_page_nav(result)
            }
        });
    }
```

在controller层，使用@ResponseBody注解使服务器给客户端返回json字符串格式的数据。
```java
 @RequestMapping("/employees")
 @ResponseBody
```

<h2>分页插件的使用</h2>
在mybatis-config.xml文件中进行配置
```xml
  <!--在mybatis中注册分页插件-->
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--在使用分页插件时，页码合理化设置。即使点击了错误的页码，也可以正确显示。-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>
```
<b>注意</b>：plugins标签要放在typeAliases标签的后面
```java
public class CRUDController {
    //……
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
      // ……
 }
```

<hr/>
<h2>添加员工信息</h2>

实现过程：
   1.在页面点击“新增”按钮，弹出新增员工信息的模态框；<br/>
   2.从数据库的部门表中查询出部门信息，将其填充到下拉列表中；<br/>
   3.在模态框中输入要录入的员工信息，完毕后，点击保存，进行提交。
   
所使用的技术：ajax，json

将从数据库里面查询出来的员工信息填充到下拉列表中
```html
$("#emp_add_btn").click(function () {

         //发送ajax请求查询数据库里员工部门信息
        $.ajax({
               url:"${PATH}/depts",
               type:"GET",
               success:function (result) {//响应成功，返回数据
                   // 部门信息 [{"deptId":1,"deptName":"技术部"},{"deptId":2,"deptName":"产品部"}]

                   //遍历部门信息数组，将数据填充到下拉列表中
                  $.each( result,function () {
                       var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                       optionEle.appendTo($("#emp_add_model select"));
                   });
               }
            }
        );
```

从表单向服务器提交数据。在这里使用了serialize方法，将表单数据序列化成字符串。

```html
   //给该按钮添加单击事件
    $("#add_emp_btn").click(function () {
        //使用ajax从客户端向服务器发送数据
        $.ajax({
            url:"${PATH}/employee",
            type:"post",
            data:$("#emp_add_model form").serialize(),
            success:function (result) {
                alert(result.msg);
                //模态框消失
                $("#emp_add_model").modal("hide");
                //发送ajax请求，显示最后一页信息
                to_page(totalRecord);
            }
        });
    });
```

注意点：如何实现在提交了一条记录后，模态框消失，并且显示最后一页的信息。
```html
 //模态框消失
 $("#emp_add_model").modal("hide");
 //发送ajax请求，显示最后一页信息
 to_page(totalRecord);
```
<hr/>
<h2>表单数据格式校验</h2>
1.前端页面的数据校验<br/>
&emsp;&emsp;使用jquery与ajax校验表单中输入的数据的格式是否正确。<br/>
校验两次输入的用户名是否一样。若一样，则失败，不能提交；若成功，则提交。<br/>
2.后端校验(JSR303校验）:重要的数据上都需要进行后端校验<br/>

```java
 private Integer empId;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{3,10}$)|(^[\\u2E80-\\u9FFF]{2,5})",message = "用户名要求2-5位中文或者3-10位字母和数字的组合")
    private String empName;
    private String empGender;
    //@Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message = "邮箱要求2-6位由数字或字母组成且包含@的字符串")
    private String empMail;
    private Integer dId;
    private Dept dept;//部门名
  ```
  
  <hr/>
  <h3>ajax=put引发的问题：</h3>
  若是直接发送PUT请求，会产生问题<br/>
      如果使用Ajax直接发送PUT请求，会拿不到请求体中的数据。
          原因：tomcat：<br/>
                1）将请求体中的数据封装成一个map对象；<br/>
                2）request.getParameter("empName")就会从这个map中取值; <br/>
                3)SpringMVC封装POJO对象的时候，会把POJO中每个属性的值，request.getParameter("empName");<br/>
          引发的“血案”：<br/>
             PUT请求:请求体中的数据，采用request.getParameter(“empName”)的方式拿不到。tomcat一看是PUT<br/>
             请求不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map。<br/>
             解决：在web.xml中配置HttpPutFormContentFilter过滤器。作用：<br/>
                1）将请求体中的数据解析包装成一个map；<br/>
                2）重新包装request请求：request.getParameter()被重写，就会从自己封装的map中取数据

<h3>删除</h3>
1. 单个删除:employee/{id} delete<br/>

```js
 $(document).on("click",".delete-btn",function () {
       //1.1 弹出是否确认删除的对话框。获取的是<tr><td></td></tr>中的文本值
       var empName = $(this).parents("tr").find("td:eq(1)").text();
       if(confirm("确认删除【"+empName+"】吗?")){
            //确认删除，发送ajax请求
           $.ajax({
               url:"${PATH}/employee/"+$(this).attr("delete-id"),
               type:"DELETE",
               success:function (result) {
                   alert(result.msg);
                   //回到本页
                   to_page(currentPage);
               }
           });
       }
   });
```
2.全选与全不选
```js
//全选与全不选
$("#checkbox-all").click(function () {
        //获取当前元素的属性值。注意：此处使用prop而不是attr（prop适用于原生属性，attr适用于自定义属性）
        $(".check-box").prop("checked",$(this).prop("checked"));
    });
```
注意：prop与attr的适应场景<br/>
1）prop适应于dom原生属性的修改与读取<br/>
2）attr适用于dom自定义属性的修改与读取<br/>
3. 在controller中，将单个与批量二合一
```java
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
```

批量删除：
```java
 @Override
    public void deleteEmpBatch(List<Integer> empIds) {
        EmployeeExample empExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = empExample.createCriteria();
        criteria.andEmpIdIn(empIds);
        employeeMapper.deleteByExample(empExample);
    }
```


 

 










