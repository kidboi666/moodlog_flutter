import 'dart:convert';

class JwtUtils {
  /// JWT 토큰을 디코딩하여 payload를 반환합니다.
  static Map<String, dynamic>? decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      // Base64 URL 디코딩을 위해 패딩 추가
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64.decode(normalized));

      return json.decode(decoded) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// JWT 토큰에서 이메일을 추출합니다.
  static String? extractEmailFromJwt(String? identityToken) {
    if (identityToken == null || identityToken.isEmpty) {
      return null;
    }

    try {
      final payload = decodeJwtPayload(identityToken);
      if (payload == null) {
        return null;
      }

      // Apple ID 토큰에서 이메일 필드 확인
      return payload['email'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// JWT 토큰에서 사용자 정보를 추출합니다.
  static Map<String, String?> extractUserInfoFromJwt(String? identityToken) {
    if (identityToken == null || identityToken.isEmpty) {
      return {};
    }

    try {
      final payload = decodeJwtPayload(identityToken);
      if (payload == null) {
        return {};
      }

      return {
        'email': payload['email'] as String?,
        'email_verified': payload['email_verified']?.toString(),
        'sub': payload['sub'] as String?, // Apple 사용자 ID
        'aud': payload['aud'] as String?, // 앱 ID
        'iss': payload['iss'] as String?, // 발행자 (Apple)
      };
    } catch (e) {
      return {};
    }
  }
}