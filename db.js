var mysql = require('mysql');
	var sql = mysql.createConnection({
		host: '0.0.0.0',
		user: 'root',
		password: 'sql',
		database: 'pushNotify'
	});

function fetchDevices ( note, cb) {
	sql.query('select deviceToken,noteCount from User where uid=1', function (err, res) {
		if(err) error(err,cb);
		return cb(res);
	});
};

exports.addNotification = function (note, cb) {
	sql.query('insert into Notification (uid,note) values (1,?)', [[JSON.stringify(note)]], function (err, res) {
		if(err) error(err,cb);
		return fetchDevices( note, cb);
	});
};

exports.fetchNotifications = function (cb) {
	sql.query('select note,UNIX_TIMESTAMP(time) as time from Notification where uid=1', function (err, res) {
		if(err) error(err,cb);
		return cb(res);
	});
};

exports.ackNotifications = function () {
	sql.query('delete from Notification where uid=1', function (err) {
		if(err) console.log(err);
	});
}

function error (err,cb) {
	console.log(err);
	return cb(false);
};