IOS push notification server  
============================  
  
Abstraction to apple push notifications as module for node.js mobile app server.  
  
If you [ var push = require('./push.js') ], you expose 3 methods.
push.notify({object});          // send a push notification  
push.fetch( callback(data) );   // load all notifications sent for a given user  
push.ack();                     // acknowledge the sending of notifications  
  

Tested and built using mysql Ver 14.14 Distrib 5.5.36.  
  
  
One need only add users, to enable push notifications for a node.js backed mobile app.  

Also, you need an apple certified cert, this link walks through the basic idea of how to go about getting one. 
http://www.raywenderlich.com/32960/apple-push-notification-services-in-ios-6-tutorial-part-1