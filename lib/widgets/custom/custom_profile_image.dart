import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    required this.imageURL,
    this.radius = 40,
    Key? key,
  }) : super(key: key);
  final String imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? CircleAvatar(
            radius: radius,
            child: const FittedBox(
                child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'No\nImage',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )),
          )
        : ExtendedImage.network(
            imageURL,
            width: radius,
            height: radius,
            fit: BoxFit.cover,
            cache: true,
            timeLimit: const Duration(days: 1),
          );
  }
}
