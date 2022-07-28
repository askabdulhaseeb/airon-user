import 'dart:convert';

class NFT {
  NFT({
    required this.id,
    required this.collection,
    required this.title,
    required this.description,
    required this.ethValue,
    required this.visits,
    required this.uid,
  });

  final String id;
  final String collection;
  final String title;
  final String description;
  final double ethValue;
  final List<String> visits;
  final String uid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'collection': collection,
      'title': title,
      'description': description,
      'eth_value': ethValue,
      'visits': visits,
      'uid': uid,
    };
  }

  factory NFT.fromMap(Map<String, dynamic> map) {
    return NFT(
      id: map['id'] ?? '',
      collection: map['collection'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ethValue: map['eth_value']?.toDouble() ?? 0.0,
      visits: List<String>.from(map['visits']),
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NFT.fromJson(String source) => NFT.fromMap(json.decode(source));
}
