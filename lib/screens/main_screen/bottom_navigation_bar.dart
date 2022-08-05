import 'package:airon/providers/app_provider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appPro, _) {
        return DotNavigationBar(
          currentIndex: appPro.currentTap,
          onTap: (int value) => appPro.onTabTapped(value),
          paddingR: const EdgeInsets.all(0),
          dotIndicatorColor: Colors.transparent,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 6,
              spreadRadius: 1,
            ), //BoxShadow
            BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          items: [
            DotNavigationBarItem(
              icon: Icon(
                appPro.currentTap == 0 ? Icons.home : Icons.home_outlined,
              ),
              unselectedColor: Colors.grey,
              selectedColor: Theme.of(context).textTheme.bodyText1!.color,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.add_circle_outlined, size: 54),
              selectedColor: Theme.of(context).textTheme.bodyText1!.color,
              unselectedColor: Theme.of(context).textTheme.bodyText1!.color,
            ),
            DotNavigationBarItem(
              icon: Icon(
                appPro.currentTap == 2 ? Icons.person : Icons.person_outline,
              ),
              unselectedColor: Colors.grey,
              selectedColor: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ],
        );
      },
    );
  }
}
