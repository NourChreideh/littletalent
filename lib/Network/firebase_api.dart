import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Network/Response/ApiResponse.dart';
import 'package:kidsnursery/Network/Response/Status.dart';
import 'package:kidsnursery/Network/Response/resetData.dart';
import 'package:kidsnursery/Network/messageReferesh.dart';
import 'package:kidsnursery/Pages/HomePages/HomePage.dart';

import 'package:kidsnursery/Pages/LoginPage.dart';
import 'package:kidsnursery/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Widgets/BottomNavBar.dart';

class FirebaseApi {
  final _firebasemessaging = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Dialog(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  Future<ApiResponse> signInWithPhoneNumber(
      String phoneNumber, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email:
            '$phoneNumber@kidsnursery.com', 
        password: password,
      );

      if (userCredential.user != null) {
        final userDoc = await _firestore
            .collection('Users')
            .doc(userCredential.user!.uid)
            .get();
        if (userDoc.exists) {
          sharedPref.login();
          Users users = await fetchUser(userCredential.user!);
          await _setUpFirebaseMessaging(userCredential.user!);
          scheduleTask(users);
          navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
              builder: ((context) => BottomNavBar(
                
                  ))));

          return ApiResponse(Status.COMPLETED, null, 'Logged in Successfully');
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in: $e');
      return ApiResponse(Status.ERROR, null, e.code);
    }
    navigatorKey.currentState?.pop();
    return ApiResponse(Status.ERROR, null, 'Error');
  }

  Future<ApiResponse> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User Id rgistered 000000  ${userCredential.user!.uid}');
      if (userCredential.user != null) {
        final userDoc = await _firestore
            .collection('Users')
            .doc(userCredential.user!.uid)
            .get();
        print('UserDocuments are999999$userDoc');
        if (userDoc.exists) {
          // implememnt the need fo this login such as navigate to the homeScreen\
          sharedPref.login();
          // final currentUser = FirebaseAuth.instance.currentUser;
          Users users = await fetchUser(userCredential.user!);
          await _setUpFirebaseMessaging(userCredential.user!);

          navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
              builder: ((context) => HomePage(
                    user: users,
                  ))));

          return ApiResponse(Status.COMPLETED, null, 'Logged in Successfully');
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in: $e');
      return ApiResponse(Status.ERROR, null, e.code);

      // Handle sign-in errors
    }
    navigatorKey.currentState?.pop();
    return ApiResponse(Status.ERROR, null, 'Erorr');
  }

  void signOut() async {
    sharedPref.logout();
    await _auth.signOut();

    navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: ((context) => const LoginPage())));
  }

  String? fCMToken;
  Future<void> initnotification() async {
    await _firebasemessaging.requestPermission();
    fCMToken = await _firebasemessaging.getToken();
    sharedPref.setNotificationToken(fCMToken!);
    print('tocken is:  $fCMToken');
    await initpushNotification();
    await initLocalNotifications();
  }

  Future<void> _setUpFirebaseMessaging(User currentUser) async {
    // Request permission for handling notifications
    await _firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true);

    // Add the notification token to the user's document in Firestore

    print('tocken is:  $fCMToken');
    _firestore
        .collection('Users')
        .doc(currentUser.uid)
        .update({'notificationToken': sharedPref.getNotificationToken()});

    // Subscribe to a topic for receiving notifications related to scheduled programs
    _firebaseMessaging.subscribeToTopic('scheduled_programs');
  }

  Stream<QuerySnapshot> fetchChildren() async* {
    final querySnapshot = _firestore
        .collection('Users')
        .doc(currentUser?.uid)
        .collection('Children')
        .snapshots();
    // Children children = Children(
    //   querySnapshot['Age'] ?? 0,
    //   querySnapshot['firstName'] ?? '',
    //   querySnapshot['lastName'] ?? '',
    //   querySnapshot['profileimageUrl'] ?? '',
    // );
    querySnapshot;
  }

  Future<Users> fetchUser(User currentUser) async {
    final querySnapshot =
        await _firestore.collection('Users').doc(currentUser.uid).get();

    Users user = Users.fromSnapshot(querySnapshot);
    return user;
  }

  Future<StatefulWidget> checkAndNavigateUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (sharedPref.isLoggedIn()) {
      final userDoc = await fetchUser(currentUser!);

      return BottomNavBar();
    } else {
      return const LoginPage();
    }
  }

  // Initialize Workmanager in your app
}

Future<void> handlemessage(RemoteMessage message) async {
  Map<String, dynamic> messageData = message.data;

  print("here $messageData");
  String messageType = messageData['type'];
  if (messageType == 'child') {
    // navigatorKey.currentState?.push(MaterialPageRoute(
    //     builder: (context) => ProfilePage(user: globalusers)));
    // // } else if (messageType == 'newOrder') {
    //   navigatorKey.currentState
    // ?.push(MaterialPageRoute(builder: (context) => const Screen2()));
  }
}

Future<void> initpushNotification() async {
  MessageProvider();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.getInitialMessage();
  // .then((value) => handlemessage(value!));
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    handlemessage(event);
    FirebaseMessaging.onBackgroundMessage(hadlebackgroundmessaging);
    print('onMessageOpenApp:${event.data}');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    AndroidNotification? android = message.notification!.android;
    if (notification == null) return;
    _localNotification.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
              _androidchannel.id, _androidchannel.name,
              channelDescription: _androidchannel.description,
              icon: android?.smallIcon)),
      payload: jsonEncode(message.toMap()),
    );
  });
}

final _localNotification = FlutterLocalNotificationsPlugin();
Future initLocalNotifications() async {
  print("message ");

  const android = AndroidInitializationSettings('@drawable/ic_launcher');
  const setting = InitializationSettings(android: android);
  await _localNotification.initialize(
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
      handlemessage(message);
    },
    setting,
  );

  final platform = _localNotification.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(_androidchannel);
}

// final FirebaseMessaging _firabaseMessaging = FirebaseMessaging.instance;
//  final notification = message.notification;
//     if (notification == null) return;
//     _localNotification.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//                 _androidchannel.id, _androidchannel.name,
//                 channelDescription: _androidchannel.description,
//                 icon: '@drawable/ic_launcher')),
//         payload: jsonEncode(message.toMap()));
//   });

const _androidchannel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max);

Future<void> hadlebackgroundmessaging(RemoteMessage message) async {
  print('title${message.notification?.title}');
  print('body${message.notification?.body}');
  print('payload${message.data}');
}
