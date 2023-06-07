import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../../res/color.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List",style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            if(SessionController().userId.toString()==snapshot.child('uid').value.toString()){
              return Container();
            }else{
              return Card(
                child: ListTile(

                  leading: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.primaryIconColor
                        )
                    ),
                    child: snapshot.child('profilePic').value.toString() == ""
                        ? Icon(Icons.person)
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          snapshot.child('profilePic').value.toString(),
                        ),
                      ),
                    ),
                  ),
                  title: Text(snapshot.child('username').value.toString()),
                  subtitle: Text(snapshot.child('email').value.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
