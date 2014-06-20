var express = require('express'),
	push = require('../index.js'),
	app = express();

app.use(require('body-parser')());

// push.notify to send a push notification, with arg0 as an object to pass as data
push.notify([1], "YOLOYOLO", { something:"happening"});

// push.fetch to get all of the notifications received since the last fetch 
app.get('/fetch', function (req, res) {
	console.log('fetch');
	console.log(req.body);
	push.fetch(1,function (data) {
		console.log(data);
		res.send(data);
	});
});

// acknowledge the sending of a push notification
app.post('/ack', function (req, res) {
	console.log('ack');
	if (req.body.seen) {
		push.ack(1);
	}
	res.end();
});

app.listen(3000);