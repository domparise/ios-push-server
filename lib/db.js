var mysql = require('mysql');
	var sql = mysql.createConnection({
		host: '0.0.0.0',
		user: 'root',
		password: 'sql',
		database: 'pushNotify'
	});

function fetchDevices ( uids, note, cb) {
	sql.query('select deviceToken,noteCount from User where uid in (?)', [uids], function (err, res) {
		if(err) error(err,cb);
		return cb(res);
	});
};

exports.addNotification = function (uids, note, cb) {
	var inserts = new Array(uids.length);
	var noteStr = JSON.stringify(note);
	for(var i = 0; i < uids.length; i++) inserts[i] = [uids[i],noteStr];
	sql.query('insert into Notification (uid,note) values ?', [inserts], function (err, res) {
		if(err) error(err,cb);
		return fetchDevices( uids, note, cb);
	});
};

exports.fetchNotifications = function (uid, cb) {
	sql.query('select note,UNIX_TIMESTAMP(time) as time from Notification where uid=?', [uid], function (err, res) {
		if(err) error(err,cb);
		return cb(res);
	});
};

exports.ackNotifications = function (uid) {
	sql.query('delete from Notification where uid=?', [uid], function (err) {
		if(err) console.log(err);
	});
}

exports.addUser = function (deviceToken, cb) {
	sql.query('insert into User set ?', {deviceToken: deviceToken}, function (err, res) {
		if(err) error(err,cb);
		return cb(res.insertId);
	});
};

function error (err,cb) {
	console.log(err);
	return cb(false);
};