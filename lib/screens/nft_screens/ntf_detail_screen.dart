import 'package:airon/models/ntf.dart';
import 'package:airon/utilities/app_images.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NftDetailScreen extends StatelessWidget {
  const NftDetailScreen({required this.nft, Key? key}) : super(key: key);
  final NFT nft;
  static const String routeName = '/nft-detail-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Detail',
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            splashRadius: 16,
            icon: Icon(
              Icons.mode_standby_rounded,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              shadowColor: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ExtendedImage.network(
                        nft.imageURL,
                        fit: BoxFit.cover,
                        cache: true,
                        timeLimit: const Duration(days: 1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(
                          bottom: 16, left: 32, right: 32),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                3, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _smallText('Value'),
                              Text(
                                '${nft.ethValue} ETH',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _smallText('Visits'),
                              Text(
                                '${nft.visits.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              nft.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  nft.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Center(
              child: Text(
                '1 Gym check in visit = 0.011123 ETH',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _smallText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w200,
        letterSpacing: 1.5,
      ),
    );
  }
}
