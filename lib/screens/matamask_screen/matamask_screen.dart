import 'package:airon/utilities/app_images.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class MatamaskScreen extends StatelessWidget {
  const MatamaskScreen({Key? key}) : super(key: key);
  static const String routeName = '/MatamaskScreen';

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
                    onTap: () {},
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
