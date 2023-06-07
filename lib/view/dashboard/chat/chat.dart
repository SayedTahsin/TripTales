



import 'package:flutter/material.dart';

import '../../../res/color.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(child: Text("Coming Soon...",style: TextStyle(fontSize: 40),)),
    );
  }
}
