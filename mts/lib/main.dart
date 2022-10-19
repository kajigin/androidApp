import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// リスト一覧画面用Widgetclass TodoListPage extends StatefulWidget {
class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            //キャンセルするとnewListTextがnullになる
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//リスト追加画面用widget
class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('リスト追加'),
        ),
        body: Container(
          padding: EdgeInsets.all(64), //余白調整
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text, style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _text = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity, //横幅いっぱい
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    //popでまえの画面に戻る
                    //popの引数から前の画面にデータを渡す
                    Navigator.of(context).pop(_text);
                  },
                  child: Text('リスト追加'),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('キャンセル'),
                ),
              )
            ],
          ),
        ));
  }
}
