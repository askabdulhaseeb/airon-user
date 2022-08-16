<<<<<<< Updated upstream
=======
import 'package:airon/Map/maplocation.dart';
import 'package:airon/Model/user.dart';
import 'package:airon/Model/userstate.dart';
>>>>>>> Stashed changes
import 'package:airon/models/ntf.dart';
import 'package:airon/screens/nft_screens/ntf_detail_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:airon/utilities/app_images.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);
  static const String routeName = '/collection-page';

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).pushNamed(MyMap.routeName);
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
            // Center(
            //   child: Text(
            //     'Total Balance'.toUpperCase(),
            //     style: const TextStyle(
            //       letterSpacing: 1,
            //       fontWeight: FontWeight.w300,
            //     ),
            //   ),
            // ),
            // const Center(
            //   child: Text(
            //     '0.80 ETH',
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
<<<<<<< Updated upstream
            Expanded(
              child: ListView.separated(
                itemCount: 100,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NftDetailScreen(
                                nft: NFT(
                                    id: 'id',
                                    collection: 'collection',
                                    title: 'title',
                                    description: AppImages.demoText,
                                    imageURL: AppImages.demoURL,
                                    ethValue: 0.9,
                                    visits: ['visits', 'sd', 'ssd'],
                                    uid: '-')),
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
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                                  AppImages.demoURL,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
=======

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
                                      uid: user.nfts[index].uid)),
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
>>>>>>> Stashed changes
            ),
          ],
        ),
      ),
    );
  }
}
