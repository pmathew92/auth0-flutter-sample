import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final auth0 = Auth0(
    dotenv.env['AUTH0_DOMAIN']!,
    dotenv.env['AUTH0_CLIENT_ID']!,
  );

  Future<Credentials> login() async {
    final credentials =
        await auth0.webAuthentication(scheme: "demo").login(useHTTPS: false);
    return credentials;
  }

  Future<void> logout() async {
    await auth0.webAuthentication(scheme: "demo").logout(useHTTPS: false);
  }

  /// Checks if there are valid credentials stored.
  /// Returns true if valid credentials exist, false otherwise.
  Future<bool> hasValidCredentials({int minTtl = 0}) async {
    return await auth0.credentialsManager.hasValidCredentials(minTtl: minTtl);
  }

  /// Retrieves stored credentials from the credentials manager.
  /// Automatically refreshes expired credentials if a refresh token is available.
  Future<Credentials> fetchCredentials({
    int minTtl = 0,
    Set<String> scopes = const {},
  }) async {
    return await auth0.credentialsManager.credentials(
      minTtl: minTtl,
      scopes: scopes,
    );
  }
}
