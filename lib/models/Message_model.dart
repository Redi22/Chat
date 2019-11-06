
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String detail;
  final bool unread;
  final String userId;
  final DateTime time;
  final String senderId;

  Message({this.time,this.unread, this.senderId, this.detail, this.userId});

  Message.fromMap(Map<String, dynamic> data)
      : time = (data["time"] as Timestamp)?.toDate(),
        unread = data["unread"],
        senderId = data["senderId"],
        detail = data["detail"],
        userId = data["userId"];

  toMap() => <String, dynamic>{
        "unread": true,
        "detail": detail,
        "time": Timestamp.now(),
        "id": senderId,
        "userId": userId,
      };
}
