import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
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
    Uri.parse('ws://127.0.0.1:8765'),
  );

  // "Protocol":
  //   f = robot forward
  //   b = robot backward
  //   d = robot turn clockwise
  //   e = robot turn counter-clockwise
  //   sxxx = servo, onde xxx é o ângulo entre 000 e 180 (sempre use 3 dígitos)

  void _toForward() {
    channel.sink.add('f');
    // channel.sink.add(json.encode('f'));
  }

  void _turnRight() {
    channel.sink.add('d');
    // channel.sink.add(json.encode('d'));
  }

  void _turnLeft() {
    channel.sink.add('e');
    // channel.sink.add(json.encode('e'));
  }

  void _turnBack() {
    channel.sink.add('b');
    // channel.sink.add(json.encode('b'));
  }

  void _turnCamera() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
      // channel.sink.add(json.encode(_controller.text));
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
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 200.0,
                  width: 300.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 28.0,
                      width: 280.0,
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                            hintText: 'Digite o ângulo da câmera ex.: sXXX'),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                      onPressed: _turnCamera,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  ),
                  onPressed: _turnLeft,
                  child: const Icon(Icons.arrow_back),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                      ),
                      onPressed: _toForward,
                      child: const Icon(Icons.arrow_upward),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                      ),
                      onPressed: _turnBack,
                      child: const Icon(Icons.arrow_downward),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  ),
                  onPressed: _turnRight,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            // SizedBox(
            //   height: 200.0,
            //   width: 200.0,
            //   child: StreamBuilder(
            //     stream: channel.stream,
            //     builder: (context, snapshot) {
            //       return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
