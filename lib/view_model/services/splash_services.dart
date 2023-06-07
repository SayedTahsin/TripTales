import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SplashServices{
  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user=auth.currentUser; //getting current user from firebase
    if(user!=null){ //!if loggedIn goto dashboard
      SessionController().userId=user.uid.toString(); // assigning user to singleTone class for storing a session
      Timer(Duration(seconds: 5),()=> Navigator.pushNamed(context, RouteName.dashboardScreen));
    }else{
      Timer(Duration(seconds: 5),()=> Navigator.pushNamed(context, RouteName.loginView));
    }
  }
}