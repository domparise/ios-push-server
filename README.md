IOS push notification server  
============================  
  
Abstraction to apple push notifications as module for node.js mobile app server.  
  
Uses mysql to handle the badge icon number.

Exposes 4 methods.
push.notify([uids], alertText, {object});   // send a push notification  
push.fetch(uid, callback(data) );           // load all notifications sent for a given user  
push.ack(uid);                              // acknowledge the sending of notifications
push.addUser( deviceToken, callback(uid) ); // add a user to the system
  

Tested and built using mysql Ver 14.14 Distrib 5.5.36.  
  
  
Also, you need an apple certified cert and key:  
https://github.com/argon/node-apn/wiki/Preparing-Certificates  