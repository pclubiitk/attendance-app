import 'package:attendance_app/screens/events/create_sub_event.dart';
import 'package:attendance_app/screens/subevent_info.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EventInfoPage extends StatelessWidget {
  final Map<String, String> eventDetails;

  const EventInfoPage({super.key, required this.eventDetails});

  @override
  Widget build(BuildContext context) {
    // Dummy sub-events data
    final List<Map<String, String>> subEvents = List.generate(
      5,
      (index) => {
        'title': 'Sub-Event ${index + 1}',
        'description': 'Description for Sub-Event ${index + 1}',
        'date': 'October ${index + 26}, 2023',
        'time': '10:00 AM - 4:00 PM',
        'location': 'Location ${index + 1}',
      },
    );

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Event Details'),
        prefixActions: [
          FHeaderAction.back(
            onPress: () {
              Navigator.pop(context);
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
              // Add functionality to create a sub-event or related action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateSubEventPage()),
              );
            },
          ),
        ],
      ),
      content: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Event Details Section
              ShadCard(
                border: Border.all(color: Colors.white),
                backgroundColor: Colors.white,
                radius: BorderRadius.circular(0),
                title: const Text('Event Details'),
                description: const Text('Important information about the event.'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      icon: FIcon(FAssets.icons.calendar),
                      label: 'Date',
                      value: eventDetails['date']!,
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      icon: FIcon(FAssets.icons.clock),
                      label: 'Time',
                      value: eventDetails['time']!,
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      icon: FIcon(FAssets.icons.locate),
                      label: 'Location',
                      value: eventDetails['location']!,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                footer: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadButton(
                      onPressed: () {
                        // Add functionality to register or take action
                      },
                      child: const Text('Mark as complete'),
                    ),
                    ShadButton(
                      onPressed: () {
                        // Add functionality to register or take action
                      },
                      child: const Text('Edit Event'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Reduced spacing

              // Sub-Events Section
              Text(
                'Sub-Events: ${subEvents.length}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subEvents.length,
                itemBuilder: (context, index) {
                  final subEvent = subEvents[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // Reduced spacing
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to SubEventDetailsPage with sub-event details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubEventDetailsPage(
                              subEventDetails: subEvent,
                            ),
                          ),
                        );
                      },
                      child: ShadCard(
                        title: Text(subEvent['title']!),
                        description: Text(subEvent['description']!),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            _buildDetailRow(
                              icon: FIcon(FAssets.icons.calendar),
                              label: 'Date',
                              value: subEvent['date']!,
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              icon: FIcon(FAssets.icons.clock),
                              label: 'Time',
                              value: subEvent['time']!,
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              icon: FIcon(FAssets.icons.locate),
                              label: 'Location',
                              value: subEvent['location']!,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                        footer: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ShadButton(
                              onPressed: () {
                                // Add functionality to manage the sub-event
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubEventDetailsPage(
                                      subEventDetails: subEvent,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Manage Sub-Event'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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