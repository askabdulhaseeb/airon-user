import 'dart:convert';

class AppUser {
  AppUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.imageURL,
    this.coverPhoto,
    required this.bio,
    required this.visits,
    required this.address,
  });
  final String uid;
  final String username;
  final String email;
  final String imageURL;
  String? coverPhoto;
  final String bio;
  final List<String> visits;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'imageURL': imageURL,
      'coverPhoto': coverPhoto,
      'email': email,
      'bio': bio,
      'visits': visits,
      'address': address,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      imageURL: map['imageURL'] ?? '',
      coverPhoto: map['coverPhoto'],
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      visits: List<String>.from(map['visits']),
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
