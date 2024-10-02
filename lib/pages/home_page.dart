import 'package:flutter/material.dart';
import 'package:dub/utils/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();

  List taskList = [];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      taskList[index][1] = !taskList[index][1];
    });
  }

  void deleteTask(String task, int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext context, index) {
          // Return a widget here
          return TaskList(
            task: taskList[index][0],
            taskCompleted: taskList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            onDelete: (value) => deleteTask(value, index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  hintText: 'Add a new task',
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
            setState(() {
              taskList.add([_taskController.text, false]);
              _taskController.clear();
            });
          },
         child: const Icon(Icons.add),
        ),
        ],
      ),
    );
  }
}
