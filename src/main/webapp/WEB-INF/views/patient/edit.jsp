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
    <form  id="editForm" method="post" action="/patient/edit">
        <input type="hidden" name="id" value="${patient.id}">
        <div class="form-group">
            <label>姓名</label>
            <input type="text" value="${patient.name}" name="name" autofocus id="edit_name" class="form-control"></div>
        <label>性别</label>
        <div class="form-group">
            <select name="sex" id="save_sex" class="form-control">
                <option ${patient.sex=="男"?"selected":""} value="男">男</option>
                <option value="女" ${patient.sex=="女"?"selected":""} >女</option>
            </select></div>
        <div class="form-group">
            <label>身份证号</label>
            <input type="text" value="${patient.idcard}" name="idcard" id="edit_idcard" class="form-control">
        </div>
        <div class="form-group">
            <label>年龄</label>
            <input type="text" name="age" value="${patient.age}" id="edit_age" class="form-control"></div>
        <div class="form-group">
            <label>电话</label>
            <input type="text" name="telphone" value="${patient.telphone}" id="edit_telphone" class="form-control">
        </div>
        <div class="form-group">
            <label>医保类型</label>
            <select name="insurance.id" id="edit_insurance" class="form-control">
                <option value=''></option>
                <c:forEach items="${insuranceList}" var="insurance">
                    <option value="${insurance.id}" ${patient.insurance.id==insurance.id?"selected":""}>${insurance.type}</option>
                </c:forEach>
            </select></div>
        <div class="form-group">
            <label>住址</label>
            <input name="address" value="${patient.address}" id="edit_address" type="text" class="form-control"></div>
        <div class="form-group">
            <label>过敏史</label>
                            <textarea id="edit_guominshi" name="guominshi"
                                      style="height:50px">${patient.guominshi}</textarea></div>
        <div class="form-group">
            <label>备注</label>
            <textarea id="edit_remark" name="remark">${patient.remark}</textarea></div>
    </form>
    <div class="form-actions">
        <button class="btn btn-primary pull-right" id="editBtn">保存</button>
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
        var editor = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $('#edit_guominshi'),
            placeholder: "请输入过敏史,没有则填'无'",
        });
        var editor2 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $('#edit_remark'),
            placeholder: "请输入备注,没有则填'无'",
        });
        $("#editForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                name: {
                    required: true,
                },
                idcard: {
                    required: true,
                },
                telphone: {
                    required: true
                },
                address: {
                    required: false,
                },
                guominshi: {
                    required: true,
                },
                remark: {
                    required: true
                },
                age: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "请输入姓名",
                },
                idcard: {
                    required: "请输入身份证",
                },
                telphone: {
                    required: "请输入电话",
                },
                address: {
                    required: false,
                },
                guominshi: {
                    required: "请输入过敏史,没有则填无",
                },
                remark: {
                    required: "请输入备注"
                },
                age: {
                    required: "请输入年龄"
                }
            },
            submitHandler: function (form) {
                $.post("/patient/edit", $(form).serialize()).done(function (data) {
                    if (data.state == "success") {
                        alert(data.message);
                        window.location.href = "/patient";
                    }
                }).fail(function () {
                    alert("服务器出错,保存失败.")
                })
            }
        })
        $("#editBtn").click(function(){
            $("#editForm").submit();
        })
    })
</script>
</body>
</html>