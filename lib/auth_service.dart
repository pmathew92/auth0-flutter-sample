

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final auth0 = Auth0(
    dotenv.env['AUTH0_DOMAIN']!,
    dotenv.env['AUTH0_CLIENT_ID']!,
  );

  Future<Credentials> login()  async {
    final credentials =  await auth0.webAuthentication(scheme: "demo")
        .login(useHTTPS: false
        );

        print(credentials.accessToken);
        return credentials;
  }

  Future<void> logout() async {
    await auth0.webAuthentication(scheme: "demo").logout(useHTTPS: false);
  }
}