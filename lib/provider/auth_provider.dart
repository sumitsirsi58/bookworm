import 'package:bookworm/core/storage_helper.dart';
import 'package:bookworm/ui/home_screen.dart';
import 'package:bookworm/ui/login_screen.dart';
import 'package:bookworm/ui/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoading = false;
  final StorageHelper storageHelper;
  bool isLoggedIn = false;
  int? resendToken;

  AuthenticationProvider(this.storageHelper);

  Future login(String phoneNumber, {bool resend = false}) async {
    try {
      showLoader();
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {
            hideLoader();
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Verification Failed', e.message.toString());
            hideLoader();
          },
          codeSent: (String verificationId, int? resendToken) {
            this.resendToken = resendToken;
            hideLoader();
            if (!resend) {
              Get.to(OTPScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ));
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            hideLoader();
          },
          forceResendingToken: resend ? resendToken : null);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString());
      hideLoader();
    }
  }

  void hideLoader() {
    isLoading = false;
    notifyListeners();
  }

  Future verifyOTP({
    required String otp,
    required String verificationId,
  }) async {
    try {
      showLoader();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      UserCredential cred =
      await FirebaseAuth.instance.signInWithCredential(credential);
      String? uid = cred.user?.uid;
      if (uid != null) {
        storageHelper.saveUserId(uid);
      }
      hideLoader();

      Get.offAll(const HomeScreen());
    } on FirebaseAuthException catch (e) {
      hideLoader();
      Get.snackbar('Error', e.message.toString());
    }
  }

  Future loadLoggedStatus() async {
    showLoader();
    String? uid = await storageHelper.getUserId();
    isLoggedIn = uid != null;
    hideLoader();
  }

  void showLoader() {
    isLoading = true;
    notifyListeners();
  }

  Future logout() async {
    await storageHelper.clearUserId();
    Get.off(LoginScreen());
  }
}