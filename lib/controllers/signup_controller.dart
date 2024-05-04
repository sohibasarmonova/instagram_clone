
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/member_model.dart';
import '../pages/home_page.dart';
import '../pages/signin_page.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import '../services/prefs_servise.dart';
import '../services/utils_service.dart';

class SignUpController extends GetxController{

  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  doSignUp(BuildContext context) async{
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) return;

    if (cpassword != password) {
      Utils.fireToast("Password and confirm password does not match");
      return;
    }


      isLoading = true;


    AuthService.signUpUser( context,fullname, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser, Member(fullname, email)),
    });
  }

  _getFirebaseUser(User? firebaseUser, Member member) async {
      isLoading = false;
      update();
    if (firebaseUser != null) {
      saveMemberIdToLocal(firebaseUser);
      saveMemberToCloud(member);

      callHomePage();
    } else {
      Utils.fireToast("Check your information");
    }
  }

  saveMemberIdToLocal(User firebaseUser)async{
    await Prefs.saveUserId(firebaseUser.uid);
  }
  saveMemberToCloud(Member member) async{
    await DBService.storeMember(member);
  }

  callHomePage(){
    Get.toNamed( HomePage.id);
  }

  callSignInPage() {
    Get.toNamed( SignInPage.id);
  }

}