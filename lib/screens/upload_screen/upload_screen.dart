import 'dart:io';
import 'dart:typed_data';

import 'package:airon/Model/eth/ethdata.dart';
import 'package:airon/Model/uploadnft.dart';
import 'package:airon/function/image_functions.dart';
import 'package:airon/screens/upload_screen/uploadscreennext.dart';
import 'package:airon/widgets/custom/custom_dropdown.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:airon/widgets/custom/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

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
  final TextEditingController _description = TextEditingController();
  final TextEditingController _ethvalue = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var uuid = const Uuid();
  late final String Metamaskwallet;
  void initState() {
    Metamaskwallet = widget.metamaskaddress;
    GetEtherum();
  }

  File? file;
  Uint8List? _image;
  bool _isloading = false;
  double Ethamount = 0;
  @override
  void dispose() {
    super.dispose();
    _title.dispose();
  }

  void GetEtherum() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('ethamount')
        .doc(widget.metamaskaddress)
        .get();
    setState(() {
      Ethamount = (snapshot.data() as Map<String, dynamic>)['amount'];
    });
  }

  void Uploadnft() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().UploadNFT(
      file: _image!,
      metamaskid: Metamaskwallet,
      title: _title.text,
      description: _description.text,
      ethValue: _ethvalue.text,
      uid: uuid.v4(),
      datePublished: Timestamp.fromDate(DateTime.now()),
    );
    print('yahan tk chala ha');
    print(_title.text);
    setState(() {
      _isloading = false;
    });
    showSnackBar(context, res);

    if (res == "Upload NFT") {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const uploadScreennext(),
      //   ),
      // );
      Ethdata().UploadEth(metamaskid: Metamaskwallet, amount: Ethamount);
    }
    ;
  }

  void selectimage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  bool nfcLocated = true;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Item',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          centerTitle: false,
        ),
        body: nfcLocated == false
            ? Center(
                child: GestureDetector(
                  // onTap: () async =>
                  //     FlutterNfcReader.onTagDiscovered().listen((onData) {
                  //   setState(() {
                  //     nfcLocated = !nfcLocated;
                  //   });
                  //   print(onData.id);
                  //   print(onData.content);
                  // }),
                  onTap: () async {
                    var availability = await FlutterNfcKit.nfcAvailability;
                    print(availability);
                    if (availability == NFCAvailability.available) {
                      print('here');
                      // handleTag;
                      var tag = await FlutterNfcKit.poll(
                          timeout: Duration(seconds: 10));
                      print(tag);
                      setState(() {
                        if (tag != null) {
                          nfcLocated = true;
                        }
                      });
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      color: Colors.orange,
                      child: const Text(
                        'connect nfc',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              )
            : SingleChildScrollView(
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!,
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
                                                Text(
                                                    'Tap here to select photo'),
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
                        _smallText('Title'),
                        CustomTextFormField(
                          controller: _title,
                          maxLines: 4,
                          hint: 'Write something here...',
                        ),
                        const SizedBox(height: 16),
                        _smallText('Description'),
                        CustomTextFormField(
                          controller: _description,
                          maxLines: 4,
                          hint: 'Write something here...',
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _ethvalue,
                          decoration: const InputDecoration(
                            hintText: 'Price',
                          ),
                        ),
                        const SizedBox(height: 20),
                        _isloading
                            ? const CircularProgressIndicator()
                            : CustomElevatedButton(
                                title: 'Upload NFT',
                                onTap: Uploadnft,
                              ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  NfcTag? tag;

  Map<String, dynamic>? additionalData;
  Future<String?> handleTag(NfcTag tag) async {
    this.tag = tag;
    additionalData = {};

    Object? tech;

    // todo: more additional data
    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData!['manufacturerParameter'] =
            polling.manufacturerParameter;
      }
    }
    print('connected');
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
