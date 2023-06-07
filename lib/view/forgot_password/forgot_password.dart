import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import '../../view_model/Forgot_password/forgot_password_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recover your Account"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                const Text(
                  "Please enter your email address",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * .01),
                    child: Column(
                      children: [
                        InputTextField(
                          myController: emailController,
                          focusNode: emailFocusNode,
                          onFiledSubmittedValue: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? 'Enter Email ' : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: "Email address",
                          obsecureText: false,
                          enable: true,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ChangeNotifierProvider(
                  create: (_) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child) {
                    return RoundButton(
                      title: "Recover Password",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.forgotPassword(
                              context, emailController.text);
                        }
                      },
                      loading: provider.loading,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
