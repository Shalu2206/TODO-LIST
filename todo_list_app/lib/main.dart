import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<String> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoList.add(task);
      });
      _textController.clear();
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('To-Do List App'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: TextStyle(
                      color: Colors.pinkAccent, // Change the text color
                      fontSize: 18, // Change the font size
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter an item',
                      hintStyle: TextStyle(
                        color: Colors.grey, // Change the hint text color
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent, // Change the border color when enabled
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent, // Change the border color when focused
                        ),
                      ),
                    ),
                    cursorColor: Colors.pinkAccent, // Change the cursor color
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () => _addTodoItem(_textController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Change button color
                  ),
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: ListTile(
                    title: Text(_todoList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmationDialog(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
