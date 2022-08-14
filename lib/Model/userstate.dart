import 'package:airon/Model/uploadnft.dart';
import 'package:airon/Model/user.dart';
import 'package:airon/models/ntf.dart';
import 'package:flutter/material.dart';

class Userprovider with ChangeNotifier {
  USers? _user;
  List<NFT> _nfts = <NFT>[];
  List<NFT> get nfts => _nfts;
  final AuthMethods _authMethods = AuthMethods();
  USers get getUser => _user!;
  Future<void> refreshuser() async {
    USers user = await _authMethods.getNFTdetail();
    _user = user;
    notifyListeners();
  }

  Future getAllNfts() async {
    _nfts = await _authMethods.getAllNFTs();
    notifyListeners();
  }
}
