import 'package:bookworm/core/custom_button.dart';
import 'package:bookworm/core/custtom_loadder.dart';
import 'package:bookworm/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Consumer<AuthenticationProvider>(
          builder: (context, authProvider, child) {
            return CustomLoader(
              showLoader: authProvider.isLoading,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Please enter your mobile number",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "You’ll receive a 6 digit code",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        " to verify next.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/image/india 2.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '91',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 20,
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        name: 'CONTINUE',
                        onPressed: () {
                          login(context);
                        },
                        buttonColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      String phoneNumber = phoneController.text;
      phoneNumber = '+91$phoneNumber';
      final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
      authProvider.login(phoneNumber);
    }
  }
}
