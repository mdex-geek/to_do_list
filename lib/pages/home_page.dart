import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/dataBase/database.dart';
import 'package:to_do_list/util/dailog_box.dart';
import 'package:to_do_list/util/list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List toDoList = [
    ["make tutorial", false],
    ["Do exercise", false],
  ];

  @override
  void initState() {
    super.initState();

    //if this is the 1st time ever opening the app  ,then create default data

    // if (_myBox.get("TODOLIST") == null) {
    //   db.createInitialData();
    // } else {
    //there already exists data
    db.loadData();
    // }
  }

  //reference the hive box
  final _myBox = Hive.box('Box');
  //text controller
  final _controller = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  // checkBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([
        _controller.text,
        false
      ]); //what ever we writing that box goes to list
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create a new task
  void createNewTask() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //reorder list order
  void updateMyTile(int oldIndex, int newIndex) {

    /*
    this is adjustment for if we drag ever tile from up to down
    to maintain the index of a List(array)
    we need to do minus -1
    eg. first tile that i have to drag is on 0 index and
    i want put last and i have 5 item and
     it means i have 4 index in a List to drag down to go on 4th index
     i have to -1 so
     the left one can go up and it will we on correct index

     and prevent us from index error
     (Not in inclusive range 0..2: 3)
     */
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      final tile = db.toDoList.removeAt(oldIndex); // Update db.toDoList directly
      db.toDoList.insert(newIndex, tile);
      db.updateDataBase(); // Save changes to database
    });
  }

  //delete task
  void deleteTask(index) {
    setState(
      () {
        db.toDoList.removeAt(index);
      },
    );
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TO DO List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,

      body: ReorderableListView.builder(
        //and reorder list
        //using this for get item like list and get scroll
        itemCount: db
            .toDoList.length, //fixed the syntax error by removing the semicolon
        itemBuilder: (context, index) {
           return ToDoTile(
            key: ValueKey(index),
            //we have to provide key
            //important for to keep track of where every thing is  the order the children around
            title: db.toDoList[index][0],
            taskComplete: db.toDoList[index][1],
            onChanged: (p0) => checkBoxChanged(p0, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
        onReorder: updateMyTile,
        // buildDefaultDragHandles: false,
      ),

      //button
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        tooltip: 'add task',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }


}
