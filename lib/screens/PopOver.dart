import 'package:attendance_app/location/map.dart';
import 'package:attendance_app/screens/location_page.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PopoverPage extends StatefulWidget {
 const PopoverPage({super.key});

 @override
 State<PopoverPage> createState() => _PopoverPageState();
}

class _PopoverPageState extends State<PopoverPage> {
 final popoverController = ShadPopoverController();

 final List<({String name, String initialValue})> layer = [
   (name: 'Width', initialValue: '100%'),
   (name: 'Max. width', initialValue: '300px'),
   (name: 'Height', initialValue: '25px'),
   (name: 'Max. height', initialValue: 'none'),
 ];

 @override
 void dispose() {
   popoverController.dispose();
   super.dispose();
 }

 @override
 Widget build(BuildContext context) {
   final textTheme = ShadTheme.of(context).textTheme;
   double screenWidth = MediaQuery.of(context).size.width;
   double screenHeight = MediaQuery.of(context).size.height;
   return FScaffold(
    content: 
      Column(

        children: [
          SizedBox(height: 40,),
          CardProject()
        ],
      )
   );
  //  return Scaffold(
  //    body: Center(
  //      child: ShadPopover(
  //        controller: popoverController,
  //        popover: (context) => SizedBox(
  //          width: screenWidth * .9,
  //          child: Column(
  //            crossAxisAlignment: CrossAxisAlignment.start,
  //            mainAxisSize: MainAxisSize.min,
  //            children: [
  //             RangeCalendar(),
  //              Text(
  //                'Dimensions',
  //                style: textTheme.h4,
  //              ),
  //              Text(
  //                'Set the dimensions for the layer.',
  //                style: textTheme.p,
  //              ),
  //              const SizedBox(height: 4),
  //              ...layer
  //                  .map((e) => Row(
  //                        mainAxisAlignment: MainAxisAlignment.start,
  //                        children: [
  //                          Expanded(
  //                              child: Text(
  //                            e.name,
  //                            textAlign: TextAlign.start,
  //                          )),
  //                          Expanded(
  //                            flex: 2,
  //                            child: ShadInput(
  //                              initialValue: e.initialValue,
  //                            ),
  //                          )
  //                        ],
  //                      ))
  //                  .toList(),
  //            ],
  //          ),
  //        ),
  //        child: ShadButton.outline(
  //          child: const Text('Open popover'),
  //          onPressed: popoverController.toggle,
  //        ),
  //      ),
  //    ),
  //  );
 }
}

class RangeCalendar extends StatelessWidget {
 const RangeCalendar({super.key});

 @override
 Widget build(BuildContext context) {
   return const ShadCalendar.range(
     min: 2,
     max: 5,
   );
 }
}

const frameworks = {
 'next': 'Next.js',
 'react': 'React',
 'astro': 'Astro',
 'nuxt': 'Nuxt.js',
};

class CardProject extends StatelessWidget {
 const CardProject({super.key});

 @override
 Widget build(BuildContext context) {
   final theme = ShadTheme.of(context);
   double screenWidth = MediaQuery.of(context).size.width;
   return ShadCard(
       width: screenWidth * .9,
       title: Text('Create project', style: theme.textTheme.h4),
       description: const Text('Deploy your new project in one-click.'),
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 16),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
            //  const Text('Name'),
            // //  const ShadInput(placeholder: 'Name of your project'),
            //  const SizedBox(height: 6),
            //  const Text('Framework'),
            //  ShadSelect<String>(
            //    placeholder: const Text('Select'),
            //    options: frameworks.entries
            //        .map(
            //            (e) => ShadOption(value: e.key, child: Text(e.value)))
            //        .toList(),
            //    selectedOptionBuilder: (context, value) {
            //      return Text(frameworks[value]!);
            //    },
            //    onChanged: (value) {},
            //  ),
            //  LocationPage(),
           ],
         ),
       ),
       footer: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           ShadButton.outline(
             child: const Text('Cancel'),
             onPressed: () {},
           ),
           ShadButton(
             child: const Text('Deploy'),
             onPressed: () {},
           ),
         ],
       ),
     );
 }
}

class LocationTypeButton extends StatefulWidget{
  const LocationTypeButton({super.key});

  @override
  State<LocationTypeButton> createState() => _LocationTypeButtonState();
}

class _LocationTypeButtonState extends State<LocationTypeButton>{
  _LocationTypeButtonState(); // Add unnamed constructor

  Position? _currentPosition;
  final List<LatLng> _locations = [];
  bool _fetchingLocation = false;

  @override
  Widget build(BuildContext context) {
    return ShadButton.outline(
      child: const Text('Edit Profile'),
      onPressed: () {
        showShadDialog(
          context: context,
          builder: (context) => ShadDialog(
            title: const Text('Edit Profile'),
            description: const Text(
                "Make changes to your profile here. Click save when you're done"),
            child: Container(
              width: 375,
              height: 600,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _locations.isEmpty ? _buildPlaceholder() : LocationMap(locations: _locations),
                ],
              )
            )
          ),
        );
      },
    );
  }
  Widget _buildPlaceholder() {
    return const Center(
      child: Text(
        'No locations yet. Press the button to get current location.',
        textAlign: TextAlign.center,
      ),
    );
  }
}