import 'package:airon/Model/userstate.dart';
import 'package:airon/models/ntf.dart';
import 'package:airon/providers/app_provider.dart';
import 'package:airon/providers/user_provider.dart';
import 'package:airon/screens/main_screen/main_screen.dart';
import 'package:airon/screens/matamask_screen/matamask_screen.dart';
import 'package:airon/screens/nft_screens/mints_screen.dart';
import 'package:airon/screens/nft_screens/ntf_detail_screen.dart';
import 'package:airon/screens/profile_screen/edit_profile_screen.dart';
import 'package:airon/screens/upload_screen/upload_screen.dart';
import 'package:airon/screens/upload_screen/uploadscreennext.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/nft_screens/collection_page.dart';
import 'utilities/app_images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProviderw()),
        ChangeNotifierProvider.value(value: GlobalHelper()),
        ChangeNotifierProvider(
          create: (_) => Userprovider(),
        ),
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
        //home: MainScreen(metamaskaddress: ''),
        home: const MatamaskScreen(),
        // const MatamaskScreen(),
        routes: {
          MatamaskScreen.routeName: (_) => const MatamaskScreen(),
          UploadScreen.routeName: (_) =>
              const UploadScreen(metamaskaddress: ''),
          MintsScreen.routeName: (_) => const MintsScreen(),
          uploadScreennext.routeName: (_) => const uploadScreennext(),
          CollectionPage.routeName: (_) => const CollectionPage(),
          EditProfileScreen.routeName: (_) => const EditProfileScreen(),
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
