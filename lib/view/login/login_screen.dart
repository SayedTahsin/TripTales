import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/view_model/login/login_controller.dart';
import '../../utils/routes/route_name.dart';
import '../forgot_password/forgot_password.dart';
import '../signup/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.2,
                ),
                const Text(
                  "TripTales",
                  style: TextStyle(
                      fontSize: 70,
                      fontFamily: 'Cursive',
                      color: AppColors.primaryColor),
                ),
                SizedBox(
                  height: height * 0.05,
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
                            return value.isEmpty ? 'Enter your email' : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: "Email address",
                          obsecureText: false,
                          enable: true,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        InputTextField(
                          myController: passwordController,
                          focusNode: passwordFocusNode,
                          onFiledSubmittedValue: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? 'Enter your password' : null;
                          },
                          keyBoardType: TextInputType.visiblePassword,
                          hint: "Password",
                          obsecureText: true,
                          enable: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        title: "Login",
                        onPress: () {
                          setState(() {

                          });
                          if (_formKey.currentState!.validate()) {
                            provider.login(context, emailController.text,
                                passwordController.text);
                          }
                        },
                        loading: provider.loading,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account?  ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
