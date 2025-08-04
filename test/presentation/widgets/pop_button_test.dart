import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/presentation/core/widgets/pop_button.dart';

void main() {
  testWidgets('PopButton has callback', (tester) async {
    await tester.pumpWidget(PopButton(onTap: () => print('asdf')));
  });
}
