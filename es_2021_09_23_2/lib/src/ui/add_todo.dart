import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/src/database/app_database.dart';
import 'package:todolist/src/model/todo.dart';
import 'package:todolist/src/ui/home_page.dart';

class AddTodo extends StatefulWidget {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  State<StatefulWidget> createState() => _addTodoData();
}

class _addTodoData extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add TODO'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _, __) => MyHomePage(),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            margin: EdgeInsets.all(10),
            child: TextField(
              maxLines: 5,
              controller: widget._textEditingController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    "Add".toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  onPressed: () => _saveCall(),
                ),
                TextButton(
                  child: Text(
                    "Generate Bulk 100 Record".toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  onPressed: () => _saveBunkCall(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _saveCall() {
    final database =
        $FloorAppDatabase.databaseBuilder('tododatabase.db').build();
    database.then((onValu) {
      onValu.todoDao.getMaxTodo().then((onValue) {
        int id = 1;
        if (onValue != null) {
          id = onValue.id + 1;
        }

        if (widget._textEditingController.value.text != '') {
          onValu.todoDao.insertTodo(
            Todo(
              id,
              widget._textEditingController.value.text,
              DateFormat('dd-mm-yyyy kk:mm').format(
                DateTime.now(),
              ),
              "",
            ),
          );
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _, __) => MyHomePage(),
            ),
          );
        }
      });
    });
  }

  _saveBunkCall() {
    final database =
        $FloorAppDatabase.databaseBuilder('tododatabase.db').build();
    database.then((onValu) {
      onValu.todoDao.getMaxTodo().then((onValue) {
        int id = 1;
        if (onValue != null) {
          id = onValue.id + 1;
        }
        List<Todo> listBunkData = [];
        for (int i = id; i < id + 100; i++) {
          listBunkData.add(
            Todo(
              i,
              i.toString(),
              DateFormat('dd-mm-yyyy kk:mm').format(
                DateTime.now(),
              ),
              "",
            ),
          );
        }
        onValu.todoDao.insertAllTodo(listBunkData);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => MyHomePage(),
          ),
        );
      });
    });
  }
}
