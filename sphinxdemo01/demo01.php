<?php 
	header("Content-type:text/html;charset=utf-8");
	//引入接口文件
	require "sphinxapi.php";

	//实例化一个对象
	$sphinx = new SphinxClient();
	//匹配模式
	$sphinx->setMatchMode(SPH_MATCH_ALL);
	
	//指定连接的sphinx服务器和端口号
	$sphinx -> setServer("localhost",9312);
	$keyword = "叶问3";
	$indexname = 'a67';
	$res = $sphinx->query($keyword,$indexname);
	//获取改数组的键名
	$ids = $res['matches'];
	
	$ids = array_keys($ids);
	$ids = implode(',', $ids);
	
	//php操作mysql 获取数据
	error_reporting(E_ALL ^ E_DEPRECATED);
	mysql_connect('localhost','root','123456');
	mysql_query("set names utf8");
	mysql_query("use itdedecms");

	$sql = "select id,title,description from dede_archives where id in ({$ids})";

	$res = mysql_query($sql);
	
	while($row = mysql_fetch_assoc($res)){
		$data[] = $row;
	}
	mysql_close();

	//遍历数据查询结果
	foreach ($data as $k => $v) {
		//设置关键字输出演示
		$row = $sphinx->buildExcerpts($v,$indexname,$keyword,array(
				"before_match" =>"<font color ='red'>",
				"after_match" =>"</font>"
			));
		echo  $row[1].'<br/>'.$row[2]."<hr/>";
	}

