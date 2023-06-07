import 'dart:developer';
import 'dart:math';
import 'package:tech_media/DpHelper/MongoModel.dart';
import 'package:tech_media/DpHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tech_media/utils/utils.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    print(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<void> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSucces) {
        Utils.toastMessage("Successfully Posted");
      } else {
        Utils.toastMessage("Posting Failed");
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  Future<void> insertDate(String name, String Date, String caption) async {
    final data = MongoDbModel(
        name: name, date: Date, caption: caption, likes: Random().nextInt(100));
    var result = await MongoDatabase.insert(data);
  }
}
