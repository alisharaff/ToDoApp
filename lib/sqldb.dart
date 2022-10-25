

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbtasks{
  late Database db;
  List<Map> tasks =[];
init() async{
  
  String dbPath =await getDatabasesPath();
  
  String dbName ="tasks.db";
  
  String newdbPath =join(dbPath,dbName);
 
 
 db=await openDatabase(newdbPath,version: 1,onCreate: ((db, version) {
    db.execute('CREATE TABLE mytasks(id INTEGER PRIMARY KEY autoincrement,title TEXT,date TEXT, time TEXT, status TEXT)');
    print("Create DATABASE AND TABLE**********************");
 }),
 onOpen: ((db) {
  //  getDataFromDatabase(db).then(((value) {
  //    tasks= value;
  //  }));
 }));


 }
 Future<List<Map>> getDataFromDatabase(db)async{
   await init();
   return  await db.rawQuery('SELECT * FROM mytasks');
   
  
  }
insertTasks({String? title,String? date,String? time,String? status,})async{
   //int id ,String title,String date,String time,String status
   await init();
   await db.insert("mytasks", {"title":title,"date":date,"time":time,"status":status});
   print("insert Done");
  }
}




























//  import "package:path/path.dart";
// // import "package:sqflite/sqflite.dart";

// // void dbtasks() {
// //   Sqldb();
// //   print('done');
// // }

// // class Sqldb {
// //   static Database? _db;
// //   Future<Database?> get db async {
// //     if (_db == null) {
// //       _db = await intialdb();
// //       return _db;
// //     } else {
// //       return _db;
// //     }
// //   }

// //   intialdb() async {
// //     String databasepath = await getDatabasesPath();
// //     String path = join(databasepath, 'task.db');
// //     Database mydb = await openDatabase(path, onCreate: _onCreate);
// //     return mydb;
// //   }

// //   _onCreate(Database db, int version) async {
// //     await db.execute(
// //         '''CREATE TABLE "task"(id INTEGER PRIMARY KEY,title TEXT, date TEXT, time TEXT, status TEXT)''');
// //     print("Create DATABASE AND TABLE**********************");
// //   }
// // }






// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// Future MyDataBase() async{
//    var db = await openDatabase('my_db.db');
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'demo.db');
//     Database database = await openDatabase(path, version: 1,
//     onCreate: (Database db, int version) async {
//   // When creating the db, create the table
//   await db.execute(
//       'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
// }).then((value) {
//     print('created db');
//     return value;
// });

// }
