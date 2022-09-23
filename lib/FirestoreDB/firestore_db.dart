import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';


final FirebaseFirestore firestore = FirebaseFirestore.instance;
final DocumentReference chatDocument = firestore.collection('live_class').doc('chat');
final DocumentReference attendanceDocument = firestore.collection('live_class').doc('attendance');

class FirestoreDB {


  static Stream<QuerySnapshot> getChat(String collectionId) {
    DateTime t = (DateTime.now()).subtract(const Duration(hours: 2));
    return chatDocument
        .collection(collectionId)
        .where('createdAt', isGreaterThan: t)
        .orderBy('createdAt', descending: true)
        .limit(25)
        .snapshots();
  }

  static Future<void> sendMessage(String videoId, String name, String phone, String message) async {
    DateTime _myTime;
    DateTime googleTime;
    _myTime = DateTime.now();
    final int offset =
    await NTP.getNtpOffset(localTime: _myTime, lookUpAddress: 'time.google.com');
    googleTime = _myTime.add(Duration(milliseconds: offset));

    DocumentReference documentReference = chatDocument.collection(videoId).doc();
    Map<String, dynamic> data = {
      'user': name,
      'phone': phone,
      'message': message,
      // 'createdAt': Timestamp.now()
      'createdAt': googleTime
    };
    await documentReference.set(data)
        .whenComplete(() => AppConstants.printLog("DONE"))
        .catchError((e) => AppConstants.printLog(e));
  }

  static Future<void> markAttendance(String videoId, String name, String phone) async {
    DocumentReference documentReference = attendanceDocument.collection(videoId).doc(phone);
    Map<String, dynamic> data = {
      'user': name,
      'phone': phone,
      'createdAt': Timestamp.now()
    };

    var doc = await documentReference.get();

    if(doc.exists) {
      await documentReference.update(data)
          .whenComplete(() => AppConstants.printLog("DONE"))
          .catchError((e) => AppConstants.printLog(e));

    } else {
      await documentReference.set(data)
          .whenComplete(() => AppConstants.printLog("DONE"))
          .catchError((e) => AppConstants.printLog(e));
    }
  }

}