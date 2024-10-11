import 'package:attendance_app/screens/user_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('Event Generation', (tester) async{
    await tester.pumpWidget(
      const MaterialApp(
        home: userEvents(),
      ),
    );

    expect(find.byKey(const Key('Calendar')) , findsOneWidget); // calendar widget
    expect(find.byKey(const Key('Events')) , findsOneWidget); // before generation of events
  });
}