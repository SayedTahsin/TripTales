import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/DpHelper/mongoDb.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';

void main() async {
  //For Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripTales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 25,fontFamily: AppFonts.sfProDisplayMedium, color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w600)
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 40,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w500,height: 1.6),
          headline2: TextStyle(fontSize: 32,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w500,height: 1.6),
          headline3: TextStyle(fontSize: 28,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w500,height: 1.6),
          headline4: TextStyle(fontSize: 24,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w500,height: 1.6),
          headline5: TextStyle(fontSize: 20,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w500,height: 1.6),
          headline6: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w700,height: 1.6),

          bodyText1: TextStyle(fontSize: 15,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor, fontWeight: FontWeight.w700,height: 1.6),
          bodyText2: TextStyle(fontSize: 12,fontFamily: AppFonts.sfProDisplayRegular,color: AppColors.primaryTextTextColor, height: 1.6),
          caption: TextStyle(fontSize: 10,fontFamily: AppFonts.sfProDisplayRegular,color: AppColors.primaryTextTextColor, height: 2.26),
        )
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,//For generating routes from RouteName class
    );
  }
}

