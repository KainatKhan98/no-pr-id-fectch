import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet/data/repositories/user_repository.dart';
import 'package:pet/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:pet/features/authentication/screens/signup/verify_email.dart';
import 'package:pet/features/authentication/screens/welcome/welcome.dart';
import 'package:pet/features/home/navigation_menu.dart';
import '../../features/provider/screen/home/provider_navigation_menu.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? user;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Show Relevant Screen
  // screenRedirect() async {
  //   final user = _auth.currentUser;
  //
  //   if(user != null) {
  //     // If user is logged in
  //     if(user.emailVerified) {
  //       // If verified
  //       Get.offAll(() => const NavigationMenu());
  //     } else {
  //       // Not verified
  //       Get.offAll(() => VerifyEmail(email: _auth.currentUser?.email,));
  //     }
  //   } else {
  //     // Local Storage
  //     deviceStorage.writeIfNull('isFirstTime', true);
  //     deviceStorage.read('isFirstTime') != true ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(const OnboardingScreen());
  //   }
  // }

  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      // Retrieve the role from local storage
      String? role = GetStorage().read('userRole');  // Reading the saved role

      // Navigate based on role
      if (role == 'provider') {
        Get.offAll(() => const ProviderNavigationMenu());
      } else if (role == 'pet_parent') {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.snackbar("Error", "Unknown role. Please contact support.");
      }
    } else if (user != null) {
      // If email not verified, redirect to email verification
      Get.offAll(() => VerifyEmail(email: user.email));
    } else {
      // If user is not logged in, show Role Selection screen
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(const OnboardingScreen());
    }
  }



  ///---------------------------------------- Signin ___________________________________________________

  // Login User
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Register User
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Re Authenticate User
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // Re Authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }



  ///---------------------------------------- Social ___________________________________________________

  // Google
  // Future<UserCredential> signInWithGoogle() async {
  //   try {
  //     // trigger the authentication flow
  //     final GoogleSignInAccount? userAccount =  await GoogleSignIn().signIn();
  //
  //     // Obtain the authentication details
  //     final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
  //
  //     // Create credentials
  //     final credentials = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     // Once signed in, return the user credentials
  //     return await _auth.signInWithCredential(credentials);
  //
  //   } on FirebaseAuthException catch (e) {
  //     throw MyFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw MyFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const MyFormatException();
  //   } on PlatformException catch (e) {
  //     throw MyPlatformException(e.code).message;
  //   } catch (e) {
  //     throw "Something went wrong. Please try again";
  //   }
  // }


  // Facebook
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  ///---------------------------------------- Log out ___________________________________________________

  // Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Delete User
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance. removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}


