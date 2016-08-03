<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="/static/font/awesome/css/font-awesome.min.css">
    <%--<link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/plugins/simditor/styles/simditor.css">
</head>
<body>

<jsp:include page="../include/topbar.jsp">
    <jsp:param name="menu" value="patient"/>
</jsp:include>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">

            <div class="box">
                <div class="box-header">
            <span class="title">
              <i class="fa fa-plus"></i>
              <a href="patient-list.html"> 患者列表</a>  /  新增患者
            </span>
                </div>
                <div class="box-body form">
                    <form action="" method="post" id="saveForm">
                        <div class="form-group">
                            <label>姓名</label>
                            <input type="text" name="name" autofocus id="save_name" class="form-control"></div>
                        <label>性别</label>
                        <div class="form-group">
                            <select name="sex" id="save_sex" class="form-control">
                                <option value="男">男</option>
                                <option value="女" selected>女</option>
                            </select></div>
                        <div class="form-group">
                            <label>身份证号</label>
                            <input type="text" name="idcard" id="save_idcard" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>年龄</label>
                            <input type="text" name="age" id="save_age" class="form-control"></div>
                        <div class="form-group">
                            <label>电话</label>
                            <input type="text" name="telphone" id="save_telphone" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>医保类型</label>
                            <select name="insurance.id" id="save_insurance" class="form-control">
                                <option value=''></option>
                                <c:forEach items="${insuranceList}" var="insurance">
                                    <option value="${insurance.id}">${insurance.type}</option>
                                </c:forEach>
                            </select></div>
                        <div class="form-group">
                            <label>住址</label>
                            <input name="address" id="save_address" type="text" class="form-control"></div>
                        <div class="form-group">
                            <label>过敏史</label>
                            <textarea id="save_guominshi" name="guominshi"
                                      style="height:50px"></textarea></div>
                        <div class="form-group">
                            <label>备注</label>
                            <textarea id="save_remark" name="remark"></textarea></div>
                        <div class="form-actions">
                            <button class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/simditor/scripts/module.js"></script>
<script src="/static/plugins/simditor/scripts/hotkeys.min.js"></script>
<script src="/static/plugins/simditor/scripts/uploader.js"></script>
<script src="/static/plugins/simditor/scripts/simditor.js"></script>
<script src="/static/plugins/validation/jquery.validate.min.js"></script>
<script>
    $(function () {
        //        $("#yb").select2({
        //            placeholder: "请选择医保类型",
        //            width:'220px'
        //        });
        var editor = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $('#save_guominshi'),
            placeholder: "请输入过敏史,没有则填'无'",
        });
        var editor2 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $('#save_remark'),
            placeholder: "请输入备注,没有则填'无'",
        });
        $("#saveForm").validate({
            errorClass:"text-danger",
            errorElement:"span",
            rules:{
                name:{
                    required:true,
                },
                idcard:{
                    required:true,
                },
                telphone:{
                    required:true
                },
                address:{
                    required:false,
                },
                guominshi:{
                    required:true,
                },
                remark:{
                    required:true
                },
                age:{
                    required:true
                }
            },
            messages:{
                name:{
                    required:"请输入姓名",
                },
                idcard:{
                    required:"请输入身份证",
                },
                telphone:{
                    required:"请输入电话",
                },
                address:{
                    required:false,
                },
                age:{
                    required:"请输入年龄"
                }
            },
            submitHandler:function(form){
                if (!$("#save_guominshi").val()){
                    $("#save_guominshi").focus();
                    return;
                }
                if (!$("#save_remark").val()){
                    $("#save_remark").focus();
                    return;
                }
                $.post("/patient/new",$(form).serialize()).done(function(data){
                    if(data.state=="success"){
                        alert(data.message);
                        window.location.href="/patient";
                    }
                }).fail(function(){
                    alert("服务器出错,保存失败.")
                })
            }
        })
    });
</script>
</body>
</html>