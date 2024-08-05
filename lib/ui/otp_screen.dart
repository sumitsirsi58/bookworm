import 'package:bookworm/provider/auth_provider.dart';
import 'package:firebase_flutter/auth/provider/auth_provider.dart';
import 'package:firebase_flutter/util/custom_loader.dart';
import 'package:firebase_flutter/util/custome_button.dart';
import 'package:firebase_flutter/util/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  final String verificationId;
  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return CustomLoader(
            showLoader: authProvider.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Verify Phone',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Code is sent to ${widget.phoneNumber}"),
                    const SizedBox(height: 16),
                    FocusScope(
                      node: FocusScopeNode(),
                      child: OtpWidget(
                        otpController: otpController,
                        focusNode: otpFocusNode,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        otpController.clear();
                        authProvider.login(
                          widget.phoneNumber,
                          resend: true,
                        );
                      },
                      child: const Text(
                        'Didn’t receive the code? Request Again',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      onPressed: () {
                        String otp = otpController.text;
                        if (otp.length == 6) {
                          authProvider.verifyOTP(
                            otp: otp,
                            verificationId: widget.verificationId,
                          );
                        }
                      },
                      name: 'VERIFY AND CONTINUE',
                      buttonColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}