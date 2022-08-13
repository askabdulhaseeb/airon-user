import 'package:airon/Model/uploadnft.dart';
import 'package:airon/Model/user.dart';
import 'package:flutter/material.dart';

class Userprovider with ChangeNotifier {
  USers? _user;
  final AuthMethods _authMethods = AuthMethods();

  USers get getUser => _user!;
  Future<void> refreshuser() async {
    USers user = await _authMethods.getNFTdetail();
    _user = user;
    notifyListeners();
  }
}
