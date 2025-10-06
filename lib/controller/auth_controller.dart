import 'package:flutter/foundation.dart'; // kIsWeb ke liye
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool signingIn = false; 

  Future<void> signInWithGoogle() async {
    if (signingIn) return;
    signingIn = true;

    try {
      if (kIsWeb) {
        // Web ke liye Google login
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await _auth.signInWithPopup(googleProvider);
      } else {
        // Mobile ke liye
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return;

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
      }

      Get.snackbar("Success", "Logged in with Google");
      Get.offAllNamed('/bottombar');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      signingIn = false;
    }
  }

  Future<void> signInWithApple() async {
    if (signingIn) return;
    signingIn = true;

    try {
      if (kIsWeb) {
        throw Exception("Apple Sign-In not supported on web"); // Web me Apple sign-in nahi
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
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
    } finally {
      signingIn = false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    Get.offAllNamed('/welcomescreen');
  }
}
