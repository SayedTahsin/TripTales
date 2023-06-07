import 'package:flutter/material.dart';
import 'package:tech_media/DpHelper/MongoModel.dart';
import 'package:tech_media/DpHelper/mongoDb.dart';

import '../../../res/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TripTales",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cursive',
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data.length;
              print("total Data" + totalData.toString());
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return displayCard(
                        MongoDbModel.fromJson(snapshot.data[index]));
                  });
            } else {
              return Center(
                child: Text("No Post to show"),
              );
            }
          }
        },
      ),
    );
  }
}

Widget displayCard(MongoDbModel data) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${data.name}",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${data.date}",
                style: TextStyle(fontSize: 15, color: Colors.deepPurpleAccent),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${data.caption}",
                  style: TextStyle(fontSize: 20,fontFamily: "SF-Pro-Display-Light"),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.favorite,color: Colors.red),
                  ),
                  Text(
                    "${data.likes}",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    ),
  );
}
