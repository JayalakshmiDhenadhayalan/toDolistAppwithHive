import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  //ref the box
  final _myBox = Hive.box("mybox");

  ///initial value
  void createinitialData() {
    todoList = [
      ['Make Early Wakeup', false],
      ['Do exercise', false]
    ];
  }

  //load the data
  void loadData() {
    todoList = _myBox.get("TODOLIST");
    print("object_____");
  }

  //update the dfata
  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
