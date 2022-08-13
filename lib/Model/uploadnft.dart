import 'dart:typed_data';

import 'package:airon/Model/storgaemethod.dart';
import 'package:airon/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<USers> getNFTdetail() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc().get();
    print(USers.fromsnap(snapshot));
    return USers.fromsnap(snapshot);
  }

  Future<String> UploadNFT({
    required String metamaskid,
    required String title,
    required Uint8List file,
  }) async {
    String res = 'Some Error Occured';
    print('ab yahan tk');
    try {
      if (title.isNotEmpty) {
        print('ya be ok ha');
        //print(_auth.currentUser!.uid);
        String profileimage = await Storagemethod().uploadtostorage(file);

        USers user = USers(
            uid: '113',
            photourl: profileimage,
            metamaskid: metamaskid,
            title: title);
        await _firestore.collection('users').add(
              user.toJson(),
            );
        print('idr be ok ha');
      }
      res = 'Success';
    } catch (err) {
      res = 'warr gybe';
    }
    return res;
  }
}
