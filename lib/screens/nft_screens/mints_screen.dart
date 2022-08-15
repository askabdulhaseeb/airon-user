import 'package:airon/models/ntf.dart';
import 'package:airon/utilities/app_images.dart';
import 'package:flutter/material.dart';

import '../../widgets/ntf_tile.dart';

class MintsScreen extends StatelessWidget {
  const MintsScreen({Key? key}) : super(key: key);
  static const String routeName = '/mints-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 100,
          child: Image.asset(AppImages.logo2x),
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              'Your NFT is being minted...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            const Text(
              'Ore you MIT is minted on the Ethereum blockchain, you will not be abile to edit',
              style: TextStyle(color: Colors.grey),
            ),
            NftTile(
              nft: NFT(
                collection: 'collection',
                title: 'title',
                imageURL: AppImages.demoURL,
                description: 'description',
                ethValue: 0.8,
                visits: ['visits', 'ds', 'sd'],
                uid: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({required this.onTap, Key? key}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          alignment: Alignment.center,
          child: Center(
            child: Column(
              children: <Widget>[
                Row(children: const <Widget>[
                  _icon(),
                  SizedBox(width: 4),
                  _icon()
                ]),
                const SizedBox(height: 4),
                Row(children: const <Widget>[
                  _icon(),
                  SizedBox(width: 4),
                  _icon()
                ]),
              ],
            ),
          )),
    );
  }
}

class _icon extends StatelessWidget {
  const _icon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: 6,
      color: Theme.of(context).textTheme.bodyText1!.color,
    );
  }
}
