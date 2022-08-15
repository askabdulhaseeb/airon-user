import 'dart:convert';

class NFT {
  NFT({
    // required this.id,
    required this.collection,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.ethValue,
    required this.visits,
    required this.uid,
  });

  // final String id;
  final String collection;
  final String title;
  final String description;
  final String imageURL;
  final double ethValue;
  final List visits;
  final String uid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'collection': collection,
      'title': title,
      'description': description,
      'imageURL': imageURL,
      'eth_value': ethValue,
      'visits': visits,
      'uid': uid,
    };
  }
  factory NFT.fromDocument(doc){
    return NFT(
      collection: doc.data()['collection'],
      title: doc.data()['title'],
      description: doc.data()['description'],
      imageURL: doc.data()['imageURL'],
      ethValue: doc.data()['eth_value'],
      visits: doc.data()['visits'],
      uid: doc.data()['uid'],
    );
  }
  Map<String, dynamic> toJson() => {
        'collection': collection,
      'title': title,
      'description': description,
      'imageURL': imageURL,
      'eth_value': ethValue,
      'visits': visits,
      'uid': uid,
      };
  factory NFT.fromMap(Map<String, dynamic> map) {
    return NFT(
      // id: map['id'] ?? '',
      collection: map['collection'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageURL: map['imageURL'] ?? '',
      ethValue: map['eth_value']?.toDouble() ?? 0.0,
      visits: List<String>.from(map['visits']),
      uid: map['uid'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  factory NFT.fromJson(String source) => NFT.fromMap(json.decode(source));
}
