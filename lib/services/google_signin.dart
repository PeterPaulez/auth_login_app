import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount> signIn() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      print(
          "\n=======================\nData GOOGLE\n=======================\n");
      print(account);
      // TODO: idToken y validación con nuestro BackEnd
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
