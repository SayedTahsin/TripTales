import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/view/dashboard/chat/chat.dart';
import 'package:tech_media/view/dashboard/home/home.dart';
import 'package:tech_media/view/dashboard/post/posting.dart';
import 'package:tech_media/view/dashboard/profile/profile.dart';
import 'package:tech_media/view/dashboard/user/user_list_screen.dart';
import '../../res/color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      HomeScreen(),
      ChatScreen(),
      AddPost(),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
          color: Colors.black,
        ),
        inactiveIcon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.chat,
          color: Colors.black,
        ),
        inactiveIcon:const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        inactiveIcon: const  Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.groups_2_sharp,
          color: Colors.black,
        ),
        inactiveIcon: const Icon(
          Icons.groups_2_sharp,
          color: Colors.white,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        inactiveIcon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      controller: controller,
      backgroundColor: AppColors.primaryColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
