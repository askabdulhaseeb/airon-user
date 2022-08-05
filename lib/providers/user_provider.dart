import 'package:airon/models/app_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final List<AppUser> _users = <AppUser>[];

  AppUser user({required String uid}) {
    final int index = _users.indexWhere((element) => element.uid == uid);
    return index < 0 ? _null : _users[index];
  }

  AppUser get _null => AppUser(
        uid: 'null',
        username: 'null',
        email: 'null',
        imageURL: '',
        bio: 'nul',
        visits: [],
        address: 'null',
      );
}
