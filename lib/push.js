var apn = require('apn'),
	db = require('./db.js');

var connection = new apn.Connection({
	gateway:'gateway.sandbox.push.apple.com',
	passphrase:'pushNotify',
	cert:__dirname+'/cert.pem',
	key:__dirname+'/key.pem'
});

function sendNotifications (devices, alert, json) {
	var note = new apn.Notification();
	note.payload = json;
	note.alert = alert;
	devices.forEach(function (device) {
		note.badge = device.noteCount;
		note.sound = 'default';
		var device = new apn.Device(device.deviceToken);
		connection.pushNotification(note,device);
	});
};


/*
*	Send a notification
* 	args: ( uids:[Ints], alert:String, json:json )
*/
exports.notify = function (uids, alert, json) {
	db.addNotification(uids, json, function(devices) {
		return sendNotifications(devices, alert, json);
	});
};

/*
*	Fetch push notifications
*	args: ( uid:Int, cb(notifications[]) )
*/
exports.fetch = db.fetchNotifications;

/*
*	Acknowledge a fetch, return notificiation counter to 0
*	args: ( uid:Int )
*/
exports.ack = db.ackNotifications;

/*
*	Add a user (not tested lol)
*	args: ( deviceToken:String, cb(uid:Int) )
*/
exports.addUser = db.addUser;