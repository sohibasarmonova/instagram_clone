import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:ngdemo17/services/prefs_servise.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

class Utils {
  static void fireToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<bool> dialogCommon(
      BuildContext context,String title, String message, bool isSingle) async {
    return await Get.defaultDialog(
        content: AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        !isSingle
            ? MaterialButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: const Text("Cancel"),
              )
            : const SizedBox.shrink(),
        MaterialButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text("Confirm"),
        ),
      ],
    ));
  }

  static String currentDate() {
    DateTime now = DateTime.now();

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}:${now.minute.toString()}";
    return convertedDateTime;
  }

  static Future<Map<String, String>> deviceParams() async {
    Map<String, String> params = {};
    var getDeviceId = await PlatformDeviceId.getDeviceId;
    String fcmToken = await Prefs.loadFCM();

    if (Platform.isIOS) {
      params.addAll({
        'device_id': getDeviceId!,
        'device_type': "I",
        'device_token': fcmToken,
      });
    } else {
      params.addAll({
        'device_id': getDeviceId!,
        'device_type': "A",
        'device_token': fcmToken,
      });
    }
    return params;
  }
}
