import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';
import '../pages/signin_page.dart';
import '../services/auth_service.dart';
import '../services/log_service.dart';
import '../services/notif_service.dart';
import '../services/prefs_servise.dart';

class SplashController extends GetxController{
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  callNextPage(BuildContext context){
    if(AuthService.isLoggedIn()){
      Get.offNamed( HomePage.id);
    }else{
      Get.offNamed( SignInPage.id);
    }
  }
  initTimer(BuildContext context){
    Timer(Duration(seconds: 2,),(){
      //print("Waited 2 second");
      callNextPage(context);
    });
  }



  initNotification() async{
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      LogService.i('User granted permission');
    }else{
      LogService.e('User declined or has not accepted permission');
    }

    _firebaseMessaging.getToken().then((value) async{
      String fcmToken = value.toString();
      Prefs.saveFCM(fcmToken);
      String token = await Prefs.loadFCM();
      LogService.i("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification!.title.toString();
      String body = message.notification!.body.toString();
      LogService.i(title);
      LogService.i(body);
      LogService.i(message.data.toString());

      NotifService().showLocalNotification(title,body);

      //
    });
  }
}


