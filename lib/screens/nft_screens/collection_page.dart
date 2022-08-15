import 'package:airon/Model/userstate.dart';
import 'package:airon/models/ntf.dart';
import 'package:airon/screens/nft_screens/ntf_detail_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:airon/utilities/app_images.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);
  static const String routeName = '/collection-page';

  // getAllNfts(BuildContext context) async {
  //   var provider = Provider.of<Userprovider>(context);
  //   await provider.getAllNfts();
  // }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 100,
          child: Image.asset(AppImages.logo2x),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Center(
            //   child: Text(
            //     'Total Balance'.toUpperCase(),
            //     style: const TextStyle(
            //       letterSpacing: 1,
            //       fontWeight: FontWeight.w300,
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Text(
            //     session!.accounts[0].balance.toString(),
            //     style: TextStyle(
            //       letterSpacing: 1,
            //       fontWeight: FontWeight.w800,
            //     ),
            //   ),
            // ),
          
            const SizedBox(height: 32),
            Text(
              'Airon Collection'.toUpperCase(),
              style: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              // height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Text(user.getUser.metamaskid),
                  Text(user.getUser.title),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: user.nfts.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NftDetailScreen(
                                  nft: NFT(
                                      collection: user.nfts[index].collection,
                                      title: user.nfts[index].title,
                                      description: user.nfts[index].description,
                                      imageURL: user.nfts[index].imageURL,
                                      ethValue: user.nfts[index].ethValue,
                                      visits: user.nfts[index].visits,
                                      uid: user.nfts[index].uid)),
                            ),
                          );
                        },
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
                                    user.nfts[index].imageURL,
                                    fit: BoxFit.cover,
                                    cache: true,
                                    timeLimit: const Duration(days: 1),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      'data',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
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
