import 'dart:convert';
import 'package:http/http.dart';
import 'package:ngdemo17/model/member_model.dart';
import '../model/notification_model.dart';

class Network {
  static String SERVER_FCM = "fcm.googleapis.com";

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization':
    'key=AAAAsWvDVCs:APA91bHSdZ_miDt-DKYK2gWBzRZFRL-3rfDndEp0a-UgPKp10YIoFBeuTG7-SnixYDWOncq8YDjoDZf5zR2YfFw72y7V3ZH8kkm32OJ-a-HptCAxKrFi9PrGIOvI5dvjt4GuTR7E35gF'
  };

  /* Http Requests */

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(SERVER_FCM, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /* Http Apis*/
  static String API_SEND_NOTIF = "/fcm/send";

  /* Http Params */
  static Map<String, dynamic> paramsNotify(Member sender, Member receiver) {
    var notification = Notification(title: "Followed", body: "${sender.fullname} has just been followed");
    var registrationIds = [receiver.device_token];
    var notificationModel = NotificationModel(notification: notification, registrationIds: registrationIds);
    return notificationModel.toJson();
  }
}