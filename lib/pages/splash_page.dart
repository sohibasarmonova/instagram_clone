import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo17/pages/signin_page.dart';

import '../services/auth_service.dart';
import '../services/log_service.dart';
import '../services/notif_service.dart';
import '../services/prefs_servise.dart';
import 'home_page.dart';
class SplashPage extends StatefulWidget {
  static const String id="splash_page";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _callNextPage(){
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Navigator.pushReplacementNamed(context, SignInPage.id);
    }
  }


  _initNotification() async{
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
  initTimer(){
    Timer(Duration(seconds: 2,),(){
      //print("Waited 2 second");
      _callNextPage();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTimer();
    _initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193,53,132,1),
                Color.fromRGBO(141,58,180,1),
              ]
          ),
        ),
        padding: EdgeInsets.all(50),
        //color: Colors.white,
        child: Stack(
          children: [
            Center(
              child:Text(
                "Instagram",
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: "Billabong",
                    color: Colors.white
                ),
              ),
            ),
            Container(
              //color: Colors.grey,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      "Powered by Fecbook",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,

                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

}
