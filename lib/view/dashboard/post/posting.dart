import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/component/round_button.dart';
import '../../../DpHelper/mongoDb.dart';
import '../../../res/color.dart';
import  'package:intl/intl.dart';

import '../profile/profile.dart';

String? name;
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  set Postsername(String s) {
    name=s;
  }
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final captionController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? Postsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Blog",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: captionController,
                maxLines: null,
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  focusColor: AppColors.primaryColor,
                  hintText: 'Write Your Blog Here',
                ),
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(15),
              child: RoundButton(
                  title: "Post",
                  onPress: () {
                    String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
                    MongoDatabase().insertDate(name!, date, captionController.text.toString());
                    captionController.text="";
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class PostingController with ChangeNotifier {
  final captionController = TextEditingController();

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
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
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
                  title: const Text("Camera"),
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
                  title: const Text("Gallery"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) {
    setLoading(true);
  }
}
