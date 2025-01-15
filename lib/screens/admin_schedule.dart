import 'package:attendance_app/screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminSchedule extends StatefulWidget {
  @override
  _AdminScheduleState createState() => _AdminScheduleState();
}

class _AdminScheduleState extends State<AdminSchedule> {
  // int initialSelection: DateTime.utc(2024, 9, 13);
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Events'),
        prefixActions: [
          FHeaderAction.back(onPress: () {
             // Check if the current route can be popped
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context); // Pop the current route
              } else {
                // If the route cannot be popped, navigate to a fallback screen (e.g., AdminDashboard)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminDashboard()),
                );
              }
          }),
        ],
        suffixActions: [
          FHeaderAction(
            icon: FIcon(FAssets.icons.search),
            onPress: () {},
          ),
          FHeaderAction(
            icon: FIcon(FAssets.icons.plus),
            onPress: () {},
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              FCalendar(
                controller: FCalendarController.date(
                    initialSelection: DateTime.now().toUtc()),
                start: DateTime.utc(2000),
                end: DateTime.utc(2030),
              ),
              SizedBox(height: 24),
              Text("Events for the selected date", 
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 8),
          
              const  ShadCard(title: Text('Event Title '),
              description: const Text(
                  "Make changes to your account here. Click save when you're done."),
              footer: const ShadButton(child: Text('Save changes')),
                          ),
          
              SizedBox(height: 8),
              const  ShadCard(title: Text('Event Title '),
              description: const Text(
                  "Make changes to your account here. Click save when you're done."),
              footer: const ShadButton(child: Text('Save changes')),
                          ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
