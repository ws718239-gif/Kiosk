import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiosk/app.dart';
import 'package:kiosk/core/utils/shared_prefs.dart';

void main() {
  testWidgets('Navigation and Form UI Test', (WidgetTester tester) async {
    // 1. Setup mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();

    // 2. Build the app
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPrefsProvider.overrideWithValue(sharedPrefs),
        ],
        child: const KioskApp(),
      ),
    );

    await tester.pumpAndSettle();

    // 3. Verify Dashboard
    expect(find.text('Kiosk'), findsOneWidget);

    // 4. Tap 'Start Visitor Check-in' button to go to Hosts screen
    await tester.tap(find.text('Start Visitor Check-in'));
    await tester.pumpAndSettle();

    // 5. Verify we are on the Select Host screen
    expect(find.text('Select Host'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget); // Search bar should be there
  });
}
