var apn = require('apn'),
	db = require('./db.js');

var connection = new apn.Connection({'gateway':'gateway.sandbox.push.apple.com','passphrase':'pushNotify'});

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

exports.notify = function (json) {
	db.addNotification( json, function(devices) {
		var alert = 'New Notification';
		return sendNotifications(devices, alert, json);
	});
};

exports.fetch = db.fetchNotifications;

exports.ack = db.ackNotifications;