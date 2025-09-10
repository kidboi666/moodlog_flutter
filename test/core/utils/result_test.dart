import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/utils/result.dart';

void main() {
  group('Result 클래스 테스트', () {
    group('Result.ok 팩토리 생성자', () {
      test('문자열 Ok 인스턴스 생성', () {
        final result = Result.ok('success');

        expect(result, isA<Ok<String>>());
        expect(result, isA<Result<String>>());
        expect((result as Ok<String>).value, 'success');
      });

      test('null Ok 인스턴스 생성', () {
        final result = Result<String?>.ok(null);

        expect(result, isA<Ok<String?>>());
        expect(result, isA<Result<String?>>());
        expect((result as Ok<String?>).value, isNull);
      });
    });

    group('Result.failure 팩토리 생성자', () {
      test('Failure 인스턴스 생성', () {
        final result = Result<String>.failure('error');

        expect(result, isA<Failure<String>>());
        expect(result, isA<Result<String>>());
        expect((result as Failure<String>).error, 'error');
      });
    });
  });
}
