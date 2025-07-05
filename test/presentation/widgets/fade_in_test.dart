import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';

void main() {
  group('FadeIn 위젯 테스트', () {
    testWidgets('페이드인 애니메이션을 정확히 처리함', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: FadeIn(child: const Text('Test Child'))),
      );

      await tester.pump();

      FadeTransition fadeTransition = tester.widget(
        find.byType(FadeTransition),
      );
      ScaleTransition scaleTransition = tester.widget(
        find.byType(ScaleTransition),
      );

      expect(fadeTransition.opacity.value, closeTo(0.0, 0.01));
      expect(scaleTransition.scale.value, closeTo(0.95, 0.01));

      await tester.pump(DelayMs.instant);
      await tester.pumpAndSettle();

      fadeTransition = tester.widget(find.byType(FadeTransition));
      scaleTransition = tester.widget(find.byType(ScaleTransition));

      expect(fadeTransition.opacity.value, closeTo(1.0, 0.01));
      expect(scaleTransition.scale.value, closeTo(1.0, 0.01));

      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('딜레이 기능이 잘 작동함', (WidgetTester tester) async {
      const Duration testDelay = Duration(milliseconds: 200);
      const Duration testDuration = Duration(milliseconds: 100);

      await tester.pumpWidget(
        MaterialApp(
          home: FadeIn(
            delay: testDelay,
            duration: testDuration,
            child: const Text('Delayed Child'),
          ),
        ),
      );

      await tester.pump();

      FadeTransition fadeTransitionInitial = tester.widget(
        find.byType(FadeTransition),
      );
      ScaleTransition scaleTransitionInitial = tester.widget(
        find.byType(ScaleTransition),
      );

      expect(fadeTransitionInitial.opacity.value, closeTo(0.0, 0.01));
      expect(scaleTransitionInitial.scale.value, closeTo(0.95, 0.01));

      await tester.pump(testDelay - const Duration(milliseconds: 50));

      fadeTransitionInitial = tester.widget(find.byType(FadeTransition));
      scaleTransitionInitial = tester.widget(find.byType(ScaleTransition));

      expect(fadeTransitionInitial.opacity.value, closeTo(0.0, 0.01));
      expect(scaleTransitionInitial.scale.value, closeTo(0.95, 0.01));

      await tester.pumpAndSettle();

      final FadeTransition fadeTransitionFinal = tester.widget(
        find.byType(FadeTransition),
      );
      final ScaleTransition scaleTransitionFinal = tester.widget(
        find.byType(ScaleTransition),
      );

      expect(fadeTransitionFinal.opacity.value, closeTo(1.0, 0.01));
      expect(scaleTransitionFinal.scale.value, closeTo(1.0, 0.01));

      expect(find.text('Delayed Child'), findsOneWidget);
    });
  });
}
