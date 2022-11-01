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

// リスト一覧画面用
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
          var item = todoList[index];
          return Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              //右にスライド
              motion: const StretchMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    print('a');
                  },
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: '編集',
                ),
              ],
            ),
            endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.3,
                dismissible: DismissiblePane(
                  //左にスライド
                  onDismissed: () {
                    setState(() {
                      todoList.removeAt(index); //スライドしたCARDを削除
                    });
                    ScaffoldMessenger.of(context) //削除した後に画面下部にテキストを出す
                        .showSnackBar(const SnackBar(content: Text('削除しました')));
                  },
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        todoList.removeAt(index); //スライドしたCARDを削除
                      });
                      ScaffoldMessenger.of(context) //削除した後に画面下部にテキストを出す
                          .showSnackBar(
                              const SnackBar(content: Text('削除しました')));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: '削除',
                  ),
                ]),
            child: Card(
              child: ListTile(
                title: Text(todoList[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //右下にボタンを作るWidget
        onPressed: () async {
          //ボタンが押されたときの処理
          final newListText = await Navigator.of(context).push(
            //画面遷移
            MaterialPageRoute(builder: (context) {
              return TodoAddPage(); //画面を指定
            }),
          );
          if (newListText != null) {
            //キャンセルするとnewListTextがnullになる
            setState(() {
              //画面を更新
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add), //アイコンを指定
      ),
    );
  }
}

//リスト追加画面用widget
class TodoAddPage extends StatefulWidget {
  @override
  const TodoAddPage({Key? key}) : super(key: key);
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

class ToDoUpdatePage extends StatefulWidget {
  @override
  const ToDoUpdatePage({Key? key}) : super(key: key);
  _ToDoUpdatePageState createState() => _ToDoUpdatePageState();
}

class _ToDoUpdatePageState extends State<ToDoUpdatePage>{
  @override
  Widget build(BluidContext context) {
    return Scaffold()
  }
}
