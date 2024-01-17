import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'package:todolist/controller/todoList_controller.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/dialog_view.dart';

TextEditingController taskController = TextEditingController();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //ref the box
  final _myBox = Hive.box("mybox");

  TodoDatabase db = TodoDatabase();

  void createNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox();
      },
    );
    
  }

  @override
  void initState() {
   Provider.of<todoListController>(context, listen: false).loadingData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: const Center(child: Text("ToDO")),
      ),
      body: Consumer<todoListController>(
        builder: (context, value, child) => Column(

          children: [
           
            
            Expanded(
              child: ListView.separated(
                itemCount: value.todoList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          value.deleteTask(index, context);
                         
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                      )
                    ]),
                    child: toDotileWidget(
                        taskName: value.todoList[index][0],
                        taskCompleted: value.todoList[index][1],
                        onChanged: (value1) =>
                            value.getcheckBoxOnchanged(value1!, index)),
                  );
                },
              ),
            ),
            
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: createNewTask,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class toDotileWidget extends StatelessWidget {
  const toDotileWidget({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.onChanged,
  });
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.purple[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              taskName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            Checkbox(value: taskCompleted, onChanged: onChanged)
          ],
        ),
      ),
    );
  }
}
