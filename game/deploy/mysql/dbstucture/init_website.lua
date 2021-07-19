--[[
    desc:初始化后台相关数据
    auth:Carol Luo
]]
return {
	[[USE `dbwebsite`;]],
	---初始域名
	[[INSERT INTO `dbwebsite`.`domains`(`domain`, `hosts`, `genre`) VALUES ('domain1', '127.0.0.1', 'xsServer');]],
	[[INSERT INTO `dbwebsite`.`domains`(`domain`, `hosts`, `genre`) VALUES ('domain2', '127.0.0.1', 'xsWebsite');]],
	[[INSERT INTO `dbwebsite`.`domains`(`domain`, `hosts`, `genre`) VALUES ('domain3', '127.0.0.1', 'xsClient');]],
	---初始账号
	[[INSERT INTO `dbwebsite`.`admins`(`admin`, `verify`, `right`) VALUES ('root','123456', 'root');]],
	[[INSERT INTO `dbwebsite`.`admins`(`admin`, `verify`, `right`) VALUES ('admin','123456', 'admin');]],
	[[INSERT INTO `dbwebsite`.`admins`(`admin`, `verify`, `right`) VALUES ('waiter','123456', 'waiter');]],
}