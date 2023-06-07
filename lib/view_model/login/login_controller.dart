



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view/dashboard/dashboard_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class LoginController with ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
              SessionController().userId=value.user!.uid.toString();
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
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }


}

