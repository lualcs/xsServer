--[[
    desc:构造管理员
    auth:Carol Luo
]]
return {
	[[USE `dbusers`;]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('root','adminroot','超级系统管理员','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00001','系统管理员00001','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00002','系统管理员00002','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00003','系统管理员00003','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00004','系统管理员00004','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00005','系统管理员00005','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00006','系统管理员00006','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00007','系统管理员00007','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00008','系统管理员00008','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00009','系统管理员00009','%s');]],
	[[INSERT INTO `users`(`office`,`users`, `nickname`, `logo`) VALUES ('admin','admin00010','系统管理员00010','%s');]],
}