import 'dart:io';
import 'dart:typed_data';

import 'package:airon/Model/uploadnft.dart';
import 'package:airon/function/image_functions.dart';
import 'package:airon/screens/upload_screen/uploadscreennext.dart';
import 'package:airon/widgets/custom/custom_dropdown.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:airon/widgets/custom/custom_textformfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  final String metamaskaddress;
  const UploadScreen({Key? key, required this.metamaskaddress})
      : super(key: key);
  static const String routeName = '/upload-screen';

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late final String Metamaskwallet;
  final String mtwallet = 'usman123';

  String collection = 'collection1';

  void initState() {
    Metamaskwallet = widget.metamaskaddress;
  }

  File? file;
  Uint8List? _image;
  bool _isloading = false;
  @override
  void dispose() {
    super.dispose();
    _title.dispose();
  }

  void uploadNft() async {
    setState(() {
      _isloading = true;
    });

    String res = await AuthMethods().uploadNFT(
      file: _image!,
      metamaskid: Metamaskwallet,
      title: _title.text,
      collection: 'collection',
      description: 'description',
      ethValue: 0.9,
      visits: ['visits', 'sd', 'ssd'],
      uid: const Uuid().v4(),
    );
    print('yahan tk chala ha');
    print(mtwallet);
    print(_title.text);
    setState(() {
      _isloading = false;
    });
    showSnackBar(context, res);

    if (res == "Success") {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const uploadScreennext(),
      //   ),
      // );
    }
    ;
  }

  void selectimage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Item',
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _image == null
                      ? InkWell(
                          onTap: selectimage,
                          borderRadius: BorderRadius.circular(12),
                          child: DottedBorder(
                            padding: const EdgeInsets.all(6),
                            strokeWidth: 1,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            dashPattern: const <double>[6, 6, 6, 6],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: file == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(Icons.add),
                                        SizedBox(height: 10),
                                        Text('Tap here to select photo'),
                                      ],
                                    )
                                  : Image.file(file!),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(
                                  image: MemoryImage(_image!)))),
                ),
                const SizedBox(height: 16),
                _smallText('Collection'),
                const SizedBox(height: 16),
                collectionPicker(),
                const SizedBox(height: 16),
                _smallText('Title'),
                CustomTextFormField(
                  controller: _title,
                  maxLines: 4,
                  hint: 'Write something here...',
                ),
                const SizedBox(height: 20),
                _isloading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        title: 'Upload NFT',
                        onTap: uploadNft,
                      ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox collectionPicker({
    final controller,
  }) {
    return SizedBox(
      // width: 200,
      height: 80,
      child: CupertinoPicker(
        selectionOverlay: null,
        // squeeze: 1.5,
        onSelectedItemChanged: (int value) {
          setState(() {
            switch (value) {
              case 0:
                collection = 'collection1';
                break;
              case 1:
                collection = 'collection2';
                break;
              case 2:
                collection = 'collection3';
                break;
              case 3:
                collection = 'collection4';
                break;
            }
          });
        },
        itemExtent: 25,
        scrollController: controller,
        useMagnifier: true, diameterRatio: 1,
        magnification: 1.1,
        children: const [
          Text(
            "collection1",
          ),
          Text(
            "collection2",
          ),
          Text(
            "collection3",
          ),
          Text(
            "collection4",
          ),
        ],
      ),
    );
  }

  Text _smallText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w200,
        letterSpacing: 1.5,
      ),
    );
  }
}
