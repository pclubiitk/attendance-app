import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_assets/forui_assets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _organizerController = TextEditingController();

  DateTimeRange? _selectedDateRange;

  @override
  void dispose() {
    _eventNameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _organizerController.dispose();
    super.dispose();
  }

Future<void> _selectDateRange(BuildContext context) async {
  final DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(2030),
    initialDateRange: _selectedDateRange,
    barrierColor: Colors.black.withOpacity(0.5), // Overlay color
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // Customize the date picker theme
          colorScheme: ColorScheme.light(
            primary: Colors.black, // Primary color
            onPrimary: Colors.white, // Text color on primary
            surface: Colors.white, // Background color
            onSurface: Colors.black, // Text color
            secondary: Colors.black.withOpacity(0.5), // Secondary color
            background: Colors.white
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // Button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      _selectedDateRange = picked;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Create Event'),
        prefixActions: [
          FHeaderAction.back(
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            // Event Name Field
            ShadInput(
              controller: _eventNameController,
              placeholder: const Text('Enter Event Name'),
            ),
            const SizedBox(height: 16),

            // Event Type Dropdown
            const SelectWithSearch(),
            const SizedBox(height: 16),

            // Date Range Selection
            ShadButton(
              width: double.infinity,
              child: const Text('Select Date Range'),
              onPressed: () => _selectDateRange(context),
            ),
            const SizedBox(height: 8),
            if (_selectedDateRange != null)
              Text(
                'Selected Date Range: ${_selectedDateRange!.start.toLocal().toString().split(' ')[0]} - ${_selectedDateRange!.end.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            
            // Time Field (Custom Time Picker)
            ShadInput(
              controller: _timeController,
              placeholder: const Text('Enter Event Time (e.g., 10:00 AM)'),
            ),
            const SizedBox(height: 16),

            // Location Field
            ShadInput(
              controller: _locationController,
              placeholder: const Text('Enter Event Location'),
            ),
            const SizedBox(height: 16),

            // Description Field
            FTextField.multiline(
              controller: _descriptionController,
              label: const Text('Description'),
              hint: 'Enter Event Description',
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadButton.outline(
                  width: 100,
                  child: const Text('Discard'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 16),
                ShadButton(
                  width: 100,
                  child: const Text('Create'),
                  onPressed: () {
                    // Validate and save the form data
                    if (_eventNameController.text.isEmpty ||
                        _selectedDateRange == null ||
                        _timeController.text.isEmpty ||
                        _locationController.text.isEmpty ||
                        _organizerController.text.isEmpty ||
                        _descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                        ),
                      );
                    } else {
                      // Navigate to the next page
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CreateSubEventPage2(),
                      //   ),
                      // );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Event Type Dropdown with Search
class SelectWithSearch extends StatefulWidget {
  const SelectWithSearch({super.key});

  @override
  State<SelectWithSearch> createState() => _SelectWithSearchState();
}

class _SelectWithSearchState extends State<SelectWithSearch> {
  var searchValue = '';

  final Map<String, String> eventNames = {
    'police_briefing': 'Police Briefing',
    'crime_scene_investigation': 'Crime Scene Investigation',
    'patrol_duty': 'Patrol Duty',
    'community_meeting': 'Community Meeting',
    'training_session': 'Training Session',
  };

  Map<String, String> get filteredEvents => {
        for (final event in eventNames.entries)
          if (event.value.toLowerCase().contains(searchValue.toLowerCase()))
            event.key: event.value
      };

  @override
  Widget build(BuildContext context) {
    return ShadSelect<String>.withSearch(
      minWidth: MediaQuery.of(context).size.width * 0.9,
      maxWidth: 400,
      placeholder: const Text('Select Event...'),
      onSearchChanged: (value) => setState(() => searchValue = value),
      searchPlaceholder: const Text('Search Event'),
      options: [
        if (filteredEvents.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text('No Event found'),
          ),
        ...eventNames.entries.map(
          (event) {
            return Offstage(
              offstage: !filteredEvents.containsKey(event.key),
              child: ShadOption(
                value: event.key,
                child: Text(event.value),
              ),
            );
          },
        ),
      ],
      selectedOptionBuilder: (context, value) => Text(eventNames[value]!),
    );
  }
}

