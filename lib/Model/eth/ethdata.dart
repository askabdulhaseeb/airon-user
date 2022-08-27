import 'package:airon/Model/eth/ethamount.dart';
import 'package:airon/providers/eth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ethdata {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> UploadEth({
    required String metamaskid,
    required double amount,
  }) async {
    String res = 'Some Error Occured';
    print('ab yahan tk');
    try {
      if (metamaskid.isNotEmpty) {
        print('ya be ok ha');
        Etherums user = Etherums(
          metamaskid: metamaskid,
          amount: amount + 0.011123,
        );
        await _firestore.collection('ethamount').doc(metamaskid).set(
              user.toJson(),
            );
        ethamount = amount + 0.011123;
        print('idr be ok ha');
      }
      res = 'Success';
    } catch (err) {
      res = 'warr gybe';
    }
    return res;
  }

  Future<String> GymEth({
    required String metamaskid,
    required double amount,
  }) async {
    String res = 'Some Error Occured';
    print('ab yahan tk');
    try {
      if (metamaskid.isNotEmpty) {
        print('ya be ok ha');
        Etherums user = Etherums(
          metamaskid: metamaskid,
          amount: amount + 0.011123,
        );
        await _firestore.collection('ethamount').doc(metamaskid).set(
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
