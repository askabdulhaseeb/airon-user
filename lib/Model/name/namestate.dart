import 'package:airon/Model/name/name.dart';
import 'package:airon/Model/name/uploadnamedata.dart';
import 'package:airon/Model/user.dart';
import 'package:flutter/material.dart';

class Nameprovider with ChangeNotifier {
  List<Names> _showdata = <Names>[];
  List<Names> get showdata => _showdata;
  final NameMethods _authMethods = NameMethods();
  Future getNames() async {
    _showdata = await _authMethods.getallNames();
    notifyListeners();
  }
}
