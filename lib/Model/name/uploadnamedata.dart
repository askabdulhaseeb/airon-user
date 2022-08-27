import 'dart:typed_data';

import 'package:airon/Model/name/name.dart';
import 'package:airon/Model/storgaemethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NameMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Names> allNames = <Names>[];

  Future<List<Names>> getallNames() async {
    // final globalHelper = Provider.of<GlobalHelper>(context, listen: false);

    String? metamaskid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('profile').doc(metamaskid).get();
    Names asd = Names.fromDocument(snapshot);

    return allNames;
  }

  Future<String> UploadName({
    required String metamaskid,
    required String uid,
    required Uint8List profilephotourl,
    required String name,
    required String username,
    required String bio,
  }) async {
    String res = 'Some Error Occured';
    print('ab yahan tk');
    try {
      if (metamaskid.isNotEmpty ||
          uid.isNotEmpty ||
          name.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          profilephotourl != null) {
        print('ya be ok ha');
        //print(_auth.currentUser!.uid);
        String profileimage =
            await Storagemethod().uploadtostorage(profilephotourl);

        Names user = Names(
          uid: uid,
          metamaskid: metamaskid,
          bio: bio,
          name: name,
          profilephotourl: profileimage,
          username: username,
        );
        await _firestore.collection('profile').doc(metamaskid).set(
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
