import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// TODO: Understand how it saves the token in keycahin in ios

class TokenService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt', value: token.split(' ')[1]);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }

  Future<bool> isTokenValid() async {
    final token = await getToken();

    // If no token exists, return false
    if (token == null) {
      return false;
    }

    // Check if the token has expired
    return !JwtDecoder.isExpired(token);
  }

  Future<Map<String, dynamic>?> getDecodedToken() async {
    final token = await getToken();

    if (token == null) {
      return null;
    }
    return JwtDecoder.decode(token);
  }
}
