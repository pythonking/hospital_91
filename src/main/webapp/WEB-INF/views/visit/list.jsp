<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" href="/static/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="/static/plugins/select2/dist/css/select2.min.css">
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
                    <span class="title"><i class="fa fa-search"></i> 搜索</span>
                </div>
                <div class="box-body search-box">
                    <form action="" class="form-search">
                        <input type="text" name="q_s_like_name" placeholder="姓名">
                        <input type="text" name="q_s_like_telphone" placeholder="电话">
                        <input type="hidden" name="q_s_ge_nexttime" id="search_start_time">
                        <input type="hidden" name="q_s_le_nexttime" id="search_end_time">
                        <input type="text" id="rangepicker" placeholder="就诊时间">
                        <select name="state" id="state" style="width: 100px">
                            <option value="">状态</option>
                            <option value="就诊">就诊</option>
                            <option value="已出院">已出院</option>
                        </select>
                        <button class="button button-flat-primary button-pill"><i class="fa fa-search"></i> 搜索</button>
                    </form>
                </div>
            </div>


            <div class="box">
                <div class="box-header">
                    <span class="title"><i class="fa fa-stethoscope"></i> 就诊列表</span>
                    <a href="javascript:;" id="newLink" style="color: white" class="pull-right"><i
                            class="fa fa-plus"></i> 新建</a>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th width="20">
                                <input type="checkbox" class="checkbox">
                            </th>
                            <th width="100">姓名</th>
                            <th width="50">性别</th>
                            <th width="150">科室</th>
                            <th width="200">病种</th>
                            <th>初步诊断</th>
                            <th width="50">状态</th>
                            <th width="100">创建日期</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${visitPage.items}" var="visit">
                            <tr>
                                <td>
                                    <input type="checkbox" rel="${visit.patient.id}" class="checkone">
                                </td>
                                <td><a href="/patient/${visit.patient.id}">${visit.patient.name}</a></td>
                                <td>${visit.patient.sex}</td>
                                <td>${visit.dept.deptname}</td>
                                <td>${visit.disease.illness}</td>
                                <td>${visit.chubuzhenduan}</td>
                                <td>${visit.patient.state}</td>
                                <td><fmt:formatDate value="${visit.creattime}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="newVisitModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增就诊记录</h4>
            </div>
            <div class="modal-body">
                    <div class="form-group">
                        <label>患者信息</label>
                        <select autofocus id="select_name" style="width: 100%" class="form-control">
                            <c:forEach items="${patientList}" var="patient">
                                <option value="${patient.id}">${patient.name}:性别:${patient.sex};身份证:${patient.idcard};电话:${patient.telphone};地址:${patient.address}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">取消</button>
                    <button class="btn btn-primary newLink" id="newVisit">新建病历</button>
                </div>
            </div>

        </div>
    </div>
</div>


<script src="/static/js/jQuery-2.2.0.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/daterangepicker/moment.min.js"></script>
<script src="/static/plugins/daterangepicker/daterangepicker.js"></script>
<script src="/static/plugins/select2/dist/js/select2.min.js"></script>
<script>
    $(function () {
        $("#rangepicker").daterangepicker({
            format: "YYYY-MM-DD",
            separator: "~",
            locale: {
                "applyLabel": "选择",
                "cancelLabel": "取消",
                "fromLabel": "从",
                "toLabel": "到",
                "customRangeLabel": "自定义",
                "weekLabel": "周",
                "daysOfWeek": [
                    "一",
                    "二",
                    "三",
                    "四",
                    "五",
                    "六",
                    "日"
                ],
                "monthNames": [
                    "一月",
                    "二月",
                    "三月",
                    "四月",
                    "五月",
                    "六月",
                    "七月",
                    "八月",
                    "九月",
                    "十月",
                    "十一月",
                    "十二月"
                ],
                "firstDay": 1
            },
            ranges: {
                '今天': [moment(), moment()],
                '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                '最近7天': [moment().subtract(6, 'days'), moment()],
                '最近30天': [moment().subtract(29, 'days'), moment()],
                '本月': [moment().startOf('month'), moment().endOf('month')],
                '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        });
        $('#rangepicker').on('apply.daterangepicker', function (ev, picker) {
            $("#search_start_time").val(picker.startDate.format('YYYY-MM-DD'));
            $("#search_end_time").val(picker.endDate.format('YYYY-MM-DD'));
            console.log(picker.startDate.format('YYYY-MM-DD'));
            console.log(picker.endDate.format('YYYY-MM-DD'));
        });
        $("#newLink").click(function () {
            $("#newVisitModal").modal({
                show: true,
                backdrop: "static",
                keyboard: false
            })
        })
        $("#select_name").select2({
            tags: true,
            maximumSelectionLength:3,//最多能够选择的个数
            placeholder:'请选择患者信息'
        })
        $("#newVisit").click(function(){
            var keyword = $("#select_name").val();
            window.location.href = "/visit/"+keyword+"/new";
        })
    })
</script>

</body>
</html>