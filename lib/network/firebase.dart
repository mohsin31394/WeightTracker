import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

signInWithEmailAndPassword(
    {required String email, required String password}) async {
  try {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}



final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class Database {

  static Future<void> addData({
    required String weight,
  }) async {

    Map<String, dynamic> data = <String, dynamic>{
      "time":DateTime.now().millisecondsSinceEpoch,
      "weight": weight,
    };

    await _firestore.collection('userInfo').doc()
        .set(data)
        .whenComplete(() => print("user info added to the database"))
        .catchError((e) => print(e));
  }

  static Future readData() async {
    var notesItemCollection =await
    _firestore.collection('userInfo').get();
    print(notesItemCollection.docs[0].data().values);
    print(notesItemCollection.docs[0].data().values);
    notesItemCollection.docs[0].data();
  }
  static Future update({oldWeight='51',newWeight='30'})async{



    await _firestore.collection('userInfo').get().then((value){
      value.docs.forEach((element) {
        if(element['weight'].toString()==oldWeight){
        print(element.id);

        Map<String, dynamic> data = <String, dynamic>{
          "time":element['time'],
          "weight": newWeight,
        };


        _firestore.collection('userInfo').doc(element.id).update(data);
        }
      });
    });

  }

  static Future delete({weight='30'})async{



    await _firestore.collection('userInfo').get().then((value){
      value.docs.forEach((element) {
        if(element['weight'].toString()==weight){
          print(element.id);



          _firestore.collection('userInfo').doc(element.id).delete();
        }
      });
    });

  }
  // static Future<void> updateItem({
  //   required String title,
  //   required String description,
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //   _mainCollection.doc(userUid).collection('items').doc(docId);
  //
  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //     "description": description,
  //   };
  //
  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() => print("Note item updated in the database"))
  //       .catchError((e) => print(e));
  // }
  // static Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //   _mainCollection.doc(userUid).collection('items').doc(docId);
  //
  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }



}
