import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/ui/widgets/pop_button.dart';

void main() {
  testWidgets('PopButton has callback', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PopButton(onTap: () {})),
      ),
    );
    expect(find.byType(IconButton), findsOneWidget);
  });
}
