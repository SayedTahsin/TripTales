import 'package:flutter/material.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;
  const RoundButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontSize: 20, color: textColor),
              )),
      ),
    );
  }
}
