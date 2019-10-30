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
           <button class="btn btn-info">新增</button>
           <button class="btn btn-danger">删除</button>
       </div>
   </div>
     <%--表格行--%>
   <div class="row">
       <div class="col-md-12">
          <table class="table table-bordered">
              <tr class="text-center">
                  <th>员工编号</th>
                  <th>员工姓名</th>
                  <th>性别</th>
                  <th>邮箱</th>
                  <th>所属部门</th>
                  <th>操作</th>
              </tr>

              <c:forEach items="${pageInfo.list}" var="emp">
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
              </c:forEach>

          </table>
       </div>
   </div>
     <%--分页信息显示行--%>
   <div class="row">
       <%--分页文字信息--%>
       <div class="col-md-6">
           <span style="font-size: 16px;">
               共有${pageInfo.total}条数据，共${pageInfo.pages}页，当前是第${pageInfo.pageNum}页
           </span>
       </div>
       <%--分页条信息--%>
       <div class="col-md-6">
           <nav aria-label="Page navigation">
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

                   <%--连续显示的页码--%>
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
</body>
</html>
