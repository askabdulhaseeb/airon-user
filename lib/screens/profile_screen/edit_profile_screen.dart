import 'dart:typed_data';
import 'package:airon/Model/name/uploadnamedata.dart';
import 'package:airon/function/image_functions.dart';
import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:airon/widgets/custom/custom_textformfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/app_images.dart';
import 'package:uuid/uuid.dart';

class EditProfileScreen extends StatefulWidget {
  final String metamaskaddress;
  const EditProfileScreen({Key? key, required this.metamaskaddress})
      : super(key: key);
  static const String routeName = '/edit-profile-screen';
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  var uuid = Uuid();
  late final String Metamaskwallet;
  void initState() {
    Metamaskwallet = widget.metamaskaddress;
  }

  Uint8List? _image;
  bool _isloading = false;
  void UploadName() async {
    setState(() {
      _isloading = true;
    });
    String res = await NameMethods().UploadName(
      metamaskid: Metamaskwallet,
      name: _name.text,
      username: _username.text,
      profilephotourl: _image!,
      uid: uuid.v4(),
      bio: _bio.text,
    );
    print('yahan tk chala ha');
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
  }

  void selectimage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color!,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'Edit Your',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: _image == null
                    ? InkWell(
                        onTap: selectimage,
                        borderRadius: BorderRadius.circular(12),
                        child: DottedBorder(
                          padding: const EdgeInsets.all(6),
                          strokeWidth: 1,
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                          dashPattern: const <double>[6, 6, 6, 6],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          child: Center(child: Text('Edit Profile Photo')),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            image:
                                DecorationImage(image: MemoryImage(_image!)))),
              ),
              const SizedBox(height: 24),
              _smallText('Name'),
              CustomTextFormField(
                controller: _name,
                hint: 'Name',
                readOnly: isLoading,
                validator: (String? value) =>
                    value!.length < 3 ? 'Name lenght is short' : null,
              ),
              _smallText('Username'),
              CustomTextFormField(
                controller: _username,
                hint: 'Username',
                readOnly: isLoading,
                validator: (String? value) =>
                    value!.length < 3 ? 'Name lenght is short' : null,
              ),
              _smallText('Bio'),
              CustomTextFormField(
                controller: _bio,
                hint: 'Bio',
                maxLines: 4,
                readOnly: isLoading,
                validator: (String? value) => null,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                title: 'Save',
                onTap: UploadName,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _smallText(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w200,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _ProfileImages extends StatelessWidget {
  const _ProfileImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Image.network(
                AppImages.demoURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          child: CircleAvatar(
            radius: 54,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(AppImages.demoURL),
            ),
          ),
        ),
      ],
    );
  }
}
