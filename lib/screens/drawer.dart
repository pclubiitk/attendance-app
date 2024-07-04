import 'package:attendance_app/components/navbar_item.dart';
import 'package:attendance_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

/// The widget for side navigation bar, lists down NavBarItem widget for each navigation item
class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // color: theme.drawerTheme.backgroundColor,
      color: const Color(0xFFD7CCC8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(IconData(0xe16a, fontFamily: 'MaterialIcons')),
                onPressed: () {
                  Navigator.pop(context);
                },
          ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration:  BoxDecoration(
              color: const Color.fromARGB(255, 253, 255, 255),
              shape: BoxShape.circle,
              border: Border.all(
        width: 1,
        color: const Color.fromARGB(255, 155, 154, 154),
        style: BorderStyle.solid,
      ),

            ),
            child: Image.asset(
              "assets/Police car-rafiki.png",
              // height: 250,
              // width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          NavbarItem(
            icon: LineAwesomeIcons.user,
            text: 'Profile',
            onTap: () {},
            textStyle: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
            iconColor: theme.iconTheme.color,
          ),
          NavbarItem(
            icon: LineAwesomeIcons.history_solid,
            text: 'Attendance History',
            onTap: () {},
            textStyle: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
            iconColor: theme.iconTheme.color,
          ),
          // Divider(color: theme.dividerColor),
          NavbarItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {},
            textStyle: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
            iconColor: theme.iconTheme.color,
          ),
          NavbarItem(
            icon: Icons.login_sharp,
            text: 'Log Out',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            textStyle: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
            iconColor: theme.iconTheme.color,
          ),
        ],
      ),
    );
  }
}
