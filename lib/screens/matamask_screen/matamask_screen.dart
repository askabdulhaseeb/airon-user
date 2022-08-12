import 'package:airon/utilities/app_images.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class MatamaskScreen extends StatelessWidget {
  const MatamaskScreen({Key? key}) : super(key: key);
  static const String routeName = '/matamask-screen';

  Future<void> connectWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );
    // Subscribe to events
    connector.on('connect', (session) => print(session));
    connector.on('session_update', (payload) => print(payload));
    connector.on('disconnect', (session) => print(session));

    // Create a new session
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 137,
        onDisplayUri: (uri)async {
          print(uri);
         await launch(uri);
        },
      );

      print(session);
    }
    // final connector = WalletConnect(
    //   bridge: 'https://bridge.walletconnect.org',
    //   clientMeta: const PeerMeta(
    //     name: 'any name',
    //     description: 'any description',
    //     url: 'any url',
    //     icons: [
    //       'logo url'
    //     ],
    //   ),
    // );

    // // Subscribe to events
    // connector.on('connect', (session) {
    //   debugPrint("connect: " + session.toString());

    //   address = sessionStatus?.accounts[0];
    //   chainId = sessionStatus?.chainId;

    //   debugPrint("Address: " + address!);
    //   debugPrint("Chain Id: " + chainId.toString());
    // });

    // connector.on('session_request', (payload) {
    //   debugPrint("session request: " + payload.toString());
    // });

    // connector.on('disconnect', (session) {
    //   debugPrint("disconnect: " + session.toString());
    // });

    // // Create a new session
    // if (!connector.connected) {
    //   final sessionStatus = await connector.createSession(
    //     chainId: 137, //pass the chain id of a network. 137 is Polygon
    //     onDisplayUri: (uri) {
    //      launchUrl(Uri.parse(uri)); //call the launchUrl(uri) method
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Image.asset(AppImages.logo2x),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.bodyText1!.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'MetaMask',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You can login your metamask wallet or create your wallet from here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    title: 'Create Wallet',
                    bgColor: Theme.of(context).scaffoldBackgroundColor,
                    textStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    onTap: () async {
                      await connectWallet();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
