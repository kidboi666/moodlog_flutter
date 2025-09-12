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

      test('객체 Ok 인스턴스 생성', () {
        final result = Result<Map<String, String>>.ok({'key': 'string value'});

        expect(result, isA<Ok<Map<String, String>>>());
        expect(result, isA<Result<Map<String, String>>>());
        expect((result as Ok<Map<String, String>>).value, {
          'key': 'string value',
        });
      });
    });

    group('Result.error 팩토리 생성자', () {
      test('Error 인스턴스 생성', () {
        final exception = Exception('error');
        final result = Result<Exception>.error(exception);

        expect(result, isA<Result<Exception>>());
        expect((result as Error<Exception>).error, exception);
      });
    });
  });
}
