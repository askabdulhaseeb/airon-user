import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class USers {
  final String metamaskid;
  final String uid;
  final String photourl;
  final String title;

  const USers({
    required this.metamaskid,
    required this.uid,
    required this.photourl,
    required this.title,
  });
  Map<String, dynamic> toJson() => {
        'metamaskid': metamaskid,
        'uid': uid,
        'title': title,
        'profilePicture': photourl,
      };
  static USers fromsnap(snapshot) {
    // var snapshot = snap.data();
    // as Map<String, dynamic>;

    return USers(
      metamaskid: snapshot['metamaskid'],
      uid: snapshot['uid'],
      title: snapshot['title'],
      photourl: snapshot['profilePicture'],
    );
  }

  USers copyWith({
    String? metamaskid,
    String? uid,
    String? photourl,
    String? title,
  }) {
    return USers(
      metamaskid: metamaskid ?? this.metamaskid,
      uid: uid ?? this.uid,
      photourl: photourl ?? this.photourl,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metamaskid': metamaskid,
      'uid': uid,
      'photourl': photourl,
      'title': title,
    };
  }

  factory USers.fromMap(Map<String, dynamic> map) {
    return USers(
      metamaskid: map['metamaskid'] ?? '',
      uid: map['uid'] ?? '',
      photourl: map['photourl'] ?? '',
      title: map['title'] ?? '',
    );
  }
  factory USers.fromDocument(doc) {
    final data = doc.data();
    print(data);

    return USers(
      metamaskid: doc.data()['metamaskid'],
      uid: doc.data()['uid'] ?? '',
      photourl: doc.data()['photourl'] ?? '',
      title: doc.data()['title'] ?? '',
    );
  }
  // String toJson() => json.encode(toMap());

  factory USers.fromJson(String source) => USers.fromMap(json.decode(source));

  @override
  String toString() {
    return 'USers(metamaskid: $metamaskid, uid: $uid, photourl: $photourl, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is USers &&
        other.metamaskid == metamaskid &&
        other.uid == uid &&
        other.photourl == photourl &&
        other.title == title;
  }
}
