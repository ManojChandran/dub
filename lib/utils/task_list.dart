import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.task, required this.taskCompleted, required this.onChanged, required this.onDelete});

  final String task;
  final bool taskCompleted;
  final Function(bool?) onChanged;
  final Function(String) onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onDelete(task),
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.white,
            ),
          ],
        ),
        child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(
              value: taskCompleted, 
              onChanged: onChanged, 
              checkColor: Colors.black, 
              activeColor: Colors.white, 
              side: const BorderSide(color: Colors.white),
              ),
            Text(
              task,
              style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: taskCompleted ? TextDecoration.lineThrough : null,
              decorationColor: Colors.white,
              decorationThickness: 2,
            ),
          ),
        ],
      ),
      ),
      ),
    );
  }
}