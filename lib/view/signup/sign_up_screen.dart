import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';
import '../../res/color.dart';
import '../../res/component/input_text_field.dart';
import '../../res/component/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final userNameFocusNode = FocusNode();

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
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) => signUpController(),
            child: Consumer<signUpController>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const Text(
                        "TripTales",
                        style: TextStyle(
                            fontSize: 70,
                            fontFamily: 'Cursive',
                            color: AppColors.primaryColor),
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height * .01),
                          child: Column(
                            children: [
                              InputTextField(
                                myController: usernameController,
                                focusNode: userNameFocusNode,
                                onFiledSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'Enter Username'
                                      : null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hint: "Username",
                                obsecureText: false,
                                enable: true,
                              ),
                              InputTextField(
                                myController: emailController,
                                focusNode: emailFocusNode,
                                onFiledSubmittedValue: (value) {
                                  Utils.fieldFocus(context, emailFocusNode,
                                      passwordFocusNode);
                                },
                                onValidator: (value) {
                                  return value.isEmpty ? 'Enter Email' : null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hint: "Email Address",
                                obsecureText: false,
                                enable: true,
                              ),
                              InputTextField(
                                myController: passwordController,
                                focusNode: passwordFocusNode,
                                onFiledSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'Enter Password '
                                      : null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hint: "Password",
                                obsecureText: true,
                                enable: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      RoundButton(
                        title: "Sign Up",
                        loading: provider.loading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.signup(context, usernameController.text,
                                emailController.text, passwordController.text);
                          }
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Already Have an Account? ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 15),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
