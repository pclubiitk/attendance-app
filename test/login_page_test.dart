import 'package:attendance_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('login_page UI', (tester) async{
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // username input, integer
    await tester.enterText(find.byKey(const Key('Test1')),'230626');
    expect(find.text('230626'), findsOneWidget);

    // password input
    await tester.enterText(find.byKey(const Key('Test2')), 'password123');
    expect(find.text('password123'), findsOneWidget);
    
    expect(find.byKey(const Key('Test3')) , findsOneWidget); // login button
    expect(find.byKey(const Key('Test4')) , findsOneWidget); // register button
  });

  testWidgets('login_page Image Loading', (tester) async{
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.byWidgetPredicate((widget) =>
    widget is Image && widget.image is AssetImage && 
    (widget.image as AssetImage).assetName == "assets/Privacy policy-rafiki.png"), 
    findsOneWidget); // image loads correctly
  });

  // ToDo : Login Testing after enabling _loginUser on tap.

  // testWidgets('Login form validation error when fields are empty', (tester) async {
  //   await tester.pumpWidget(
  //     const MaterialApp(
  //       home: LoginPage(),
  //     ),
  //   );

  //   // Tap the login button without entering any text
  //   await tester.tap(find.byKey(const Key('Test3')));
  //   await tester.pumpAndSettle(); // let animatation settle

  //   expect(find.text('Please enter both User ID and Password'), findsOneWidget);
  // });
}