import 'package:cloud_firestore/cloud_firestore.dart';

class USers {
  final String metamaskid;
  final String uid;
  final String photourl;
  final String title;

  const USers({
    required this.metamaskid,
    required this.uid,
    required this.title,
    required this.photourl,
  });
  Map<String, dynamic> toJson() => {
        'metamaskid': metamaskid,
        'uid': uid,
        'title': title,
        'profilePicture': photourl,
      };
  static USers fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return USers(
      metamaskid: snapshot['metamaskid'],
      uid: snapshot['uid'],
      title: snapshot['title'],
      photourl: snapshot['profilePicture'],
    );
  }
}
