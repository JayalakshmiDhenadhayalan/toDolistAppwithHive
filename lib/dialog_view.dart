import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controller/todoList_controller.dart';

TextEditingController taskController = TextEditingController();

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<todoListController>(
      builder: (context, value, child) => AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(hintText: "Enter text"),
              ),
              Row(
                children: [
                  InkWell(onTap: () {
                    value.createTask(taskController.text, false);
                     Navigator.pop(context);
                     taskController.clear();
                  }, child: Chip(label: Text("Save"))),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    
                    child: Chip(label: Text("Cancel")))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
