import 'package:flutter/material.dart';

void main() => runApp(const DubApp());

class DubApp extends StatelessWidget {
  const DubApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DubListPage(),
    );
  }
}

class DubItem {
  String title;
  bool isCompleted;

  DubItem({required this.title, this.isCompleted = false});
}

class DubListPage extends StatefulWidget {
  const DubListPage({super.key});
  @override
  DubListPageState createState() => DubListPageState();
}

class DubListPageState extends State<DubListPage> {
  final List<DubItem> _dubItems = [];
  final TextEditingController _controller = TextEditingController();

  void _addDubItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _dubItems.add(DubItem(title: task));
      });
      _controller.clear();
    }
  }

  void _toggleDubItemCompletion(int index) {
    setState(() {
      _dubItems[index].isCompleted = !_dubItems[index].isCompleted;
    });
  }

  void _deleteDubItem(int index) {
    setState(() {
      _dubItems.removeAt(index);
    });
  }

  void _showAddDubDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Appointment'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter task here',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addDubItem(_controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Day'),
      ),
      body: ListView.builder(
        itemCount: _dubItems.length,
        itemBuilder: (context, index) {
          final item = _dubItems[index];
          return ListTile(
            title: Text(
              item.title,
              style: TextStyle(
                decoration: item.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: item.isCompleted,
              onChanged: (bool? value) {
                _toggleDubItemCompletion(index);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteDubItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDubDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

