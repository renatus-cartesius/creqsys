var mariadb = require("mariadb")
var pool = 
	mariadb.createPool({
		host: "127.0.0.1",
		port: 3306,
		user: "creqsys",
		password: "pass",
		database: "creqsys_db"
	});

module.exports = Object.freeze({
	pool: pool
});
