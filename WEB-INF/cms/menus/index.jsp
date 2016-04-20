<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<title>菜单管理</title>
</head>
<body>
<header id="menus-header" class="cms-dg-header">
	<button id="menus-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="menus-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="menus-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="menus-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <select class="easyui-combobox" id="menus-state" data-options="panelHeight:'auto',editable: false" style="width:100px;">
        <option value="-1" selected>全部状态</option>
        <option value="1">启用</option>
        <option value="0">禁用</option>
      </select>
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:menusEL.search" style="width:200px" />
	</span>
</header>
<table id="menus-dg"></table>
<footer id="menus-win"></footer>
<script>
// 变量取值要唯一
var menusEL = {
	add: $("#menus-add"),
	edit: $("#menus-edit"),
	remove: $("#menus-remove"),
	reload: $("#menus-reload"),
	dg: $("#menus-dg"),
	win: $("#menus-win")
};

// DataGrid
menusEL.dg.datagrid({
    url:'/cms/menus/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    pageSize: 20,
    pageList:[20, 50, 100],
    header: '#menus-header',
    fit: true,
    columns:[[
        {field:'id', checkbox: true},
        {field:'name',title:'名称',width:100, sortable: true},
        {field:'title',title:'标题',width:100, sortable: true},
        {field:'path',title:'路径',width:100},
        {field:'description',title:'描述',width:100},
        {field:'organization',title:'分组',width:100, sortable: true},
        {field:'weight',title:'权重',width:100, sortable: true},
        {field:'state',title:'状态',width:100, sortable: true, formatter: function(value,row,index) {
        	if (value == '1') {
				return '启用';
			} else {
				return '禁用';
			}
        }},
        {field:'created',title:'创建时间',width:100, sortable: true, formatter: function(value,row,index) {
        	return new Date(value).format();  
        }},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true, formatter: function(value,row,index) {
        	return new Date(value).format();  
        }},
        {field:'creator',title:'创建人',width:100, sortable: true}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	menusEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	menusEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	menusEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	menusEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	CMS.viewHandler("/cms/menus/" + row.id);
    }
});

// 根据选择记录触发: 重置按钮状态
menusEL.reset = function() {
	var length = menusEL.dg.datagrid("getSelections").length;
	if (length == 0) { 
		/* 编辑和删除按钮 禁用 */
		menusEL.edit.linkbutton({disabled: true});
		menusEL.remove.linkbutton({disabled: true});
	} else if (length == 1) { 
		/* 编辑和删除按钮 启用 */
		menusEL.edit.linkbutton({disabled: false});
		menusEL.remove.linkbutton({disabled: false});
	} else {
		/* 编辑和删除按钮 禁用 */
		menusEL.edit.linkbutton({disabled: true});
		menusEL.remove.linkbutton({disabled: true});
	}
}

// 搜索
menusEL.search = function(value){
	menusEL.dg.datagrid('load',{
		title: value,
		state: $('#menus-state').combobox('getValue')
	});
}

// 新建
menusEL.add.click(function() {
	menusEL.win.window({
		width: 480,
		height: 650,
		modal: true,
		title: '新建菜单',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/menus/new',
		method: 'get',
		cache: false
	});
});

// 编辑
menusEL.edit.click(function() {
	var row = menusEL.dg.datagrid('getSelected');
	if (row) {
		menusEL.win.window({
			width: 480,
			height: 650,
			modal: true,
			title: '编辑菜单',
			collapsible: false,
			minimizable: false,
			maximizable: false,
			href: '/cms/menus/' + row.id + '/edit',
			method: 'get',
			cache: false
		});
	}
});

// 删除
menusEL.remove.click(function() {
	CMS.removeSubmitHandler(menusEL, 'menus');
});

// 刷新
menusEL.reload.click(function() {
	menusEL.dg.datagrid('clearSelections');
	menusEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>