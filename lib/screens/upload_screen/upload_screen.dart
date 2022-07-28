import 'dart:io';

import 'package:airon/function/image_functions.dart';
import 'package:airon/widgets/custom/custom_dropdown.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:airon/widgets/custom/custom_textformfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);
  static const String routeName = '/upload-screen';

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  File? file;
  @override
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
                  aspectRatio: 16 / 9,
                  child: InkWell(
                    onTap: () async {
                      final File? temp =
                          await ImageFunctions().imageFromGalary();
                      if (temp == null) return;
                      setState(() {
                        file = temp;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: DottedBorder(
                      padding: const EdgeInsets.all(6),
                      strokeWidth: 1,
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      dashPattern: const <double>[6, 6, 6, 6],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: file == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.add),
                                  SizedBox(height: 10),
                                  Text('Tap here to select photo'),
                                ],
                              )
                            : Image.file(file!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _smallText('Collection'),
                const SizedBox(height: 16),
                const CustomDropdown(),
                const SizedBox(height: 16),
                _smallText('Title'),
                CustomTextFormField(
                  controller: _title,
                  maxLines: 4,
                  hint: 'Write something here...',
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  title: 'Link Item',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
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
