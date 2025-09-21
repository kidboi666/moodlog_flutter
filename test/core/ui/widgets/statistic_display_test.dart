import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/ui/widgets/statistic_display.dart';

void main() {
  group('StatisticDisplay', () {
    testWidgets('should display value and unit correctly', (tester) async {
      // Arrange
      const value = '42';
      const unit = '개';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatisticDisplay(
              value: value,
              unit: unit,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(value), findsOneWidget);
      expect(find.text(unit), findsOneWidget);
    });

    testWidgets('should apply custom colors when provided', (tester) async {
      // Arrange
      const value = '42';
      const unit = '개';
      const valueColor = Colors.red;
      const unitColor = Colors.blue;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatisticDisplay(
              value: value,
              unit: unit,
              valueColor: valueColor,
              unitColor: unitColor,
            ),
          ),
        ),
      );

      // Assert
      final valueWidget = tester.widget<Text>(find.text(value));
      final unitWidget = tester.widget<Text>(find.text(unit));

      expect(valueWidget.style?.color, valueColor);
      expect(unitWidget.style?.color, unitColor);
    });
  });

  group('StatusIndicator', () {
    testWidgets('should display status text with correct color', (tester) async {
      // Arrange
      const status = 'Active';
      const color = Colors.green;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatusIndicator(
              status: status,
              color: color,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(status), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text(status));
      expect(textWidget.style?.color, color);
    });

    testWidgets('should display icon when provided', (tester) async {
      // Arrange
      const status = 'Active';
      const color = Colors.green;
      const icon = Icons.check;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatusIndicator(
              status: status,
              color: color,
              icon: icon,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(icon), findsOneWidget);

      final iconWidget = tester.widget<Icon>(find.byIcon(icon));
      expect(iconWidget.color, color);
    });
  });

  group('InfoRow', () {
    testWidgets('should display label and value correctly', (tester) async {
      // Arrange
      const label = 'Total Records';
      const value = '150';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoRow(
              label: label,
              value: value,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
      expect(find.text(value), findsOneWidget);
    });

    testWidgets('should apply custom colors when provided', (tester) async {
      // Arrange
      const label = 'Total Records';
      const value = '150';
      const labelColor = Colors.grey;
      const valueColor = Colors.black;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoRow(
              label: label,
              value: value,
              labelColor: labelColor,
              valueColor: valueColor,
            ),
          ),
        ),
      );

      // Assert
      final labelWidget = tester.widget<Text>(find.text(label));
      final valueWidget = tester.widget<Text>(find.text(value));

      expect(labelWidget.style?.color, labelColor);
      expect(valueWidget.style?.color, valueColor);
    });
  });

  group('InfoContainer', () {
    testWidgets('should wrap child correctly', (tester) async {
      // Arrange
      const childText = 'Test Content';
      const child = Text(childText);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoContainer(
              child: child,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should apply custom background color when provided', (tester) async {
      // Arrange
      const childText = 'Test Content';
      const child = Text(childText);
      const backgroundColor = Colors.red;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoContainer(
              child: child,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, backgroundColor);
    });
  });
}