import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final DocumentReference chatDocument = firestore.collection('live_class').doc('chat');

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
    DocumentReference documentReference = chatDocument.collection(videoId).doc();
    Map<String, dynamic> data = {
      'user': name,
      'phone': phone,
      'message': message,
      'createdAt': Timestamp.now()
    };
    await documentReference.set(data)
        .whenComplete(() => AppConstants.printLog("DONE"))
        .catchError((e) => AppConstants.printLog(e));
  }

}