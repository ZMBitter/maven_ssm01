package com.zm.demo.bean;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{3,10}$)|(^[\\u2E80-\\u9FFF]{2,5})",message = "用户名要求2-5位中文或者3-10位字母和数字的组合")
    private String empName;
    private String empGender;
    //@Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message = "邮箱要求2-6位由数字或字母组成且包含@的字符串")
    private String empMail;
    private Integer dId;
    private Dept dept;//部门名

    public Employee() {
    }

    public Employee(Integer empId, String empName, String empGender, String empMail, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.empGender = empGender;
        this.empMail = empMail;
        this.dId = dId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public String getEmpMail() {
        return empMail;
    }

    public void setEmpMail(String empMail) {
        this.empMail = empMail == null ? null : empMail.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empGender='" + empGender + '\'' +
                ", empMail='" + empMail + '\'' +
                ", dId=" + dId +
                ", dept=" + dept +
                '}';
    }
}