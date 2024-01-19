import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //refernce the box
  final _myBox = Hive.box('Box');

  //run this method if this is the 1st time ever opening this app
  // void createInitialData() {

  // }

  //load the data from the database

  void loadData() {
    var data = _myBox.get("TODOLIST");
    if (data != null) {
      toDoList = data;
    } else {
      toDoList = []; // Initialize with an empty list if data is null
    }
  }


  //update the dataBase
  void updateDataBase() {
    _myBox.put(
      "TODOLIST",
      toDoList,
    );
  }
}
