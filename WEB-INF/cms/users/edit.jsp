<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
  <form id="users-edit-form" action="/cms/users/${record.id}/edit" method="post">
    <div class="cms-mb20">
      <div class="cms-mb5">名称:</div>
      <input class="easyui-textbox" name="name" value="${record.name}" data-options="required:true, readonly: true" style="width:100%; height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">昵称:</div>
      <input class="easyui-textbox" name="title" value="${record.title}" data-options="required:true, prompt:'昵称'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">用户类型:</div>
      <select class="easyui-combobox" data-options="panelHeight:'auto',editable: false" name="userType" style="width:100%; height:32px">
        <option value="1" <c:if test="${record.type == 1}">selected</c:if>>普通用户</option>
        <option value="2" <c:if test="${record.type == 2}">selected</c:if>>管理员</option>
      </select>
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">状态:</div>
      <select class="easyui-combobox" name="state" data-options="panelHeight:'auto',editable: false" style="width:100%; height:32px">
        <option value="1" <c:if test="${record.state == 1}">selected</c:if>>启用</option>
        <option value="0" <c:if test="${record.state == 0}">selected</c:if>>禁用</option>
        <option value="2" <c:if test="${record.state == 2}">selected</c:if>>锁定</option>
        <option value="3" <c:if test="${record.state == 3}">selected</c:if>>删除</option>
      </select>
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">用户简介:</div>
      <input class="easyui-textbox" name="description"  value="${record.description}" data-options="multiline:true" style="width:100%;height:64px">
    </div>
    <button class="easyui-linkbutton" onclick="usersEditSubmitForm()" style="width:100%;height:32px">更新</button>
  </form>
  </div>
</div>
<script>
function usersEditSubmitForm(){
  $('#users-edit-form').form({
    success: function(data) {
    	CMS.editSubmitHandler(data, usersEL);
    }
  });
}
</script>
</body>