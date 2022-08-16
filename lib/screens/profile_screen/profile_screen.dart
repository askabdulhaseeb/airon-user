import 'package:airon/screens/profile_screen/edit_profile_screen.dart';
import 'package:airon/utilities/app_images.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom/app_bar_icon_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _AppBar(),
              const SizedBox(height: 16),
              const _ProfileImages(),
              const SizedBox(height: 16),
              const Text(
                '@username',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const Text(
                      'address',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    splashRadius: 16,
                    onPressed: () {},
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
              const Text(
                'Bio',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: const <Widget>[
                  Flexible(child: _InfoTile(title: 'Collection', count: 234)),
                  SizedBox(width: 16),
                  Flexible(child: _InfoTile(title: 'Visits', count: 234)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.title, required this.count, Key? key})
      : super(key: key);
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _smallText(title.toUpperCase()),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }

  Text _smallText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 16,
        letterSpacing: 1.5,
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

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        AppBarIconButton(
          icon: Icons.edit_outlined,
          onTap: () {
            //Navigator.of(context).pushNamed(EditProfileScreen.routeName);
          },
        ),
        AppBarIconButton(
          icon: Icons.settings_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
