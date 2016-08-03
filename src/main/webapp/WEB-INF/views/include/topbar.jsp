<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!-- Static navbar -->
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">91医院</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <shiro:hasAnyRoles name="员工,主任">
                    <li class="${param.menu=='home'?'active':''}"><a href="/home"><i class="fa fa-home"></i> 首页</a></li>
                    <li class="${param.menu=='patient'?'active':''}"><a href="/patient"><i class="fa fa-building"></i>
                        病人档案</a>
                    </li>
                    <li class="${param.menu=='visit'?'active':''}"><a href="/visit/list"><i
                            class="fa fa-stethoscope"></i>
                        就诊记录</a></li>
                    <li class="${param.menu=='remind'?'active':''}"><a href="/remind"><i class="fa fa-bell-o"></i> 复诊提醒</a>
                    </li>
                    <li class="${param.menu=='count'?'active':''}"><a href="/count"><i class="fa fa-bar-chart-o"></i>
                        数据统计</a>
                    </li>
                </shiro:hasAnyRoles>
                <shiro:hasAnyRoles name="管理员,员工,主任">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false"><i class="fa fa-cogs"></i>系统设置<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/dept"><i class="fa fa-sitemap"></i> 科室设置</a></li>
                            <li><a href="/disease"><i class="fa fa-medkit"></i> 病种设置</a></li>
                            <li><a href="/insurance"><i class="fa fa-bars"></i> 医保类型设置</a></li>
                            <li><a href=""><i class="fa fa-child"></i> 患者状态设置</a></li>
                            <li class="divider"></li>
                            <li><a href="/admin/userlist"><i class="fa fa-user-md"></i> 账号设置</a></li>
                        </ul>
                    </li>
                </shiro:hasAnyRoles>
            </ul>
            <li class="dropdown">
                <ul class="nav navbar-nav navbar-right ">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">
                            <i class="fa fa-cog"></i>个人设置 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/user"><i class="fa fa-sitemap"></i> 查看个人资料</a></li>
                            <li><a href="/user/password"><i class="fa fa-medkit"></i> 修改密码</a></li>
                            <li class="divider"></li>
                            <li><a href="/logout"><i class="fa fa-user-md"></i>安全退出</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </div><!--/.nav-collapse -->
    </div>
</nav>
<!-- Static navbar -->
