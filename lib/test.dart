import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_list/sqldb.dart';

class Testapp extends StatefulWidget {
  const Testapp({Key? key}) : super(key: key);

  @override
  State<Testapp> createState() => _TestappState();
}
dbtasks db=dbtasks();
class _TestappState extends State<Testapp> {
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Center(child: ElevatedButton(onPressed: () async{
    //  await  db.insertTasks();
      //  await db.readTasks();
       // insertTasks();
      }, child: Text("Add")),)),
    );
  }
}