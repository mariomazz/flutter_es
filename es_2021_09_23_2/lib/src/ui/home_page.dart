import 'package:flutter/material.dart';
import 'package:todolist/src/dao/todo_dao.dart';
import 'package:todolist/src/database/app_database.dart';
import 'package:todolist/src/model/todo.dart';

import 'add_todo.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  bool ckValue = false;
  TodoDao _todoDao;
  List<Todo> todoList = [];
  List<bool> cbList = [];

  final database = $FloorAppDatabase.databaseBuilder('tododatabase.db').build();

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('TODO APP'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              List<Todo> listSelectedDat = widget.todoList
                  .where((test) => test.isSelect == true)
                  .toList();
              widget._todoDao.deleteAll(listSelectedDat).then((onValue) {
                debugPrint('deleted values :${onValue}');
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          FutureBuilder<TodoDao>(
              future: _calltheStream(),
              builder: (BuildContext context, AsyncSnapshot<TodoDao> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return StreamBuilder<List<Todo>>(
                      stream: snapshot.data.fetchStreamData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.connectionState == ConnectionState.none) {
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (widget.todoList.length != snapshot.data.length) {
                            widget.todoList = snapshot.data;
                          }

                          if (snapshot.data.length == 0) {
                            return Center(
                              child: Text('nessun dato trovato',
                                  style: TextStyle(
                                    fontSize: 25,
                                  )),
                            );
                          }

                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                      child: ListTile(
                                    leading: Checkbox(
                                      value: widget.todoList[index].isSelect,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.todoList[index].isSelect =
                                              value;
                                        });
                                      },
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        _selectedDetele(
                                            snapshot.data[index].id);
                                      },
                                      child: Icon(Icons.delete),
                                    ),
                                    title: Text(
                                      '${snapshot.data[index].task}',
                                      maxLines: 1,
                                    ),
                                    subtitle: Text(
                                      '${snapshot.data[index].time}',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ));
                                }),
                          );
                        }
                      });
                }
              }),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _openAddScreen(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  _openAddScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => AddTodo(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final database =
        $FloorAppDatabase.databaseBuilder('tododatabase.db').build();
    database.then((onValueP) {
      setState(() {
        widget._todoDao = onValueP.todoDao;
      });
    });
  }

  Future<TodoDao> _calltheStream() async {
    AppDatabase appDatabase = await widget.database;
    widget._todoDao = appDatabase.todoDao;
    return appDatabase.todoDao;
  }

  void _selectedDetele(int id) {
    widget._todoDao.deleteTodo(id);
    setState(() {});
  }
}
