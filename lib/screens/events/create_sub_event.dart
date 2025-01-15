import 'package:attendance_app/colors.dart';
import 'package:attendance_app/components/input_form_controller.dart';
import 'package:attendance_app/components/progress_indicator.dart';
import 'package:attendance_app/screens/events/create_sub_event_step2.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateSubEventPage extends StatefulWidget {
  @override
  _CreateSubEventPageState createState() => _CreateSubEventPageState();
}

class _CreateSubEventPageState extends State<CreateSubEventPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subEventNameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveSubEvent() {
    // Handle save action
    final name = _nameController.text;
    final description = _descriptionController.text;
    // Perform save operation
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
                progressValue: 0,
              ),
            ),
            ReusableInputFormField(
              id: 'sub_event_name',
              label: 'Sub Event Name',
              placeholder: 'Enter Sub Event Name',
              controller: _nameController, // Pass the controller
              validator: (v) {
                if (v != null && v.length < 2) {
                  return 'Sub Event Name must be at least 2 characters.';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            SelectWithSearch(),
            SizedBox(height: 10),
            ReusableInputFormField(
              id: 'category',
              label: 'Category',
              placeholder: 'Enter Category Name',
              controller: _subEventNameController, // Pass the controller
              validator: (v) {
                if (v != null && v.length < 2) {
                  return 'Category must be at least 2 characters.';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            FTextField.multiline(
              autocorrect: false,
              controller: _descriptionController, // TextEditingController
              label: const Text('Description...'),
              hint: 'Enter Description',
              maxLines: 4,
            ),
            Spacer(flex: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadButton.outline(
                  width: 100,
  child: const Text('Cancel'),
  onPressed: () {},
),
SizedBox(width: 30),
ShadButton(
  backgroundColor: UIColor.Blue,
  width: 100,
 child: const Text('Next'),
 onPressed: () {
  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateSubEventPage2()),
            );
 },
)
              ],
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
      // content: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         'Sub Event Details',
      //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 20),
      //       TextField(
      //         controller: _nameController,
      //         decoration: InputDecoration(
      //           labelText: 'Sub Event Name',
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       TextField(
      //         controller: _descriptionController,
      //         decoration: InputDecoration(
      //           labelText: 'Description',
      //           border: OutlineInputBorder(),
      //         ),
      //         maxLines: 3,
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: _saveSubEvent,
      //         child: Text('Save'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

const eventNames = {
  'police_briefing': 'Police Briefing',
  'crime_scene_investigation': 'Crime Scene Investigation',
  'patrol_duty': 'Patrol Duty',
  'community_meeting': 'Community Meeting',
  'training_session': 'Training Session',
};

class SelectWithSearch extends StatefulWidget {
  const SelectWithSearch({super.key});

  @override
  State<SelectWithSearch> createState() => _SelectWithSearchState();
}

class _SelectWithSearchState extends State<SelectWithSearch> {
  var searchValue = '';

  Map<String, String> get filteredFrameworks => {
        for (final framework in eventNames.entries)
          if (framework.value.toLowerCase().contains(searchValue.toLowerCase()))
            framework.key: framework.value
      };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ShadSelect<String>.withSearch(
      // focusNode: focusNodes[2],
      minWidth: screenWidth * .9,
      maxWidth: 400,
      placeholder: const Text('Select Event...'),
      onSearchChanged: (value) => setState(() => searchValue = value),
      searchPlaceholder: const Text('Search Event'),
      options: [
        if (filteredFrameworks.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text('No Event found'),
          ),
        ...eventNames.entries.map(
          (framework) {
            // this offstage is used to avoid the focus loss when the search results appear again
            // because it keeps the widget in the tree.
            return Offstage(
              offstage: !filteredFrameworks.containsKey(framework.key),
              child: ShadOption(
                value: framework.key,
                child: Text(framework.value),
              ),
            );
          },
        )
      ],
      selectedOptionBuilder: (context, value) => Text(eventNames[value]!),
    );
  }
}
