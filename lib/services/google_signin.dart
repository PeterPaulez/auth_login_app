import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSigninService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount> signIn() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final googleKey = await account.authentication;

      print("\n=====================\nData GOOGLE\n=====================\n");
      print(account);
      print("\n====================\nData APITOKEN\n====================\n");
      print(googleKey.idToken);

      final signInGoogleURL = Uri(
        scheme: 'https',
        host: 'flutter-google-singin.herokuapp.com',
        path: '/api/usuario/google',
      );

      final session = await http.post(
        signInGoogleURL,
        body: {'token': googleKey.idToken},
      );

      print('====== BACKEND ======');
      print(session.body);

      return account;
    } catch (e) {
      print('Error en google');
      print(e);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
    print('Logout');
  }
}
