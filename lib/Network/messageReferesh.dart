import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class MessageProvider extends ChangeNotifier {
  dynamic _messageTitle;
  dynamic _messageBody;

  MessageProvider() {
    // _configureFirebaseMessagin();
  }

  // void _configureFirebaseMessagin() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     _messageTitle = message.notification!.title;
  //     _messageBody = message.notification!.body;
  //   });

  //   print("REFRESHING...");
  //   notifyListeners();
  // }

  void triggerMessage(String title, String body) {
    _messageTitle = title;
    _messageBody = body;

    notifyListeners();
  }

  get messageTitle => _messageTitle;
  get messageBody => _messageBody;
}
