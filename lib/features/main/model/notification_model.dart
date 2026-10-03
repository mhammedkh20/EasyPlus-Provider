import 'package:easy_plus_service_provider/features/auth/model/user.dart';

class NotificationModel {
  int? notifyId;
  String? title;
  String? body;
  String? url;
  User? user;

  String? createdAt;

  NotificationModel({
    this.notifyId,
    this.user,
    this.title,
    this.body,
    this.url,
    this.createdAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notifyId = json['notify_id'];
    title = json['title'];
    body = json['body'];
    url = json['url'];
    createdAt = json['created_at'];
    user = json['driver'] != null ? User.fromJson(json['driver']) : null;
  }
}
