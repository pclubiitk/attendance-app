import 'package:attendance_app/screens/admin_dashboard.dart';
import 'package:attendance_app/screens/event_info.dart';
import 'package:attendance_app/screens/events/create_event.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_assets/forui_assets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';


class AdminEventsPage extends StatefulWidget {
  @override
  _AdminEventsPageState createState() => _AdminEventsPageState();
}

class _AdminEventsPageState extends State<AdminEventsPage> {
  // Dummy event data (replace with API data)
  final List<Map<String, String>> events = List.generate(
    10,
    (index) => {
      'title': 'Event ${index + 1}',
      'description': 'Description for Event ${index + 1}',
      'date': 'October ${index + 20}, 2023',
      'time': '10:00 AM - 4:00 PM',
      'location': 'Location ${index + 1}',
      'organizer': 'Organizer ${index + 1}',
    },
  );

  @override
  Widget build(BuildContext context) {
    final double availableHeight = MediaQuery.of(context).size.height -
        kToolbarHeight // Height of AppBar
        -
        kBottomNavigationBarHeight; // Height of the BottomNavigationBar

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Events'),
        prefixActions: [
          FHeaderAction.back(
            onPress: () {
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
            },
          ),
        ],
        suffixActions: [
          FHeaderAction(
            icon: FIcon(FAssets.icons.search),
            onPress: () {
              // Add search functionality here
            },
          ),
          FHeaderAction(
            icon: FIcon(FAssets.icons.plus),
            onPress: () {
              // Navigate to the Create Event Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventPage()),
              );
            },
          ),
        ],
      ),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to EventInfoPage with event details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventInfoPage(eventDetails: event),
                          ),
                        );
                      },
                      child: ShadCard(
                        title: Text(event['title']!),
                        description: Text(event['description']!),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            _buildDetailRow(
                              icon: FIcon(FAssets.icons.calendar),
                              label: 'Date',
                              value: event['date']!,
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              icon: FIcon(FAssets.icons.clock),
                              label: 'Time',
                              value: event['time']!,
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              icon: FIcon(FAssets.icons.locate),
                              label: 'Location',
                              value: event['location']!,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                        footer: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ShadButton(
                              onPressed: () {
                                // Add functionality to edit or manage the event
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventInfoPage(eventDetails: event),
                          ));
                              },
                              child: const Text('Manage Event'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a detail row with icon, label, and value
  Widget _buildDetailRow({
    required Widget icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}