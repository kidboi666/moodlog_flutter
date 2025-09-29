import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JwtUtils {
  final String privateKey = [
    dotenv.env['APPLE_PRIVATE_KEY_LINE1']!,
    dotenv.env['APPLE_PRIVATE_KEY_LINE2']!,
    dotenv.env['APPLE_PRIVATE_KEY_LINE3']!,
    dotenv.env['APPLE_PRIVATE_KEY_LINE4']!,
    dotenv.env['APPLE_PRIVATE_KEY_LINE5']!,
    dotenv.env['APPLE_PRIVATE_KEY_LINE6']!,
  ].join('\\n');

  final jwt = JWT(
    {
      'iss': dotenv.env['APPLE_TEAM_ID'],
      'aud': 'https://appleid.apple.com',
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600,
      'sub': dotenv.env['APPLE_CLIENT_ID'],
    },
    header: {'kid': dotenv.env['APPLE_KEY_ID'], 'alg': 'ES256', 'typ': 'JWT'},
  );
}
