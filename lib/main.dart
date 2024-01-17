import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controller/todoList_controller.dart';
import 'package:todolist/homeview.dart';

void main()async{
  //init the hive
  await Hive.initFlutter();
  ///open the box
 var box= await Hive.openBox("mybox");


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => todoListController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDO',
        theme: ThemeData(
       
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}



