import 'package:cloud_firestore/cloud_firestore.dart';

class Names {
  final String metamaskid;
  final String uid;
  final String profilephotourl;
  final String name;
  final String username;
  final String bio;
  const Names({
    required this.metamaskid,
    required this.uid,
    required this.profilephotourl,
    required this.name,
    required this.username,
    required this.bio,
  });
  Map<String, dynamic> toJson() => {
        'metamaskid': metamaskid,
        'uid': uid,
        'profilephotourl': profilephotourl,
        'name': name,
        'username': username,
        'bio': bio,
      };

  factory Names.fromDocument(doc) {
    return Names(
      profilephotourl: doc.data()['profilephotourl'],
      name: doc.data()['name'],
      username: doc.data()['username'],
      bio: doc.data()['bio'],
      uid: doc.data()['uid'],
      metamaskid: doc.data()['metamaskid'],
    );
  }
}
