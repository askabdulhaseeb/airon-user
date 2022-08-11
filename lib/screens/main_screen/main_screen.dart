import 'package:airon/providers/app_provider.dart';
import 'package:airon/screens/main_screen/bottom_navigation_bar.dart';
import 'package:airon/screens/nft_screens/collection_page.dart';
import 'package:airon/screens/profile_screen/profile_screen.dart';
import 'package:airon/screens/upload_screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final String metamaskaddress;
  const MainScreen({Key? key, required this.metamaskaddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      CollectionPage(),
      UploadScreen(),
      ProfileScreen(metamaskaddress: metamaskaddress),
    ];
    return Scaffold(
      extendBody: true,
      body: Consumer<AppProvider>(
        builder: (context, appPro, _) => _pages[appPro.currentTap],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
