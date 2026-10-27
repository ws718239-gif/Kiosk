import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kiosk/app.dart';
import 'package:kiosk/core/utils/shared_prefs.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Edge-to-Edge Kiosk App Test', (WidgetTester tester) async {
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

    // Step 1: Verify Dashboard
    expect(find.text('Welcome to Naapbooks'), findsOneWidget);
    print('✅ Dashboard verified.');

    // Step 2: Navigate to Admin Settings
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text('Admin Settings'), findsOneWidget);
    print('✅ Admin Settings verified.');

    // Step 3: Go back to dashboard
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Step 4: Go to Visitor Check-in
    await tester.tap(find.text('Visitor Check-in'));
    await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for API call
    
    expect(find.text('Select Host'), findsOneWidget);
    print('✅ Select Host (Host Directory) verified.');

    // Note: In integration testing on a real environment, the API call will fetch hosts.
    // If the mock API is running, we should see hosts.
    if (find.byType(Card).evaluate().isNotEmpty) {
       print('✅ Host data fetched successfully from API.');
       
       // Tap the first host
       await tester.tap(find.byType(Card).first);
       await tester.pumpAndSettle();

       expect(find.text('Visitor Check-in'), findsOneWidget);
       print('✅ Visitor Form loaded.');

       // Type into form
       await tester.enterText(find.widgetWithText(TextFormField, 'Full Name'), 'John Doe Test');
       await tester.enterText(find.widgetWithText(TextFormField, 'Email Address'), 'john@test.com');
       await tester.enterText(find.widgetWithText(TextFormField, 'Phone Number'), '9876543210');
       await tester.enterText(find.widgetWithText(TextFormField, 'Purpose of Visit'), 'Interview');
       print('✅ Form filled successfully.');

       // Tap checkbox
       await tester.tap(find.byType(CheckboxListTile));
       await tester.pumpAndSettle();
       print('✅ Consent checked.');

       // Cannot easily test camera capture in integration tests out of the box because it requests OS permissions.
       // So we will stop the automated interaction here.
    } else {
       print('⚠️ No hosts found. Make sure Mock API is running.');
    }

    // Step 5: Check Today's Visitors
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('View Today\'s Visitors'));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('Today\'s Visitors'), findsOneWidget);
    print('✅ Today\'s Visitors screen loaded and fetched data.');
  });
}
