import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.org'),
  );

  void _toForward() {
    _channel.sink.add('F');
  }

  void _turnRight() {
    _channel.sink.add('R');
  }

  void _turnLeft() {
    _channel.sink.add('L');
  }

  void _turnBack() {
    _channel.sink.add('B');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command App'),
      ),
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 20.0, right: 30.0),
              ),
              onPressed: _turnLeft,
              child: const Icon(Icons.arrow_back),
            ),
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
                  onPressed: _turnBack,
                  child: const Icon(Icons.arrow_downward),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 20.0, right: 30.0),
              ),
              onPressed: _turnRight,
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
