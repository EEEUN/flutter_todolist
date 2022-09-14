import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
        ),
      ),
      home: wanttoTodo(),
    );
  }
}

class wanttoTodoState extends State<wanttoTodo> {
  List <String> _item = <String>[];
  final _Saved = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  TextEditingController _todoController = new TextEditingController();

  // build에서는 제목이랑 _todoEdit(), buildTodoList()를 나열(?)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
      ),
      body: Column(
        // ListView는 Column의 children으로 포함될 때 반드시 Expanded로 감싸야 화면에 표시된다.
          children: <Widget>[
            Expanded(child: _todoEdit()),
            Expanded(child: _buildTodoList())
          ]
      ),
    );
  }

  // todoEdit에서는 할일추가 기능을 수행합니다
  Widget _todoEdit() {
    @override
    // 컨트롤러는 종료시 반드시 해제해줘야한다고 합니다
    void dispose() {
      _todoController.dispose();
      super.dispose();
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
              child: TextField(controller: _todoController,)
          ),
          ElevatedButton(onPressed: () => {
            _addTodo(_todoController.text.toString()),
            print(_item)
          }, child: Text('추가하기'),
            // ElevatedButton 은 backgroundColor 속성이 없고 primary 속성이 배경색을 담당한다.
            style: ElevatedButton.styleFrom(primary: Colors.indigo),)
        ],
      ),
    );
  }

  // buildRow에서는 할 일 목록을 생성합니다
  Widget _buildTodoList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _item.length,
        itemBuilder: (BuildContext context, int index) {
          Container(
            child: Text('${_item[index]}'),
          );
          return _buildRow(_item[index]);
        }
    );
  }

  // buildRow에서는 할 일 목록, 체크박스, 삭제 아이콘을 보여줍니다
  Widget _buildRow(String item) {
    final alreadySaved = _Saved.contains(item);
    return ListTile(
      title: Text(
        item,
        style: _biggerFont,
      ),
      leading: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.black : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _delectTodo(item),
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _Saved.remove(item);
          } else {
            _Saved.add(item);
          }
        });
      },
      //selected: true,
    );
  }

  void _addTodo(String todo) {
    setState(() {
      _item.add(todo);
      // 할 일을 리스트에 추가하며 입력 필드 비우기
      _todoController.text = '';
    });
  }

  void _delectTodo(String todo) {
    setState(() {
      _item.remove(todo);
    });
  }
}

class wanttoTodo extends StatefulWidget {
  @override
  wanttoTodoState createState() => wanttoTodoState();
}