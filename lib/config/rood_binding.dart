import 'package:get/get.dart';
import 'package:ngdemo17/controllers/my_feed_controller.dart';
import 'package:ngdemo17/controllers/my_like_controller.dart';
import 'package:ngdemo17/controllers/my_profile_controller.dart';
import 'package:ngdemo17/controllers/my_search_controller.dart';
import 'package:ngdemo17/controllers/my_upload_controller.dart';
import 'package:ngdemo17/controllers/signin_controller.dart';
import 'package:ngdemo17/controllers/signup_controller.dart';

import '../controllers/home_controller.dart';
import '../controllers/splash_controller.dart';



class RoodBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController(),fenix: true);

    Get.lazyPut(() => HomeController(),fenix:true );
    Get.lazyPut(() => MyFeedController(),fenix: true);
    Get.lazyPut(() => MyLikeController(),fenix: true);
    Get.lazyPut(() => MyProfileController(),fenix: true);
    Get.lazyPut(() => MySearchController(),fenix: true);
    Get.lazyPut(() => MyUploadController(),fenix: true);
    Get.lazyPut(() => SignInController(),fenix: true);
    Get.lazyPut(() => SignUpController(),fenix: true);
  }
}