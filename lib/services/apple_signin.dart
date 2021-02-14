import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSigninService {
  static void singIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(credential);
      print(credential.authorizationCode);
      final signInAppleURL = Uri(
          scheme: 'https',
          host: 'flutter-google-singin.herokuapp.com',
          path: '/api/usuario/apple/signin',
          queryParameters: {
            'code': credential.authorizationCode,
            'firstName': credential.givenName,
            'lastName': credential.familyName,
            'useBundleId': Platform.isIOS ? 'true' : 'false',
            if (credential.state != null) 'state': credential.state
          });

      final session = await http.post(signInAppleURL);

      print('====== BACKEND ======');
      print(session.body);
    } catch (e) {
      print('Error en Apple');
      print(e);
      return null;
    }
  }
}
