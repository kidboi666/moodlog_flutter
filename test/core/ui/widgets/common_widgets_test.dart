import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/ui/widgets/common_widgets.dart';

void main() {
  group('CommonSizedBox', () {
    test('should provide correct height values', () {
      // Assert
      expect(CommonSizedBox.heightXs.height, 4.0);
      expect(CommonSizedBox.heightSm.height, 8.0);
      expect(CommonSizedBox.heightMd.height, 16.0);
      expect(CommonSizedBox.heightLg.height, 24.0);
      expect(CommonSizedBox.heightXl.height, 32.0);
    });

    test('should provide correct width values', () {
      // Assert
      expect(CommonSizedBox.widthXs.width, 4.0);
      expect(CommonSizedBox.widthSm.width, 8.0);
      expect(CommonSizedBox.widthMd.width, 16.0);
      expect(CommonSizedBox.widthLg.width, 24.0);
      expect(CommonSizedBox.widthXl.width, 32.0);
    });

    test('should provide empty and expand widgets', () {
      // Assert
      expect(CommonSizedBox.empty, isA<SizedBox>());
      expect(CommonSizedBox.expand, isA<Expanded>());
    });
  });

  group('CommonDivider', () {
    test('should provide different divider types', () {
      // Assert
      expect(CommonDivider.thin.height, 1);
      expect(CommonDivider.thin.thickness, 1);
      expect(CommonDivider.normal, isA<Divider>());
      expect(CommonDivider.thick.height, 2);
      expect(CommonDivider.thick.thickness, 2);
      expect(CommonDivider.invisible.color, Colors.transparent);
    });
  });

  group('CommonPadding', () {
    test('should provide correct all padding values', () {
      // Assert
      expect(CommonPadding.xs, const EdgeInsets.all(4.0));
      expect(CommonPadding.sm, const EdgeInsets.all(8.0));
      expect(CommonPadding.md, const EdgeInsets.all(16.0));
      expect(CommonPadding.lg, const EdgeInsets.all(24.0));
      expect(CommonPadding.xl, const EdgeInsets.all(32.0));
    });

    test('should provide correct horizontal padding values', () {
      // Assert
      expect(CommonPadding.horizontalXs, const EdgeInsets.symmetric(horizontal: 4.0));
      expect(CommonPadding.horizontalSm, const EdgeInsets.symmetric(horizontal: 8.0));
      expect(CommonPadding.horizontalMd, const EdgeInsets.symmetric(horizontal: 16.0));
      expect(CommonPadding.horizontalLg, const EdgeInsets.symmetric(horizontal: 24.0));
      expect(CommonPadding.horizontalXl, const EdgeInsets.symmetric(horizontal: 32.0));
    });

    test('should provide correct vertical padding values', () {
      // Assert
      expect(CommonPadding.verticalXs, const EdgeInsets.symmetric(vertical: 4.0));
      expect(CommonPadding.verticalSm, const EdgeInsets.symmetric(vertical: 8.0));
      expect(CommonPadding.verticalMd, const EdgeInsets.symmetric(vertical: 16.0));
      expect(CommonPadding.verticalLg, const EdgeInsets.symmetric(vertical: 24.0));
      expect(CommonPadding.verticalXl, const EdgeInsets.symmetric(vertical: 32.0));
    });
  });

  group('LoadingWidget', () {
    testWidgets('should display loading indicator', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display message when provided', (tester) async {
      // Arrange
      const message = 'Loading data...';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: message),
          ),
        ),
      );

      // Assert
      expect(find.text(message), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should use custom size when provided', (tester) async {
      // Arrange
      const customSize = 64.0;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(size: customSize),
          ),
        ),
      );

      // Assert
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.width, customSize);
      expect(sizedBox.height, customSize);
    });
  });

  group('EmptyStateWidget', () {
    testWidgets('should display icon and title', (tester) async {
      // Arrange
      const icon = Icons.inbox;
      const title = 'No data available';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: icon,
              title: title,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(title), findsOneWidget);
    });

    testWidgets('should display subtitle when provided', (tester) async {
      // Arrange
      const icon = Icons.inbox;
      const title = 'No data available';
      const subtitle = 'Try adding some data first';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: icon,
              title: title,
              subtitle: subtitle,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(subtitle), findsOneWidget);
    });

    testWidgets('should display action widget when provided', (tester) async {
      // Arrange
      const icon = Icons.inbox;
      const title = 'No data available';
      const action = ElevatedButton(
        onPressed: null,
        child: Text('Add Data'),
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: icon,
              title: title,
              action: action,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Add Data'), findsOneWidget);
    });
  });
}