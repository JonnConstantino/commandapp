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
  final TextEditingController _controller = TextEditingController();
  late final channel = WebSocketChannel.connect(
    Uri.parse('ws://127.0.0.1:4567'),
  );

  // "Protocol":
  //   f = robot forward
  //   b = robot backward
  //   d = robot turn clockwise
  //   e = robot turn counter-clockwise
  //   sxxx = servo, onde xxx é o ângulo entre 000 e 180 (sempre use 3 dígitos)

  void _toForward() {
    channel.sink.add('f');
  }

  void _turnRight() {
    channel.sink.add('r');
  }

  void _turnLeft() {
    channel.sink.add('l');
  }

  void _turnBack() {
    channel.sink.add('b');
  }

  void _turnCamera() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // container do streaming da câmera
                    Container(
                      height: 200.0,
                      width: 300.0,
                    ),
                    // caixa de texto para digitar o ângulo da câmera para virar
                    SizedBox(
                      height: 200.0,
                      width: 200.0,
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                            labelText: 'Digite o ângulo da câmera'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // canal para enviar o ângulo da câmera
                    StreamBuilder(
                      stream: channel.stream,
                      builder: (context, snapshot) {
                        return Text(snapshot.hasData ? '${snapshot.data}' : '');
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                      ),
                      onPressed: _turnCamera,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
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
    channel.sink.close();
    super.dispose();
  }
}
