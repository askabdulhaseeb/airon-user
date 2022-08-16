import 'package:airon/providers/app_provider.dart';
import 'package:airon/screens/main_screen/bottom_navigation_bar.dart';
import 'package:airon/screens/nft_screens/collection_page.dart';
import 'package:airon/screens/profile_screen/profile_screen.dart';
import 'package:airon/screens/upload_screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

<<<<<<< Updated upstream
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
=======
class MainScreen extends StatefulWidget {
  final String metamaskaddress;
  const MainScreen({Key? key, required this.metamaskaddress}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    await Provider.of<Userprovider>(context, listen: false).getAllNfts();
  }
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[
      CollectionPage(),
      UploadScreen(),
      ProfileScreen(),
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
