import 'package:flutter/foundation.dart'; // kIsWeb ke liye
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:model_home_app/utilies/snackbar_utilies.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
 RxBool isLoading = false.obs;
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
//   Future<void> signInWithFacebook() async {
//   if (signingIn) return;
//   signingIn = true;

//   try {
//     if (kIsWeb) {
//       // Web ke liye Facebook login
//       FacebookAuthProvider facebookProvider = FacebookAuthProvider();
//       await _auth.signInWithPopup(facebookProvider);
//     } else {
//       // Mobile ke liye
//       final LoginResult result = await FacebookAuth.instance.login();
//       if (result.status == LoginStatus.success) {
//         final OAuthCredential credential =
//             FacebookAuthProvider.credential(result.accessToken!.token);
//         await _auth.signInWithCredential(credential);
//         Get.snackbar("Success", "Logged in with Facebook");
//         Get.offAllNamed('/bottombar');
//       } else {
//         Get.snackbar("Error", result.message ?? "Facebook login failed");
//       }
//     }
//   } catch (e) {
//     Get.snackbar("Error", e.toString());
//   } finally {
//     signingIn = false;
//   }
// }

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



 Future signup(
    _formkey,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    if (_formkey.currentState!.validate()) {
      try {
        isLoading.value = true;

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        SnackbarUtil.showSuccess('Your account created successfully');
        Get.offAllNamed('/bottombar');
        // Get.off(Homescreen());
        isLoading.value = false;
      } catch (e) {
        SnackbarUtil.showError(e.toString());
        isLoading.value = false;
      }
    }
  }

  Future login(_formKay, TextEditingController emailController,
      TextEditingController passwordController) async {
    if (_formKay.currentState!.validate()) {
      try {
        isLoading.value = true;

        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

         Get.offAllNamed('/bottombar');
        isLoading.value = false;
      } catch (e) {
        SnackbarUtil.showError(e.toString());
        isLoading.value = false;
      }
    }
  }










}





