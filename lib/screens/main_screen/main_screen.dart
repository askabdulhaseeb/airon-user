import 'package:airon/Model/userstate.dart';
import 'package:airon/providers/app_provider.dart';
import 'package:airon/screens/main_screen/bottom_navigation_bar.dart';
import 'package:airon/screens/nft_screens/collection_page.dart';
import 'package:airon/screens/profile_screen/profile_screen.dart';
import 'package:airon/screens/upload_screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  bool isLoading = true;

  addData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Userprovider>(context, listen: false).refreshuser();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      const CollectionPage(),
      UploadScreen(metamaskaddress: widget.metamaskaddress),
      ProfileScreen(metamaskaddress: widget.metamaskaddress),
    ];
    return Scaffold(
      extendBody: true,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<AppProvider>(
              builder: (context, appPro, _) => _pages[appPro.currentTap],
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
