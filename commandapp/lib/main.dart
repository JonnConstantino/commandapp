import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CommandApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatefulWidget {
  const MyAppPage({Key? key}) : super(key: key);

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  void _toForward() {}

  void _turnRight() {}

  void _turnLeft() {}

  void _turnBack() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CommandApp'),
        ),
        body: Center(
          child: Container(
            child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: _toForward,
                child: Icon(Icons.arrow_upward),
              ),
              const SizedBox(height: 30),
              children: [Column(
                ElevatedButton(
                onPressed: _turnRight,
                child: Icon(Icons.arrow_forward),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _turnLeft,
                child: Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _turnBack,
                child: Icon(Icons.arrow_downward),
              ),
              const SizedBox(height: 30),
              ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
