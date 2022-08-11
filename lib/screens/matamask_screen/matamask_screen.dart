import 'package:airon/screens/main_screen/main_screen.dart';
import 'package:airon/utilities/app_images.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MatamaskScreen extends StatefulWidget {
  const MatamaskScreen({Key? key}) : super(key: key);
  static const String routeName = '/matamask-screen';

  @override
  State<MatamaskScreen> createState() => _MatamaskScreenState();
}

class _MatamaskScreenState extends State<MatamaskScreen> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri, _signature, session;

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    connector.on(
        'connect',
        (session) => setState(
              () {
                _session = _session;
              },
            ));
    connector.on(
        'session_update',
        (payload) => setState(() {
              _session = payload;
              print(_session.accounts[0]);
              print(_session.chainId);
            }));
    connector.on(
        'disconnect',
        (payload) => setState(() {
              _session = null;
            }));
    return Scaffold(
        appBar: AppBar(),
        body: (_session == null)
            ? Padding(
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
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            onTap: () => loginUsingMetamask(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : MainScreen(
                metamaskaddress: session.accounts[0].toString(),
              ));
  }
}
