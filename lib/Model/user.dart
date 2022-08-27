import 'package:cloud_firestore/cloud_firestore.dart';

class USers {
  final String metamaskid;
  final String uid;
  final String photourl;
  final String title;
  final String description;
  final String ethValue;
  final Timestamp datePublished;
  const USers({
    required this.metamaskid,
    required this.uid,
    required this.title,
    required this.photourl,
    required this.description,
    required this.ethValue,
    required this.datePublished,
  });
  Map<String, dynamic> toJson() => {
        'metamaskid': metamaskid,
        'uid': uid,
        'title': title,
        'profilePicture': photourl,
        'description': description,
        'ethValue': ethValue,
        'datePublished': datePublished,
      };
  static USers fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return USers(
      metamaskid: snapshot['metamaskid'],
      uid: snapshot['uid'],
      title: snapshot['title'],
      photourl: snapshot['profilePicture'],
      description: snapshot['description'],
      ethValue: snapshot['ethValue'],
      datePublished: snapshot['datePublished'],
    );
  }

  factory USers.fromDocument(doc) {
    return USers(
      title: doc.data()['title'],
      description: doc.data()['description'],
      photourl: doc.data()['profilePicture'],
      ethValue: doc.data()['ethValue'],
      uid: doc.data()['uid'],
      metamaskid: doc.data()['metamaskid'],
      datePublished: doc.data()['datePublished'],
    );
  }
}
