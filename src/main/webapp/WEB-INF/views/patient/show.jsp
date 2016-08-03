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
              <i class="fa fa-info"></i>
              <a href="patient-list.html"> 患者列表</a>  /  患者基本信息
            </span>
                    <a href="javascript:;" id="delLink" style="color: white" rel="${patient.id}" class="pull-right"><i class="fa fa-times"></i> 删除</a>
                    <a href="/patient/${patient.id}/edit"  style="color: white;margin-right: 10px" class="pull-right"><i class="fa fa-edit"></i> 修改</a>
                </div>
                <div class="box-body">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td width="100"><strong>姓名</strong></td>
                            <td width="300">${patient.name}</td>
                            <td width="100"><strong>性别</strong></td>
                            <td width="300">${patient.sex}</td>
                            <td width="100"><strong>年龄</strong></td>
                            <td width="">${patient.age}</td>
                        </tr>
                        <tr>
                            <td><strong>身份证号</strong></td>
                            <td>${patient.idcard}</td>
                            <td><strong>联系电话</strong></td>
                            <td>${patient.telphone}</td>
                            <td><strong>医保类型</strong></td>
                            <td>${patient.insurance.type}</td>
                        </tr>
                        <tr>
                            <td><strong>地址</strong></td>
                            <td colspan="5">${patient.address}</td>
                        </tr>
                        <tr>
                            <td colspan="6"><strong>过敏史</strong></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>${patient.guominshi}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6"><strong>备注</strong></td>
                        </tr>
                        <tr>
                            <td colspan="6">${patient.remark}</td>
                        </tr>
                        </tbody>

                    </table>
                </div>
            </div>
            <!-- box end -->
            <div class="box">
                <div class="box-header">
                    <span class="title"><i class="fa fa-stethoscope"></i> 就诊记录</span>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th width="100">日期</th>
                            <th width="150">科室</th>
                            <th width="200">病种</th>
                            <th>初步诊断</th>
                            <th width="50"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>2014-07-02</td>
                            <td>内科</td>
                            <td>流感</td>
                            <td>流行性感冒</td>
                            <td>
                                <a href="">详情</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
            <!-- box end -->
        </div>

    </div>
</div>
<div class="modal fade" id="ediPatientModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑病人信息</h4>
            </div>
            <div class="modal-body">
                <form  method="post" id="editForm">
                    <input type="hidden" value="${patient.id}">
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" value="${patient.name}" name="name" autofocus id="edit_name" class="form-control"></div>
                    <label>性别</label>
                    <div class="form-group">
                        <select name="sex" id="save_sex" class="form-control">
                            <option ${patient.sex=="男"?"selected":""} value="男">男</option>
                            <option value="女" ${patient.sex=="女"?"selected":""} selected>女</option>
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
                                <option ${patient.insurance.id==insurance.id?"selected":""} value="${insurance.id}">${insurance.type}</option>
                            </c:forEach>
                        </select></div>
                    <div class="form-group">
                        <label>住址</label>
                        <input name="address" value="${patient.address}" id="edit_address" type="text" class="form-control"></div>
                    <div class="form-group">
                        <label>过敏史</label>
                            <textarea id="edit_guominshi" content="${patient.guominshi}"  name="guominshi"
                                      style="height:50px"></textarea></div>
                    <div class="form-group">
                        <label>备注</label>
                        <textarea id="edit_remark" content="${patient.remark}" name="remark"></textarea></div>
                    <div class="form-actions">
                        <button class="btn btn-primary">保存</button>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="editBtn">保存</button>
                </div>
            </div>

        </div>
    </div>
</div>



<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script>
    $(function(){
        $("#delLink").click(function(){
            var id = $(this).attr("rel");
           if (confirm("是否确认删除该客户?")){
               $.get("/patient/"+id+"/del").done(function(data){
                   if (data.state=="success"){
                       alert("删除成功");
                   }
               }).fail(function(){
                   alert("服务器异常,删除失败.")
               })
           }
        })
    })
</script>
</body>
</html>