import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignApi {
  static final googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  static Future checkLogin() => googleSignIn.isSignedIn();
  static Future<GoogleSignInAccount?> login() => googleSignIn.signIn();

  static Future logout() => googleSignIn.signOut();
}
