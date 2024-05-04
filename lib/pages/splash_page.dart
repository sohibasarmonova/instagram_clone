
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  static const String id="splash_page";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = Get.find<SplashController>();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _controller. initTimer(context);
   _controller.initNotification();
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
