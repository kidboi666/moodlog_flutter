import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/ui/widgets/common_widgets.dart';

void main() {
  group('CommonSizedBox', () {
    test('should provide correct height values', () {
      // Assert
      expect(CommonSizedBox.heightXs.height, Spacing.xs);
      expect(CommonSizedBox.heightSm.height, Spacing.sm);
      expect(CommonSizedBox.heightMd.height, Spacing.md);
      expect(CommonSizedBox.heightLg.height, Spacing.lg);
      expect(CommonSizedBox.heightXl.height, Spacing.xl);
    });

    test('should provide correct width values', () {
      // Assert
      expect(CommonSizedBox.widthXs.width, Spacing.xs);
      expect(CommonSizedBox.widthSm.width, Spacing.sm);
      expect(CommonSizedBox.widthMd.width, Spacing.md);
      expect(CommonSizedBox.widthLg.width, Spacing.lg);
      expect(CommonSizedBox.widthXl.width, Spacing.xl);
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
      expect(CommonPadding.xs, const EdgeInsets.all(Spacing.xs));
      expect(CommonPadding.sm, const EdgeInsets.all(Spacing.sm));
      expect(CommonPadding.md, const EdgeInsets.all(Spacing.md));
      expect(CommonPadding.lg, const EdgeInsets.all(Spacing.lg));
      expect(CommonPadding.xl, const EdgeInsets.all(Spacing.xl));
    });

    test('should provide correct horizontal padding values', () {
      // Assert
      expect(CommonPadding.horizontalXs, const EdgeInsets.symmetric(horizontal: Spacing.xs));
      expect(CommonPadding.horizontalSm, const EdgeInsets.symmetric(horizontal: Spacing.sm));
      expect(CommonPadding.horizontalMd, const EdgeInsets.symmetric(horizontal: Spacing.md));
      expect(CommonPadding.horizontalLg, const EdgeInsets.symmetric(horizontal: Spacing.lg));
      expect(CommonPadding.horizontalXl, const EdgeInsets.symmetric(horizontal: Spacing.xl));
    });

    test('should provide correct vertical padding values', () {
      // Assert
      expect(CommonPadding.verticalXs, const EdgeInsets.symmetric(vertical: Spacing.xs));
      expect(CommonPadding.verticalSm, const EdgeInsets.symmetric(vertical: Spacing.sm));
      expect(CommonPadding.verticalMd, const EdgeInsets.symmetric(vertical: Spacing.md));
      expect(CommonPadding.verticalLg, const EdgeInsets.symmetric(vertical: Spacing.lg));
      expect(CommonPadding.verticalXl, const EdgeInsets.symmetric(vertical: Spacing.xl));
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