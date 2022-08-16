import 'package:airon/Model/uploadnft.dart';
import 'package:airon/Model/user.dart';
import 'package:flutter/material.dart';

class Userprovider with ChangeNotifier {
  List<USers> _nfts = <USers>[];
  List<USers> get nfts => _nfts;
  final AuthMethods _authMethods = AuthMethods();
  Future getAllNfts() async {
    _nfts = await _authMethods.getAllNFTs();
    notifyListeners();
  }
}
