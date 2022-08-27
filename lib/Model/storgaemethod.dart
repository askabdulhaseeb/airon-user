import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Storagemethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uuid = Uuid();
  Future<String> uploadtostorage(Uint8List file) async {
    Reference ref = _storage.ref().child('demo').child(uuid.v4());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}
