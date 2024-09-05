import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'TestDrawerWidget.dart';

void main() {
  testWidgets('Drawer widget should display UserAccountsDrawerHeader with correct image',
          (WidgetTester tester) async {
        // Arrange
        const String testProfileImageUrl =
            'https://example.com/test-image.jpg';

        // Act
        await tester.pumpWidget(const TestDrawerWidget(profileImageUrl: testProfileImageUrl));

        // Open the Drawer
        await tester.tap(find.byType(Scaffold));
        await tester.pump(); // rebuilds the widget tree with the drawer open

        // Assert
        expect(find.byType(Drawer), findsOneWidget); // Ensure Drawer is present
        expect(find.byType(UserAccountsDrawerHeader), findsOneWidget); // Ensure UserAccountsDrawerHeader is present
        expect(find.byType(CircleAvatar), findsOneWidget); // Ensure CircleAvatar is present

        // Verify the image loaded is the one provided
        final CircleAvatar avatar = tester.widget(find.byType(CircleAvatar));
        expect(
          (avatar.backgroundImage as NetworkImage).url,
          testProfileImageUrl,
        );
      });
}
