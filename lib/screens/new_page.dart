import 'package:flutter/material.dart';
import 'package:forui/forui.dart'; // Ensure this import is correct
import 'package:forui_assets/forui_assets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('UP Police Services'),
        suffixActions: [
          // FHeaderAction(
          //   icon: FIcon(FAssets.icons.search),
          //   onPress: () {},
          // ),
          // FHeaderAction(
          //   icon: FIcon(FAssets.icons.plus),
          //   onPress: () {},
          // ),
        ],
      ),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Correct usage of FLineCalendar
            // FLineCalendar(
            //   controller: FCalendarController.date(
            //     initialSelection: DateTime.now().subtract(const Duration(days: 1)),
            //   ),
            // ),
            const Text(
              'Home Page NEED IDEAS',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24), // Spacer between title and tabs

            // ShadTabs implementation
            // ShadTabs<String>(
            //   value: 'account',
            //   tabBarConstraints: const BoxConstraints(maxWidth: 400),
            //   contentConstraints: const BoxConstraints(maxWidth: 400),
            //   tabs: [
            //     ShadTab(
            //       value: 'account',
            //       child: const Text('Account'),
            //       content: ShadCard(
            //         title: const Text('Account'),
            //         description: const Text(
            //             "Make changes to your account here. Click save when you're done."),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             const SizedBox(height: 16),
            //             ShadInputFormField(
            //               label: const Text('Name'),
            //               initialValue: 'Ale',
            //             ),
            //             const SizedBox(height: 8),
            //             ShadInputFormField(
            //               label: const Text('Username'),
            //               initialValue: 'nank1ro',
            //             ),
            //             const SizedBox(height: 16),
            //           ],
            //         ),
            //         footer: const ShadButton(child: Text('Save changes')),
            //       ),
            //     ),
            //     ShadTab(
            //       value: 'password',
            //       child: const Text('Password'),
            //       content: ShadCard(
            //         title: const Text('Password'),
            //         description: const Text(
            //             "Change your password here. After saving, you'll be logged out."),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             const SizedBox(height: 16),
            //             ShadInputFormField(
            //               label: const Text('Current password'),
            //               obscureText: true,
            //             ),
            //             const SizedBox(height: 8),
            //             ShadInputFormField(
            //               label: const Text('New password'),
            //               obscureText: true,
            //             ),
            //             const SizedBox(height: 16),
            //           ],
            //         ),
            //         footer: const ShadButton(child: Text('Save password')),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}