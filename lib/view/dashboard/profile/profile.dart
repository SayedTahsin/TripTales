import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';
import '../../../res/color.dart';
import '../../../res/component/round_button.dart';
import '../../../utils/utils.dart';
import '../post/posting.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
  void setName(String s){
    AddPost().Postsername=s;
  }

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Profile View", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: StreamBuilder(
                    stream: ref
                        .child(SessionController().userId.toString())
                        .onValue,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        Map<dynamic, dynamic> map =
                            snapshot.data.snapshot.value;
                        setName(map['username']);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Container(
                                      height: 250,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.primaryColorDeep,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        child: provider.image == null
                                            ? map['profilePic'].toString() == ""
                                                ? const Icon(Icons.person,
                                                    size: 200)
                                                : Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        map['profilePic']
                                                            .toString()),
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    errorBuilder: (context,
                                                        object, stack) {
                                                      return const Icon(
                                                        Icons.error_outline,
                                                        color: AppColors
                                                            .alertColor,
                                                      );
                                                    },
                                                  )
                                            : Stack(
                                                children: [
                                                  Image.file(
                                                      File(provider.image!.path)
                                                          .absolute),
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.pickImage(context);
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.secondaryColor,
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                provider.showUserNameDialogAlert(
                                    context, map['username']);
                              },
                              child: ReuseableRow(
                                  title: 'Username',
                                  value: map['username'],
                                  iconData: Icons.person),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                provider.showPasswordDialogAlert(
                                    context, map['phone']);
                              },
                              child: ReuseableRow(
                                  title: 'Phone',
                                  value: map['phone'] == ''
                                      ? 'Not-Provided'
                                      : map['phone'],
                                  iconData: Icons.phone),
                            ),
                            const SizedBox(height: 10),
                            ReuseableRow(
                                title: 'Email',
                                value: map['email'],
                                iconData: Icons.email_outlined),
                            const SizedBox(height: 50),
                            RoundButton(
                              title: "Logout",
                              onPress: () {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                auth.signOut().then((value) {
                                  SessionController().userId = '';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                }).onError((error, stackTrace) {
                                  Utils.toastMessage(error.toString());
                                });
                              },
                              loading: provider.loading,
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Something went wrong",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReuseableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12),
          ),
          leading: Icon(
            iconData,
            color: AppColors.primaryColorDeep,
          ),
          trailing: Text(
            value,
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
