import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/view_model/services/session_manager.dart';
import '../../res/color.dart';
import '../../utils/utils.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }
  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.camera,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.image,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            ),
          );
        },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
        .ref('/profilePic' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref
        .child(SessionController().userId.toString())
        .update({'profilePic': newUrl.toString()})
        .then((value) => {
              Utils.toastMessage('Profile Picture Updated'),
              setLoading(false),
              _image = null,
            })
        .onError((error, stackTrace) => {
              Utils.toastMessage(error.toString()),
              setLoading(false),
            });
  }

  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    nameController.text = name;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Update Username")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                    myController: nameController,
                    focusNode: nameFocusNode,
                    onFiledSubmittedValue: (value) {},
                    onValidator: (value) {},
                    keyBoardType: TextInputType.name,
                    hint: "Enter Username",
                    obsecureText: false,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancle", style: TextStyle(color: AppColors.alertColor),)),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'username': nameController.text.toString(),
                    }).then((value) => nameController.clear());
                    Navigator.pop(context);
                  },
                  child: Text("OK", style: TextStyle(color: AppColors.primaryColor),)),
            ],
          );
        });
  }

  Future<void> showPasswordDialogAlert(BuildContext context, String phone) {
    phoneController.text = phone;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Update Phone")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                    myController: phoneController,
                    focusNode: phoneFocusNode,
                    onFiledSubmittedValue: (value) {},
                    onValidator: (value) {},
                    keyBoardType: TextInputType.phone,
                    hint: "Enter Phone",
                    obsecureText: false,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancle", style: TextStyle(color: AppColors.alertColor),)),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'phone': phoneController.text.toString(),
                    }).then((value) => phoneController.clear());
                    Navigator.pop(context);
                  },
                  child: Text("OK", style: TextStyle(color: AppColors.primaryColor),)),
            ],
          );
        });
  }
}
