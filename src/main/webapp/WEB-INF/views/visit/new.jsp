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
    <link rel="stylesheet" href="/static/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="/static/plugins/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="/static/plugins/webuploader/webuploader.css">
</head>
<body>

<jsp:include page="../include/topbar.jsp">
    <jsp:param name="menu" value="visit"/>
</jsp:include>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">

            <div class="box">
                <div class="box-header">
            <span class="title">
              <i class="fa fa-info"></i>
              患者基本信息
            </span>
                </div>
                <div class="box-body">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td width="100"><strong>姓名</strong></td>
                            <td width="300">
                                ${patient.name}
                            </td>
                            <td width="100"><strong>性别</strong></td>
                            <td width="300">${patient.sex}</td>
                            <td width="100"><strong>年龄</strong></td>
                            <td>${patient.age}</td>
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
                            <td colspan="6">${patient.guominshi}
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
            <span class="title">
              <i class="fa fa-plus"></i> 病历信息
            </span>
                </div>
                <div class="box-body form">
                    <form id="saveForm" method="post" action="/visit/new">
                        <input type="hidden" name="patient.id" value="${patient.id}">
                        <div class="form-group">
                            <label>科室</label>
                            <select name="dept.id" id="save_deptid" class="form-control">
                                <option value=""></option>
                                <c:forEach items="${deptList}" var="dept">
                                    <option value="${dept.id}">${dept.deptname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>病种</label>
                            <select name="disease.id" id="save_diseaseid" class="form-control">
                                <option value=""></option>
                                <c:forEach items="${diseaseList}" var="disease">
                                    <option value="${disease.id}">${disease.illness}</option>
                                </c:forEach>
                            </select></div>
                        <div class="form-group">
                            <label>初步诊断</label>
                            <input type="text" id="save_chubuzhenduan" name="chubuzhenduan" class="form-control"></div>
                        <div class="form-group">
                            <label>主要症状</label>
                            <textarea class="form-control" name="zhengzhuang" id="editor1" rows="2"></textarea>
                        </div>
                        <div class="form-group">
                            <label>相关病史</label>
                            <textarea class="form-control" name="bingshi" id="editor2" rows="3"></textarea></div>
                        <div class="form-group">
                            <label>阳性体征</label>
                            <textarea class="form-control" name="yangxingtezheng" rows="3" id="editor3"></textarea>
                        </div>
                        <div class="form-group">
                            <label>检查结果</label>
                            <textarea id="editor4" row3="3" class="form-control" name="jianchajieguo"
                                      id="editor4"></textarea></div>
                        <div class="form-group">
                            <label>治疗方案</label>
                            <textarea class="form-control" name="zhiliaofangan" rows="3" id="editor5"></textarea></div>
                        <div class="form-group">
                            <label>管床医生</label>
                            <input class="form-control" name="beddoctor" type="text"></div>
                        <div class="form-group">
                            <label>下次复诊时间</label>
                            <input type="text" class="form-control" name="nexttimeStr" id="save_nexttime"></div>
                        <label>影像资料</label>
                        <div id="picker">选择资料</div>
                        <ul id="fileList" class="thumbnails">
                            <li id="WU_FILE_0" class="span2 upload-state-done uploadfile">
                                <div class="msg">正在上传...</div>
                            </li>
                        </ul>
                        <button id="saveVisitBtn" type="submit" class="btn btn-primary pull-right">保存</button>
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
<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/static/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="/static/plugins/select2/dist/js/select2.min.js"></script>
<script src="/static/plugins/webuploader/webuploader.min.js"></script>
<script>
    $(function () {
        var uploader = WebUploader.create({

            // swf文件路径
            swf: '/static/plugins/webuploader/Uploader.swf',
            server: '/yingxiang/upload',
            pick: '#picker',

            resize: false,
            auto: true,//选择文件后直接上传
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });

        uploader.on('startUpload', function (file, data) {
            $("#picker .text").html("<i class='fa fa-spinner fa-spin'></i>上传中");
        });
        uploader.on('uploadSuccess', function (file, data) {
            if (data._raw == "success") {
                window.location.reload();
            }
        });

        uploader.on('uploadError', function (file) {
            alert('上传出错');
        });

        uploader.on('uploadComplete', function (file) {
            $("#picker .text").html("<i class='fa fa-upload'></i>上传文件").removeAttr("disabled");
        });
        var editor1 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $("#editor1"),
            placeholder: "请输入阳性特性,没有则填无"
        });
        var editor2 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $('#editor2'),
            placeholder: "请输入备注,没有则填'无'",
        });
        var editor3 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $("#editor3"),
            placeholder: "请输入阳性特性,没有则填无"
        });
        var editor4 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $('#editor4'),
            placeholder: "请输入备注,没有则填'无'",
        });
        var editor5 = new Simditor({
            toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'table', 'link', 'hr', 'indent', 'outdent'],
            textarea: $("#editor5"),
            placeholder: "请输入阳性特性,没有则填无"
        });

        $("#save_nexttime").datepicker({
            format: "yyyy-mm-dd",
            language: "zh-CN",
            autoclose: true
        })
        $("#save_deptid").select2({
            tags: true,
            maximumSelectionLength: 3  //最多能够选择的个数
        })
        $("#save_diseaseid").select2({
            tags: true,
            maximumSelectionLength: 3  //最多能够选择的个数
        })

    })
</script>
</body>
</html>