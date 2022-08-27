import 'package:airon/Map/maplocation.dart';
import 'package:airon/Model/user.dart';
import 'package:airon/Model/userstate.dart';
import 'package:airon/models/ntf.dart';
import 'package:airon/screens/nft_screens/ntf_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:airon/utilities/app_images.dart';
import 'package:provider/provider.dart';

import '../../providers/eth.dart';

class CollectionPage extends StatefulWidget {
  final String metamaskaddress;
  const CollectionPage({Key? key, required this.metamaskaddress})
      : super(key: key);
  static const String routeName = '/collection-page';

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  bool _isloading = false;

  void initState() {
    super.initState();
    getEtherum();
    addData();
  }

  void getEtherum() async {
    setState(() {
      _isloading = true;
    });
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('ethamount')
        .doc(widget.metamaskaddress)
        .get();
    setState(() {
      ethamount = (snapshot.data() as Map<String, dynamic>)['amount'];
      _isloading = false;
    });
    print(ethamount);
  }

  addData() async {
    await Provider.of<Userprovider>(context, listen: false).getAllNfts();
  }

  Widget build(BuildContext context) {
    var user = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 100,
          child: Image.asset(AppImages.logo2x),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: IconButton(
              onPressed: () {
                //Navigator.of(context).pushNamed(MyMap.routeName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyMap(metamaskaddress: widget.metamaskaddress),
                    )).then((value) => getEtherum());
              },
              icon: Icon(
                Icons.location_on,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Total Balance'.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Center(
              child: _isloading
                  ? Text(
                      'Loading',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  : Text(
                      ethamount.toString().substring(0, 7) + '  ETC',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
            const SizedBox(height: 32),
            Text(
              'Airon Collection'.toUpperCase(),
              style: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            // Container(
            //   height: 200,
            //   width: double.infinity,
            //   child: Column(
            //     children: [
            //       Text(user.getUser.metamaskid),
            //       Text(user.getUser.title),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: user.nfts.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NftDetailScreen(
                                  nft: USers(
                                      metamaskid: user.nfts[index].metamaskid,
                                      photourl: user.nfts[index].photourl,
                                      title: user.nfts[index].title,
                                      description: user.nfts[index].description,
                                      ethValue: user.nfts[index].ethValue,
                                      uid: user.nfts[index].uid,
                                      datePublished:
                                          user.nfts[index].datePublished)),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(-2, -2),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                ), //BoxShadow
                                BoxShadow(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Column(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: ExtendedImage.network(
                                      user.nfts[index].photourl,
                                      fit: BoxFit.cover,
                                      cache: true,
                                      timeLimit: const Duration(days: 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          user.nfts[index].title.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Price : ' +
                                              user.nfts[index].ethValue,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
