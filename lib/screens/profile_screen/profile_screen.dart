import 'package:airon/screens/profile_screen/edit_profile_screen.dart';
import 'package:airon/utilities/app_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom/app_bar_icon_button.dart';

class ProfileScreen extends StatefulWidget {
  final String metamaskaddress;
  const ProfileScreen({Key? key, required this.metamaskaddress})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String Uname = '';
  String Username = '';
  String bio = '';
  String photourl = '';
  bool _isloading = false;
  int _totalpost = 0;

  void initState() {
    super.initState();
    GetUsername();
  }

  void GetUsername() async {
    setState(() {
      _isloading = true;
    });
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('profile')
        .doc(widget.metamaskaddress)
        .get();
    QuerySnapshot<Map<String, dynamic>> snapshot2 = await FirebaseFirestore
        .instance
        .collection('demodatah')
        .where('metamaskid', isEqualTo: widget.metamaskaddress)
        .get();
    print('usmanafzalbajwa');
    print(snapshot2.docs.length);
    setState(() {
      _totalpost = snapshot2.docs.length;
      Uname = (snapshot.data() as Map<String, dynamic>)['name'];
      Username = (snapshot.data() as Map<String, dynamic>)['username'];
      bio = (snapshot.data() as Map<String, dynamic>)['bio'];
      photourl = (snapshot.data() as Map<String, dynamic>)['profilephotourl'];
    });
    setState(() {
      _isloading = false;
    });
    print(Uname);
    print(snapshot.data());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _AppBar(metamaskaddress: widget.metamaskaddress),
                const SizedBox(height: 16),
                _isloading
                    ? Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.8,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(photourl),
                                    fit: BoxFit.fill)),
                          ),
                        ],
                      ),
                const SizedBox(height: 16),
                Text(
                  Uname.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '@ ' + Username,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        widget.metamaskaddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      splashRadius: 16,
                      onPressed: () {},
                      icon: const Icon(Icons.copy),
                    ),
                  ],
                ),
                Text(
                  bio,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                        child:
                            _InfoTile(title: 'Collection', count: _totalpost)),
                    SizedBox(width: 16),
                    Flexible(child: _InfoTile(title: 'Visits', count: 1)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.title, required this.count, Key? key})
      : super(key: key);
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _smallText(title.toUpperCase()),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }

  Text _smallText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 16,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _ProfileImages extends StatelessWidget {
  const _ProfileImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Image.network(
                AppImages.demoURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          child: CircleAvatar(
            radius: 54,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(AppImages.demoURL),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  final String metamaskaddress;
  const _AppBar({Key? key, required this.metamaskaddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        AppBarIconButton(
          icon: Icons.edit_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfileScreen(metamaskaddress: metamaskaddress),
              ),
            );
          },
        ),
        AppBarIconButton(
          icon: Icons.settings_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
