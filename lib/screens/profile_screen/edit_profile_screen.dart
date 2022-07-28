import 'package:airon/widgets/custom/custom_elevated_button.dart';
import 'package:airon/widgets/custom/custom_textformfield.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit-profile-screen';
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _bio = TextEditingController();
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
              const _ProfileImages(),
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
              _smallText('Email'),
              CustomTextFormField(
                controller: _email,
                hint: 'Email',
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
                onTap: () {},
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
