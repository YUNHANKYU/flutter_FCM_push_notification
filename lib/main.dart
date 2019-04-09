import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String textValue = 'Hello World !';
  String uid = '';
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//  new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

//    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
//    var ios = new IOSInitializationSettings();
//    var platform = new InitializationSettings(android, ios);
//    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) {
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) {
//        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });
  }

//  showNotification(Map<String, dynamic> msg) async {
//    var android = new AndroidNotificationDetails(
//      'sdffds dsffds',
//      "CHANNLE NAME",
//      "channelDescription",
//    );
//    var iOS = new IOSNotificationDetails();
//    var platform = new NotificationDetails(android, iOS);
//    await flutterLocalNotificationsPlugin.show(
//        0, "This is title", "this is demo", platform);
//  }


//    ========================================================================
  update(String token) {
    ///삭제 - uid 대용///
    Random rnd;
    int min = 5;
    int max = 10;
    int r;
    rnd = new Random();
    r = min + rnd.nextInt(max - min);
    uid = '$r';
    ///삭제 - uid 대용///
    print("This token is : $token");
    Firestore.instance.document('users/$uid').setData({
      "userName": uid,
      "userTokenId": token
    });
//    ========================================================================
//    DatabaseReference databaseReference = new FirebaseDatabase().reference();
//    databaseReference.child('fcm-token/$token').set({
//      "userName": "currentUid", //현재 로그인한 유저
//      "userTokenId": token
//    });
//    ========================================================================

    textValue = token;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Push Notification Final'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                textValue,
              ),
              Card(),
              RaisedButton(
                onPressed: () => addFriends(),
                color: Colors.black,
                highlightColor: Colors.white,
                child: Text(
                  "친구추가",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addFriends() {
    Firestore.instance.document('users/8').updateData({
      "challengeUser": '6',
    });
  }
}
