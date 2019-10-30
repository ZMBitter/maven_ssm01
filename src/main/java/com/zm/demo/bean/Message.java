package com.zm.demo.bean;

import java.util.HashMap;
import java.util.Map;

/*返回给浏览器的状态信息类*/
public class Message {
    private Integer code;//状态码
    private String msg;//提示信息
    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String,Object>();

    public Message() {
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    /*请求成功时返回的信息*/
    public static Message success(){
        Message result = new Message();
        result.setCode(200);
        result.setMsg("处理成功！");
        return result;
    }

    /*请求失败时返回的信息*/
    public static Message fail(){
        Message result = new Message();
        result.setCode(100);
        result.setMsg("处理失败！");
        return result;
    }
/*可以执行链式添加的方法*/
    public Message add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
}
