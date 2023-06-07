import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view/dashboard/dashboard_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class signUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signup(BuildContext context, String username, String email, String password) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          SessionController().userId=value.user!.uid.toString();
          ref.child(value.user!.uid.toString()).set(
            {
              'uid': value.user!.uid.toString(),
              'email': value.user!.email.toString(),
              'username': username,
              'phone': '',
              'onlineStatus': "noOne",
              'profilePic': "",
            },
          ).then(
            (value) {
              setLoading(false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );

            },
          ).onError(
            (error, stackTrace) {
              setLoading(false);
              Utils.toastMessage(error.toString());
            },
          );
        },
      ).onError(
        (error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        },
      );
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
