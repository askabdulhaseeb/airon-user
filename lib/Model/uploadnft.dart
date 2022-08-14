import 'dart:typed_data';

import 'package:airon/Model/storgaemethod.dart';
import 'package:airon/Model/user.dart';
import 'package:airon/models/ntf.dart';
import 'package:airon/utilities/app_images.dart';
import 'package:airon/utilities/collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<USers> getNFTdetail() async {
    // final globalHelper = Provider.of<GlobalHelper>(context, listen: false);

    DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(session!.accounts[0].toString())
        .get();

    print(USers.fromDocument(snapshot));
    return USers.fromDocument(snapshot);
  }

  Future<String> uploadNFT({
    required String metamaskid,
    required String title,
    required Uint8List file,
    required String collection,
    required String description,
    required double ethValue,
    required List visits,
    required String uid,
  }) async {
    String res = 'Some Error Occured';
    print('ab yahan tk');
    try {
      if (title.isNotEmpty) {
        print('ya be ok ha');
        //print(_auth.currentUser!.uid);
        String profileimage = await Storagemethod().uploadtostorage(file);

        NFT nft = NFT(
            collection: collection,
            description: description,
            ethValue: ethValue,
            // id: uid,
            imageURL: profileimage,
            uid: uid,
            title: title,
            visits: []);
        nftRef.doc(metamaskid).set(
              nft.toJson(),
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
