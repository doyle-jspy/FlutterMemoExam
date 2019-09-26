import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todo = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeighr = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("메모장"),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: screenWidth,
        height: screenHeighr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: screenWidth / 2,
              child: TextField(
                autofocus: true,
                onSubmitted: (val){
                  if(val.isEmpty){
                    return print("입력해주세요");
                  }
                  else{
                    return todo.add((val));
                  }
                },
                controller: TextEditingController(
                  text: ""
                ),
              ),
            ),
            Container(
              width: screenWidth,
              height: 500,
              child: ListView.builder(
                itemCount: todo.length == null ? 1 : todo.length,
                itemBuilder: (BuildContext context, int index){
                  if(index < todo.length){
                    return GestureDetector(
                      child: Container(
                        width: screenWidth,
                        height: 150,
                        child: Row(
                          children: <Widget>[
                            Text(todo[index].toString()),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: IconButton(
                                    icon: Icon(Icons.update),
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UpdatePage(
                                          todo: this.todo,
                                          index: index,
                                        )
                                      )
                                    )
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: (){
                                      setState(() {
                                        todo.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return SizedBox(
                      width: 10,
                      height: 10,
                    );
                  }
                },
              ),
            )
          ],
        ),
      )
      ),
    );
  }
}

class UpdatePage extends StatefulWidget {
  List todo;
  var index;

  UpdatePage({this.todo, this.index});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("수정"),
      ),
      body: Column(
        children: <Widget>[
          Text(
              widget.todo[widget.index].toString()
          ),
          Container(
            child: TextField(
              controller: TextEditingController(
                text: widget.todo[widget.index].toString()
              ),
              onSubmitted: (v){
                setState(() {
                  widget.todo[widget.index] = v;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
