import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_assets/forui_assets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SubEventDetailsPage extends StatelessWidget {
  final Map<String, String> subEventDetails;

  const SubEventDetailsPage({super.key, required this.subEventDetails});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Sub-Event Details'),
        prefixActions: [
          FHeaderAction.back(
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ],
        suffixActions: [
          // Three Dots Icon with Popup Menu
          Theme(
            data: Theme.of(context).copyWith(
    // Customize the PopupMenuButton theme
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white, // Background color
      textStyle: TextStyle(
        color: Colors.black, // Text color
      ),
    ),
  ),
            child: PopupMenuButton<String>(
              icon: FIcon(FAssets.icons.ellipsisVertical), // Three dots icon
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit Event'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete Event'),
                ),
                const PopupMenuItem<String>(
                  value: 'share',
                  child: Text('Share Event'),
                ),
              ],
              onSelected: (value) {
                // Handle menu item selection
                switch (value) {
                  case 'edit':
                    print('Edit Event selected');
                    // Add edit functionality here
                    break;
                  case 'delete':
                    print('Delete Event selected');
                    // Add delete functionality here
                    break;
                  case 'share':
                    print('Share Event selected');
                    // Add share functionality here
                    break;
                }
              },
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Sub-Event Name
            Text(
              subEventDetails['title']!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subEventDetails['description']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Tabs for Details and People
            ShadTabs<String>(
              value: 'details', // Default selected tab
              tabBarConstraints: const BoxConstraints(maxWidth: 400),
              contentConstraints: const BoxConstraints(maxWidth: 400),
              tabs: [
                // Details Tab
                ShadTab(
                  value: 'details',
                  child: const Text('Details'),
                  content: _buildDetailsTab(),
                ),
                // People Tab
                ShadTab(
                  value: 'people',
                  child: const Text('People'),
                  content: _buildPeopleTab(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Actions Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShadButton(
                  onPressed: () {
                    // Add functionality to mark as completed
                  },
                  child: const Text('Mark Completed'),
                ),
                ShadButton(
                  onPressed: () {
                    // Add functionality to edit the sub-event
                  },
                  child: const Text('Edit Event'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the Details tab content
  Widget _buildDetailsTab() {
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: FIcon(FAssets.icons.calendar),
            label: 'Date',
            value: subEventDetails['date']!,
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            icon: FIcon(FAssets.icons.clock),
            label: 'Time',
            value: subEventDetails['time']!,
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            icon: FIcon(FAssets.icons.locate),
            label: 'Location',
            value: subEventDetails['location']!,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Helper method to build the People tab content
  Widget _buildPeopleTab(BuildContext context) {
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Assigned Officers',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Officer 1'),
              const Text("P", style: TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Officer 2'),
              const Text("A", style: TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity, // Make the button take full width
            child: ShadButton(
              onPressed: () {
                // Open the Assign Officer dialog
                _showAssignOfficerDialog(context);
              },
              child: const Text('Assign Officer'),
            ),
          ),
        ],
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


void _showAssignOfficerDialog(BuildContext context) {
  // Sample list of officers
  final List<String> allOfficers = [
    'Officer 1',
    'Officer 2',
    'Officer 3',
    'Officer 4',
    'Officer 5',
  ];

  // State to manage selected officers
  final Map<String, bool> selectedOfficers = {
    for (var officer in allOfficers) officer: false,
  };

  // State to manage search query
  String searchQuery = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white, // Set background color
            title: const Text('Assign Officers'),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Use min to avoid layout issues
                children: [
                  const SizedBox(height: 16),

                  // Search Bar and Filter Button
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search officers...',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value; // Update search query
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShadButton(
                        onPressed: () {
                          // Add filter functionality here
                        },
                        child: const Text('Filter'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // List of Officers with Checkboxes
                  SizedBox(
                    height: 300, // Set a fixed height for the list
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allOfficers.length,
                      itemBuilder: (context, index) {
                        final officer = allOfficers[index];
                        // Filter officers based on search query (case-insensitive)
                        if (!officer.toLowerCase().contains(searchQuery.toLowerCase())) {
                          return const SizedBox.shrink(); // Hide non-matching officers
                        }
                        return CheckboxListTile(
                          title: Text(officer),
                          value: selectedOfficers[officer],
                          onChanged: (value) {
                            setState(() {
                              selectedOfficers[officer] = value!; // Update selection
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // Cancel Button
              ShadButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Cancel'),
              ),

              // Confirm Button
              ShadButton(
                onPressed: () {
                  // Get the list of selected officers
                  final selected = selectedOfficers.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();

                  // Perform the assignment logic here
                  print('Selected Officers: $selected');

                  // Close the dialog
                  Navigator.pop(context);
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
    },
  );
}



}