import 'package:flutter/cupertino.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class AppImages {
  static String get logo2x => 'assets/logo@2.png';
  static String get logo3x => 'assets/logo@3.png';
  static String get logo4x => 'assets/logo@4.png';

  static String get demoURL =>
      'https://cdn.pixabay.com/photo/2022/02/18/16/09/ape-7020995_1280.png';
  static String get demoText => '''
A paragraph is a group of sentences that fleshes out a single idea. In order for a paragraph to be effective, it must begin with a topic sentence, have sentences that support the main idea of that paragraph, and maintain a consistent flow.''';
}

class GlobalHelper with ChangeNotifier {
  SessionStatus? sessions;
  // SessionStatus get sessions => _session!;
  getMetamaskAccount(var account) {
    sessions = account;
    print(sessions!.accounts[0]);
    notifyListeners();
  }
}

SessionStatus? session;
