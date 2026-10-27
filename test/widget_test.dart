import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kiosk/app.dart';
import 'package:kiosk/core/utils/shared_prefs.dart';

void main() {
  testWidgets('Kiosk Dashboard smoke test', (WidgetTester tester) async {
    // 1. Setup mock SharedPreferences for the test environment
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();

    // 2. Build our app wrapped in ProviderScope with the mocked SharedPreferences
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPrefsProvider.overrideWithValue(sharedPrefs),
        ],
        child: const KioskApp(),
      ),
    );

    // 3. Wait for all animations and routing to finish
    await tester.pumpAndSettle();

    // 4. Verify that our dashboard is displayed successfully
    expect(find.text('Kiosk'), findsOneWidget);
    expect(find.text('Visitor Check-in'), findsOneWidget);
    
    // 5. Verify the default counter app text is NOT there
    expect(find.text('0'), findsNothing);
  });
}
