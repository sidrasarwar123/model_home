import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; 

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.snackbar("Success", "Logged in with Google");
      Get.offAllNamed('/bottombar');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // // Facebook Sign-In
  // Future<void> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();

  //     if (result.status == LoginStatus.success) {
  //       final OAuthCredential credential =
  //           FacebookAuthProvider.credential(result.accessToken!.token);
  //       await _auth.signInWithCredential(credential);
  //       Get.snackbar("Success", "Logged in with Facebook");
  //       Get.offAllNamed('/bottombar');
  //     } else {
  //       Get.snackbar("Error", result.message ?? "Facebook login failed");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }

  // Apple Sign-In
  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      await _auth.signInWithCredential(oauthCredential);
      Get.snackbar("Success", "Logged in with Apple");
      Get.offAllNamed('/bottombar');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    Get.offAllNamed('/welcomescreen');
  }
}
