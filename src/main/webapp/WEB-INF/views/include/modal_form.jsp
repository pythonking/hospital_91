<!-- Modal -->
<div class="modal fade" id="newModalXXX">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加新XXX</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm" method="post">
                    <input type="hidden" id="startDate">
                    <input type="hidden" id="endDate">
                    <div class="form-group">
                        <label>XXX名称</label>
                        <div>
                            <input type="text" name="name" id="savename" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>关联客户</label>
                        <select id="saveCustid" name="custid" class="form-control">
                            <c:forEach items="${customerList}" var="cust">
                                <option value="${cust.id}">${cust.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>价值</label>
                        <input type="text" name="price" id="savePrice" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>当前进度</label>
                        <select class="form-control" name="progress" id="saveProgress">
                            <option value="初次接触">初次接触</option>
                            <option value="确认意向">确认意向</option>
                            <option value="提供合同">提供合同</option>
                            <option value="完成交易">完成交易</option>
                            <option value="交易搁置">交易搁置</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>