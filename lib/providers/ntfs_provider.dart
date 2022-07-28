import 'package:airon/models/ntf.dart';
import 'package:flutter/material.dart';

class NTFsProvider extends ChangeNotifier {
  List<NFT> _nfts = <NFT>[];

  NFT nft({required String id}) {
    final int index = _nfts.indexWhere((element) => element.id == id);
    return index < 0 ? _null : _nfts[index];
  }

  NFT get _null => NFT(
        id: 'null',
        collection: 'null',
        title: 'null',
        description: 'null',
        ethValue: 0,
        visits: [],
        uid: 'null',
      );
}
