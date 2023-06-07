import 'package:flutter/material.dart';

import '../color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.onValidator,
    required this.keyBoardType,
    required this.hint,
    required this.obsecureText,
    this.enable = true,
    this.autoFocus = false,
    this.maxline=1,
  }) : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final String hint;
  final int maxline;
  final bool obsecureText, enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obsecureText,
        onFieldSubmitted: onFiledSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        cursorColor: AppColors.primaryColor,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(height: .5, fontSize: 22),
        decoration: InputDecoration(
          hintText: hint,
          enabled: enable,
          contentPadding: const EdgeInsets.all(20),
          hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              height: 0,
              color: AppColors.primaryTextTextColor.withOpacity(0.5),
            fontSize: 15,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
