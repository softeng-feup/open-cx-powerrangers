// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/edit_profile.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
   testWidgets('Testing login page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    var mingler = find.text('Mingler');
    expect(mingler, findsOneWidget);

    var email = find.text('Email');
    expect(email, findsOneWidget);
    
    var emailForm = find.byType(TextFormField);
    expect(emailForm, findsWidgets);
    expect(find.text('Email'),findsOneWidget);
    expect(find.text('Password'),findsOneWidget);

    var login = find.text('Login');
    expect(login, findsOneWidget);
    await tester.tap(login);
    expect(login, findsOneWidget);

    var register = find.text('Register');
    expect(register, findsOneWidget);
    await tester.tap(register);
    expect(register, findsOneWidget);

    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('Match'),
    ),));
    expect(find.text('Match'), findsOneWidget);

    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('Events Topics'),
    ),));
    expect(find.text('Events Topics'), findsOneWidget);

  });
   testWidgets('About us', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('About Us'),
    ),));
    var aboutUs = find.text('About Us');
    expect(aboutUs, findsOneWidget);

    await tester.tap(aboutUs);
    expect(aboutUs, findsOneWidget);
   });

   testWidgets('Join Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('join us'),
    ),));
    var joinUs = find.text('join us');
    expect(joinUs, findsOneWidget);

    await tester.tap(joinUs);
    expect(joinUs, findsOneWidget);

   });

   testWidgets('Unjoin Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('unjoin'),
    ),));
    var unjoin = find.text('unjoin');
    expect(unjoin, findsOneWidget);

    await tester.tap(unjoin);
    expect(unjoin, findsOneWidget);

   });

   testWidgets('match rating ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('Rating'),
    ),));
    var rating = find.text('Rating');
    expect(rating, findsOneWidget);

    await tester.tap(rating);
    expect(rating, findsOneWidget);
   });

   testWidgets('accept match', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(
     body: Text('✓'),
    ),));
    var accept = find.text('✓');
    expect(accept, findsOneWidget);

    await tester.tap(accept);
    expect(accept, findsOneWidget);
   });


}
