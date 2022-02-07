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
      home: const MyAppPage(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command App'),
      ),
      body: Center(
        child: Row(
          children: [
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  ),
                  onPressed: _toForward,
                  child: const Icon(Icons.arrow_upward),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  ),
                  onPressed: _turnLeft,
                  child: const Icon(Icons.arrow_back),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  ),
                  onPressed: _turnRight,
                  child: const Icon(Icons.arrow_forward),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  ),
                  onPressed: _turnBack,
                  child: const Icon(Icons.arrow_downward),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
