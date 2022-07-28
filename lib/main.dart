import 'package:airon/models/ntf.dart';
import 'package:airon/providers/user_provider.dart';
import 'package:airon/screens/matamask_screen/matamask_screen.dart';
import 'package:airon/screens/nft_screens/mints_screen.dart';
import 'package:airon/screens/nft_screens/ntf_detail_screen.dart';
import 'package:airon/screens/upload_screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/nft_screens/collection_page.dart';
import 'utilities/app_images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        title: 'Airon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          primarySwatch: Colors.blue,
        ),
        home: const CollectionPage(),
        routes: {
          MatamaskScreen.routeName: (_) => const MatamaskScreen(),
          UploadScreen.routeName: (_) => const UploadScreen(),
          MintsScreen.routeName: (_) => const MintsScreen(),
          CollectionPage.routeName: (_) => const CollectionPage(),
          NftDetailScreen.routeName: (_) => NftDetailScreen(
                  nft: NFT(
                id: '-',
                collection: '-',
                title: '-',
                description: '-',
                imageURL: '-',
                ethValue: 0,
                visits: [''],
                uid: '-',
              )),
        },
      ),
    );
  }
}
