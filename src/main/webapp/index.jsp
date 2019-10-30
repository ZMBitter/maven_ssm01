<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>展示员工信息</title>
    <%
        pageContext.setAttribute("PATH",request.getContextPath());
    %>
    <script src="${PATH}/static/js/jquery-3.3.1.js" type="text/javascript"></script>
    <link href="${PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="${PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>

<body>

<%--========================================================修改模态框==========================================================--%>
<%--点击“编辑”按钮，弹出修改的模态框--%>
<div class="modal fade" id="emp_update_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">修改员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <%--<input class="form-control" id="empName" placeholder="请输入员工姓名" name="empName">--%>
                          <%--静态地显示员工信息--%>
                           <p class="form-control-static" id="empName_update" name="empName"></p>
                            <span class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="inlineRadio1_update" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="inlineRadio2_update" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empMail" class="col-sm-2 control-label">邮箱地址</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="empMail_update" placeholder="xxxxxx@163.com" name="empMail">
                            <span class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--根据显示的下拉框选择部门，传递的是一个部门的id--%>
                            <select class="form-control" name="dId" > </select>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_emp_btn">更新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<%--=======================================================新增模态框====================================================--%>
<%--点击“添加”按钮弹出一个模态框--%>
<div class="modal fade" id="emp_add_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="empName" placeholder="请输入员工姓名" name="empName">
                            <span class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="inlineRadio1" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="inlineRadio2" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empMail" class="col-sm-2 control-label">邮箱地址</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="empMail" placeholder="xxxxxx@163.com" name="empMail">
                            <span class="help-block"> </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--根据显示的下拉框选择部门，传递的是一个部门的id--%>
                            <select class="form-control" name="dId" > </select>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="add_emp_btn">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<%--=======================================================================================================================--%>

<div class="container ">
    <%--标题行--%>
   <div class="row">
       <div class="col-md-12">
           <h2>员工信息页</h2>
       </div>
   </div>
    <%--删除选中和添加按钮--%>
   <div class="row">
       <div class="col-md-4 col-md-offset-8">
           <button class="btn btn-info" id="emp_add_btn">新增</button>
           <button class="btn btn-danger" id="delete-all">删除</button>
       </div>
   </div>
     <%--表格行--%>
   <div class="row">
       <div class="col-md-12">
          <table class="table table-bordered" id="myTable">
              <thead>
              <tr class="text-center">
                  <th>
                      <input type="checkbox" id="checkbox-all"/> 全选/全不选
                  </th>
                  <th>员工编号</th>
                  <th>员工姓名</th>
                  <th>性别</th>
                  <th>邮箱</th>
                  <th>所属部门</th>
                  <th>操作</th>
              </tr>
              </thead>
              <tbody>
             <%-- <c:forEach items="${pageInfo.list}" var="emp">
                  <tr class="text-center">
                      <td>${emp.empId}</td>
                      <td>${emp.empName}</td>
                      <td>${emp.empGender}</td>
                      <td>${emp.empMail}</td>
                      <td>${emp.dept.deptName}</td>
                      <td>
                          <button class="btn btn-info btn-sm">
                              <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                              编辑</button>
                          <button class="btn btn-danger btn-sm">
                              <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                              删除</button>
                      </td>
                  </tr>
              </c:forEach>--%>
              </tbody>
          </table>
       </div>
   </div>
     <%--分页信息显示行--%>
   <div class="row">
       <%--分页文字信息--%>
       <div class="col-md-6">
           <span style="font-size: 16px;" id="page_msg">
               共有${pageInfo.total}条数据，共${pageInfo.pages}页，当前是第${pageInfo.pageNum}页
           </span>
       </div>
       <%--=======================================显示分页提示信息=================================--%>
       <%--=================================分页条信息======================================--%>
       <div class="col-md-6">
           <nav aria-label="Page navigation" id="page_nav">
               <ul class="pagination pagination-lg">

                   <li>
                       <a href="${PATH}/employees?page=1">
                           <span aria-hidden="true">首页</span>
                       </a>
                   </li>
                   <c:if test="${pageInfo.hasPreviousPage}">

                       <li>
                           <a href="${PATH}/employees?page=${pageInfo.prePage}" aria-label="Previous">
                               <span aria-hidden="true">&laquo;</span>
                           </a>
                       </li>
                   </c:if>
       <%--===================================连续显示的页码===========================--%>
                   <c:forEach items="${pageInfo.navigatepageNums}" var="currentPage">
                       <%--当前页码高亮显示的设置--%>
                       <c:if test="${currentPage==pageInfo.pageNum}">
                           <li  class="active"><a href="${PATH}/employees?page=${currentPage}">${currentPage}<span class="sr-only">(current)</span></a></li>
                       </c:if>
                       <c:if test="${currentPage!=pageInfo.pageNum}">
                           <li><a href="${PATH}/employees?page=${currentPage}">${currentPage}</a></li>
                       </c:if>
                   </c:forEach>

                   <c:if test="${pageInfo.hasNextPage}">
                       <li>
                           <a href="${PATH}/employees?page=${pageInfo.nextPage}" aria-label="Next">
                               <span aria-hidden="true">&raquo;</span>
                           </a>
                       </li>

                   </c:if>
                   <li>
                        <a href="${PATH}/employees?page=${pageInfo.pages}">
                            <span aria-hidden="true">尾页</span>
                        </a>
                    </li>
               </ul>
           </nav>
       </div>
   </div>
</div>
<%--============================================================================================--%>
<script type="text/javascript">
    var totalRecord,currentPage; //总数据数；本页面

    //发送ajax请求
    $(function(){//页面一加载，默认显示第一页数据
        to_page(1);
    });

    function to_page(page) {
        $.ajax({
            url:"${PATH}/employees",
            data:"page="+page,
            type:"GET",
            success:function (result) {//响应成功,返回数据
                //console.log(result);
                //解析并显示员工数据
                build_table_td(result)
                //解析并显示分页信息
                build_page_msg(result);
                build_page_nav(result)
            }
        });
    }

    //显示员工数据
    function build_table_td(result) {
        //清空表格
        $("#myTable tbody").empty();
        //员工信息
        var emps = result.extend.pageInfo.list;
       //遍历员工信息的集合  index遍历到的元素的索引     item遍历到的元素
        $.each(emps,function (index,item) {
            //取出每个元素中的数据
            var checkBox = $("<td><input type='checkbox' class='check-item'/> </td>")
            var empId = $("<td></td>").append(item.empId);//员工编号
            var empName = $("<td></td>").append(item.empName);//员工姓名
            var empGender = $("<td></td>").append(item.empGender); //员工性别
            var empEmail = $("<td></td>").append(item.empMail);//员工邮箱
            var empDeptName = $("<td></td>").append(item.dept.deptName);//员工部门
             //编辑按钮
            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" ")
                .append("编辑");

            //为“编辑”按钮添加一个自定义属性，来表示当前员工的id信息
            editBtn.attr("edit-id",item.empId);

            //删除按钮
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" ")
                .append("删除");
            //为“删除”按钮添加自定义属性
            delBtn.attr("delete-id",item.empId);

            //在操作单元格中添加这两个按钮
            var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //创建表格，填充数据
            $("<tr></tr>").append(checkBox).append(empId).append(empName).append(empGender)
                .append(empEmail).append(empDeptName).append(btn).appendTo($("#myTable tbody"));
        });
    }

    //显示员工分页提示信息
    function build_page_msg(result) {
        //清空原来标签中的内容
        var sp =  $("#page_msg").empty();
       //获得员工信息
       var pageInfo = result.extend.pageInfo;
       totalRecord = pageInfo.total;  //用一个全局变量保存总记录数
        currentPage = pageInfo.pageNum;  //本页面
       sp.append("共有"+totalRecord+"条数据，共"+pageInfo.pages+"页，当前是第"+currentPage+"页");
    }

   //显示员工分页条信息
    function build_page_nav(result) {
         //获取需要连续显示的页码信息(是一个数组)
        var pageNums = result.extend.pageInfo.navigatepageNums;
        //创建<ul></ul>标签
        var ul = $("<ul></ul>").addClass("pagination");
        //创建 首页、前翻的li标签
        var firstPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>").attr("href","#").attr("aria-label","Previous").append("&laquo;"));
        //如果当前页是第一页，则首页和第一页按钮禁用
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //点击首页，发送ajax，显示第1页数据
            firstPageLi.click(function () {
                to_page(1);
            });
            //点击前一页，发送ajax，显示前一页数据
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.prePage);
            });
        }

        //创建 尾页、后翻的标签
        var lastPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").attr("aria-label","Next").append("&raquo;"));
        //如果当前页是最后一页，则尾页和最后一页的按钮禁用
        if(result.extend.pageInfo.hasNextPage==false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else{
            //点击尾页，显示最后一页的信息
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            //点击下一页，显示下一页信息
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.nextPage);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(pageNums,function (index,item) {
            var pageLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            if(item == result.extend.pageInfo.pageNum){
                pageLi.addClass("active");
            }
            //实现点击某一页跳转到某一页。思路：点击某一页，发送一次ajax请求
            pageLi.click(function () {
                to_page(item);
            });
            ul.append(pageLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        //将ul放入<nav></nav>标签中
        $("#page_nav").empty().append(ul);
    }


// ============================================清除表单样式以及表单内容=========================
    function reset_form(ele){
        //清除表单内容
        $(ele)[0].reset();
        //清除表单样式
        $(ele).find("*").removeClass("has-success has-error");
        //清空span提示信息
        $(ele).find(".help-block").text("");
    }
// ========================================点击新增按钮弹出模态框=========================================
     $("#emp_add_btn").click(function () {
         //表单重置
        // $("#emp_add_model form")[0].reset();
         reset_form("#emp_add_model form");
         //发送ajax请求查询数据库里员工部门信息
         getDepts("#emp_add_model select");
         //点击新增按钮弹出模态框
         $("#emp_add_model").modal({
             backdrop:"static"
         });
     });

    function getDepts(ele) {
        //清空下拉列表
        $(ele).empty();
        $.ajax({
            url:"${PATH}/depts",
            type:"GET",
            success:function (result) {//响应成功，返回数据
                // 部门信息 [{"deptId":1,"deptName":"技术部"},{"deptId":2,"deptName":"产品部"}]

                //遍历部门信息数组，将数据填充到下拉列表中
                $.each( result,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo($(ele));
                });
            }
        });
    }
    /*
    ---------校验---------
      对要提交的数据进行校验。员工姓名：2-5位中文或者3-10位字母与数字的组合。
      电子邮箱：电子邮箱格式的校验
    */

    function checkForm(){
        //获取要校验的对象。员工姓名和电子邮箱
        var empName = $("#empName").val();//员工姓名
        var empMail = $("#empMail").val();//电子邮箱
        var regexName = /(^[a-zA-Z0-9_-]{3,10}$)|(^[\u2E80-\u9FFF]{2,5})/;
        var regexMail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        //1.校验员工姓名
        if(!(regexName.test(empName))){
            show_validate_msg("#empName","error","用户名要求2-5位中文或者3-10位字母和数字的组合");
            return false;
        }else{
            show_validate_msg("#empName","success","");
        }
        //2.校验邮箱格式
        if(!(regexMail.test(empMail))){
            show_validate_msg("#empMail","error","邮箱要求2-6位由数字或字母组成且包含@的字符串");
            return false;
        }else{
            show_validate_msg("#empMail","success","");
        }
        return true;
    }

    //使用ajax校验用户名是否重复
    $("#empName").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${PATH}/checkEmpName",
            type:"post",
            data:"empName="+empName,
            success:function (result) {
                console.log(result);
                if(result.code==200){//表示输入的用户名不重复
                    show_validate_msg("#empName","success","输入的用户名可用");
                    //保存当前文本框的状态
                    $("#emp_save_btn").attr("ajax-status","success");
                }else if(result.code==100){//表示输入的用户名重复
                   // show_validate_msg("#empName","error","输入的用户名重复");
                    show_validate_msg("#empName","error",result.extend.tip_msg);
                    $("#emp_save_btn").attr("ajax-status","error");
                }
            }
        });
    });

    //显示提示信息
    function show_validate_msg(ele,status,msg){
        //清除原先的历史记录
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //给该按钮添加单击事件
    $("#add_emp_btn").click(function () {
        //在提交数据之前，进行格式校验，只有输入的内容格式都正确了，才能发送ajax请求提交数据到服务器
       if(!checkForm()) {
         return false;
       }
       if($(this).attr("ajax-status")=="error"){
           return false;
       }
        //使用ajax从客户端向服务器发送数据
        $.ajax({
            url:"${PATH}/employee",
            type:"post",
            data:$("#emp_add_model form").serialize(),
            success:function (result) {
              //  alert(result.msg);
                if(result.code==200){//员工信息发送成功，模态框消失
                    $("#emp_add_model").modal("hide");
                    //发送ajax请求，显示最后一页信息
                    to_page(totalRecord);
                }else{//员工信息发送失败，在模态框中显示失败信息
                   // console.log(result);
                    //失败信息主要集中在两点：用户名和邮箱

                   //有哪个字段的错误信息就显示哪个字段的
                    if(undefined != result.extend.errorFields.empMail){
                        //显示邮箱错误信息
                        show_validate_msg("#empMail","error",result.extend.errorFields.empMail);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

// ==============================修改员工信息================================================
    //编辑按钮是在发送了ajax请求后创建出来地。因此通过 $(".edit_btn").click()绑定会失败
    /*在这种情况下，可以通过以下两种方式绑定单击事件：
    *   1）可以在创建按钮地时候绑定；
    *   2）绑定点击事件.live()。jquery新版没有live，可以使用on进行替代
    * */
    $(document).on("click",".edit-btn",function () {
        //alert("edit");
        //点击“编辑”按钮，弹出编辑地模态框，模态框里面显示员工信息
        //0. 查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //1.查出部门信息，并显示部门列表
         getDepts("#emp_update_model select");
        //2.将员工的Id传递给模态框的“编辑”按钮
        $("#update_emp_btn").attr("edit-id",$(this).attr("edit-id"));

        //3.弹出模态框
        $("#emp_update_model").modal({
            backdrop:"static"
        });
    });

    //查询员工信息地请求方法
    function getEmp(id) {
        $.ajax({
           url:"${PATH}/employee/"+id,
           type:"GET",
           success:function (result) {
               //从json对象中获取employee数据
               var empData = result.extend.emp;
               //显示员工姓名
               $("#empName_update").text(empData.empName);
               //显示员工邮箱
               $("#empMail_update").val(empData.empMail);
               //显示员工性别
               $("#emp_update_model input[name=empGender]").val([empData.empGender]);
               //$("#emp_update_model input[type=radio]").val([empData.empGender]);
               //显示下拉列表
               $("#emp_update_model select").val([empData.dId]);
            }
        });
    }

    //点击更新按钮，提交员工信息
    $("#update_emp_btn").click(function () {
  //校验电子邮箱的格式是否正确
        var empMailUpdate = $("#empMail_update").val();//电子邮箱
        var regexMail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        //校验邮箱格式
        if(!(regexMail.test(empMailUpdate))){
            show_validate_msg("#empMail_update","error","邮箱要求2-6位由数字或字母组成且包含@的字符串");
            return false;
        }else{
            show_validate_msg("#empMail_update","success","");
        }

        //邮箱格式成功后，发送ajax请求,保存员工更新的信息
      /* $.ajax( {
           url:"${PATH}/employee/"+$(this).attr("edit-id"),
           type:"POST",
           data:$("#emp_update_model form").serialize()+"&_method=PUT",
           success:function (result) {
               alert(result.msg);
           }
       });*/

        /*若是直接发送PUT请求，会产生问题
        *  如果使用Ajax直接发送PUT请求，会拿不到请求体中的数据。
        *原因：tomcat：
              1）将请求体中的数据封装成一个map对象；
              2）request.getParameter("empName")就会从这个map中取值;  
              3)SpringMVC封装POJO对象的时候，会把POJO中每个属性的值，request.getParameter("empName");
        引发的“血案”：
           PUT请求:请求体中的数据，采用request.getParameter(“empName”)的方式拿不到。tomcat一看是PUT
           请求不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map。

           解决：在web.xml中配置HttpPutFormContentFilter过滤器。作用：
              1）将请求体中的数据解析包装成一个map；2）重新包装request请求：request.getParameter()
              被重写，就会从自己封装的map中取数据
        * */
        $.ajax( {
            url:"${PATH}/employee/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#emp_update_model form").serialize(),
            success:function (result) {
                //关闭模态框
                $("#emp_update_model").modal("hide");
                //返回到当前页
                to_page(currentPage);
            }
        });
    });

    //========================================删除===========================================
    //1. 单个删除
   $(document).on("click",".delete-btn",function () {
       //1.1 弹出是否确认删除的对话框。获取的是<tr><td></td></tr>中的文本值
       var empName = $(this).parents("tr").find("td:eq(2)").text();
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

   //全选与全不选

    //1.点击全选/全不选按钮，其后的复选框同样的变化
    $("#checkbox-all").click(function () {
        //获取当前元素的属性值。注意：此处使用prop而不是attr（prop适用于原生属性，attr适用于自定义属性）
        $(".check-item").prop("checked",$(this).prop("checked"));
    });

    /*2. 给每一个复选框绑定一个单击事件，判断其是否被选中，并统计被选中的复选框个数。
    *  若被选中的复选框的个数与当前页数据条数相同，则将全选复选框选中；否则，全选
    * 复选框不选中
    * */
    $(document).on("click",".check-item",function () {
       var flag = $(".check-item:checked").length==$(".check-item").length;
       $("#checkbox-all").prop("checked",flag);
    });
//执行批量删除操作
    $("#delete-all").click(function () {
        var empNames = "";
        var del_Ids = "";
        //遍历被选中的复选框的数组
        $.each( $(".check-item:checked"),function () {
            //获取被选中复选框中当前遍历到的员工姓名
            var empName = $(this).parents("tr").find("td:eq(2)").text()+",";
            var del_id = $(this).parents("tr").find("td:eq(1)").text()+"-";
            //拼接员工姓名字符串，以,分隔
            empNames += empName;
            del_Ids += del_id;
        });

        //去掉最后面的，
        empNames = empNames.substring(0,empNames.length-1);
        del_Ids = del_Ids.substring(0,del_Ids.length-1);

        //使用是否确认模态框，确认是否执行删除操作
        if(confirm("确定要删除【"+empNames+"】吗？")){
            //点击确认后，发送ajax请求，操作数据库，执行删除
            $.ajax({
                url:"${PATH}/employee/"+del_Ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //返回当前页
                    to_page(currentPage);
                    $("#checkbox-all").prop("checked",false);
                }
            });
        }
    });
</script>
</body>
</html>
