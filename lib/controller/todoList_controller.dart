import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/database/database.dart';

class todoListController extends ChangeNotifier {
  // List todoList = [
  //   // ['Make Early Wakeup', false],
  //   // ['Do exercise', false]
  // ];
  //ref the box
  final _myBox = Hive.box("mybox");
  TodoDatabase db=TodoDatabase();
List<dynamic> get todoList => db.todoList;
 void loadingData(){
  if(_myBox.get("TODOLIST")==null){
    db.createinitialData();
    
  }else{
    db.loadData();
  }
 }

  void getcheckBoxOnchanged(bool value, int index) {
  db.todoList[index][1] = ! db.todoList[index][1];
  print("_____________________${db.todoList[index][1]}");
   db.updateDatabase();
    notifyListeners();

     
  }

  void createTask(String controller,bool value ){
   db.todoList.add([controller,value]);
   print(db.todoList);
      db.updateDatabase();
    notifyListeners();

     

  }
  deleteTask(int index,BuildContext context){
   db.todoList.removeAt(index);
     db.updateDatabase();
    notifyListeners();
  
  }

   
}
