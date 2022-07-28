import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_user.dart';
import '../models/ntf.dart';
import '../providers/user_provider.dart';
import 'custom/custom_profile_image.dart';

class NftTile extends StatelessWidget {
  const NftTile({required this.nft, Key? key}) : super(key: key);
  final NFT nft;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 12,
              blurRadius: 12,
              offset: Offset(-10, 10), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<UserProvider>(builder: (context, userPro, _) {
                final AppUser user = userPro.user(uid: nft.uid);
                return Row(
                  children: <Widget>[
                    CustomProfileImage(imageURL: user.imageURL, radius: 20),
                    const SizedBox(width: 10),
                    Text('@${user.username}'),
                  ],
                );
              }),
            ),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ExtendedImage.network(
                nft.imageURL,
                fit: BoxFit.cover,
                cache: true,
                timeLimit: const Duration(days: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                nft.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
