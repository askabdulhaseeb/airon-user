import 'package:flutter/material.dart';

class uploadScreennext extends StatefulWidget {
  const uploadScreennext({Key? key}) : super(key: key);
  static const String routeName = '/upload-screen';
  @override
  State<uploadScreennext> createState() => _uploadScreennextState();
}

class _uploadScreennextState extends State<uploadScreennext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Mint NFT'))
            ],
          ),
        ));
  }
}
