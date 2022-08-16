import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:airon/Model/storgaemethod.dart';
import 'package:airon/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<USers> allNfts = <USers>[];

  // Future<USers> getNFTdetail() async {
  //   DocumentSnapshot snapshot =
  //       await _firestore.collection('users').doc().get();
  //   print(USers.fromsnap(snapshot));
  //   return USers.fromsnap(snapshot);
  // }
  Future<List<USers>> getAllNFTs() async {
    // final globalHelper = Provider.of<GlobalHelper>(context, listen: false);

    QuerySnapshot snapshot = await _firestore.collection('demodatah').get();
    snapshot.docs.forEach((e) {
      allNfts.add(USers.fromDocument(e));
    });
    return allNfts;
  }

  Future<String> UploadNFT({
    required String metamaskid,
    required String title,
    required Uint8List file,
    required String description,
    required String ethValue,
    required String uid,
  }) async {
    String res = 'Some Error Occured';
    print('ab yahan tk');
    try {
      if (title.isNotEmpty) {
        print('ya be ok ha');
        //print(_auth.currentUser!.uid);
        String profileimage = await Storagemethod().uploadtostorage(file);

        USers user = USers(
          uid: uid,
          photourl: profileimage,
          metamaskid: metamaskid,
          title: title,
          description: description,
          ethValue: ethValue.toString(),
        );
        await _firestore.collection('demodatah').doc(uid).set(
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
