import 'package:attendance_app/colors.dart';
import 'package:attendance_app/components/input_form_controller.dart';
import 'package:attendance_app/components/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateSubEventPage3 extends StatefulWidget {
  @override
  _CreateSubEventPageState3 createState() => _CreateSubEventPageState3();
}

class _CreateSubEventPageState3 extends State<CreateSubEventPage3> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Create Sub Event'),
        prefixActions: [
          FHeaderAction.back(onPress: () {
            Navigator.pop(context);
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
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 36.0),
              child: ReusableProgressIndicator(
                progressValue: 0.66,
              ),
            ),
            SelectWithSearch(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadButton.outline(
                  width: 100,
                  child: const Text('Cancel'),
                  onPressed: () {},
                ),
                const SizedBox(width: 30),
                ShadButton(
                  backgroundColor: UIColor.Blue,
                  width: 100,
                  child: const Text('Next'),
                  onPressed: () {},
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


const officers = {
  'Reddy': 'Reddy',
  'Suresh': 'Suresh',
  'Rajesh': 'Rajesh',
  'Ramesh': 'Ramesh',
  'Raj': 'Raj',
  'Rajeev': 'Rajeev',
  'Rajendra': 'Rajendra',
  'Rajiv': 'Rajiv',
  'Rajnish': 'Rajnish',
  'Rajat': 'Rajat',
  'Rajkumar': 'Rajkumar',
};

class SelectWithSearch extends StatefulWidget {
  const SelectWithSearch({super.key});

  @override
  State<SelectWithSearch> createState() => _SelectWithSearchState();
}

class _SelectWithSearchState extends State<SelectWithSearch> {
  var searchValue = '';
  List<String> selectedOfficers = [];

  Map<String, String> get filteredFrameworks => {
        for (final officer in officers.entries)
          if (officer.value.toLowerCase().contains(searchValue.toLowerCase()))
            officer.key: officer.value
      };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ShadSelect<String>.multiple(
          minWidth: screenWidth * .8,
          maxWidth: 400,
          placeholder: const Text('Select officers...'),
          onChanged: (selected) {
            setState(() {
              selectedOfficers = selected; // Update the selected officers list
            });
          },
          selectedOptionsBuilder: (context, values) => Text(
            selectedOfficers.join(', '), // Display selected officers as comma-separated values
          ),
          // searchPlaceholder: const Text('Search officers'),
          options: [
            if (filteredFrameworks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('No officers found'),
              ),
            ...filteredFrameworks.entries.map(
              (officer) => ShadOption(
                value: officer.key,
                child: Text(officer.value),
              ),
            ),
          ],
        ),

        // Displaying the selected officers below
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Selected Officers: ${selectedOfficers.join(', ')}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
