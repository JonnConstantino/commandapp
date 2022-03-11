import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:video_player/video_player.dart';

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

  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  // "Protocol":
  //   f = robot forward
  //   b = robot backward
  //   d = robot turn clockwise
  //   e = robot turn counter-clockwise
  //   sxxx = servo, onde xxx é o ângulo entre 000 e 180 (sempre use 3 dígitos)

// função para enviar o comando de movimento para frente
  void _toForward() {
    channel.sink.add('f');
    // channel.sink.add(json.encode('f'));
  }

// função para enviar o comando de movimento para direita
  void _turnRight() {
    channel.sink.add('d');
    // channel.sink.add(json.encode('d'));
  }

// função para enviar o comando de movimento para esquerda
  void _turnLeft() {
    channel.sink.add('e');
    // channel.sink.add(json.encode('e'));
  }

// função para enviar o comando de movimento para trás
  void _turnBack() {
    channel.sink.add('b');
    // channel.sink.add(json.encode('b'));
  }

// função para enviar o comando de movimento da câmera
  void _turnCamera() {
    if (_controller.text.isNotEmpty) {
      // adiciona a string 's' no ínicio conforme regras do robô
      channel.sink.add('s' + _controller.text);
      // channel.sink.add(json.encode(_controller.text));
    }
  }

  @override
  void initState() {
    super.initState();

    // cria e armazena o videoPlayerControler
    _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

    // inicializa o controlador e armazena o Future para uso posterior
    _initializeVideoPlayerFuture = _videoController.initialize();

    // usa o controlador para fazer o loop do vídeo
    _videoController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // coluna para organização do layout
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // outra separação em coluna para pôr o vídeo e
            // o botão de play/ pause
            Column(
              children: [
                // caixa para limitar tela do vídeo
                // com tamanho 300x200 px
                SizedBox(
                  width: 300.0,
                  height: 200.0,
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // se o VideoPlayerController tiver concluído a inicialização, usa
                        // os dados fornecidos para limitar a proporção do vídeo
                        return AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          // usa o widget videoPlayer para exibir o vídeo
                          child: VideoPlayer(_videoController),
                        );
                      } else {
                        // se o videoPlayerController ainda está iniciando, mostra uma
                        // tela de carregamento
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // envolva a reprodução ou pausa em uma chamada para `setState`
                    // isso garante que o ícone correto seja exibido
                    setState(() {
                      // se o vídeo está reproduzindo, para
                      if (_videoController.value.isPlaying) {
                        _videoController.pause();
                      } else {
                        // se o vídeo está parado, continua
                        _videoController.play();
                      }
                    });
                  },
                  // mostra o ícone correto para pausar ou continuar o vídeo
                  child: Icon(
                    _videoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                // linha para organização do layout
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // caixa para limitar entrada do texto do ângulo
                    // com tamanho de 280x28 px
                    SizedBox(
                      height: 28.0,
                      width: 280.0,
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                            // hintText para mostrar uma legenda e esconder o texto
                            // quando estiver digitando dentro da caixa de texto
                            hintText: 'Digite o ângulo da câmera:'),
                      ),
                    ),
                    // botão para enviar o comando de movimento do ângulo da câmera
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
            // linha para organização do layout
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // botão que envia o comando de movimento para esquerda
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  ),
                  onPressed: _turnLeft,
                  child: const Icon(Icons.arrow_back),
                ),
                // coluna para organização do layout
                Column(
                  children: [
                    // botão que envia o comando de movimento para frente
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                      ),
                      onPressed: _toForward,
                      child: const Icon(Icons.arrow_upward),
                    ),
                    // botão que envia o comando de movimento para trás
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                      ),
                      onPressed: _turnBack,
                      child: const Icon(Icons.arrow_downward),
                    ),
                  ],
                ),
                // botão que envia o comando de movimento para direita
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  ),
                  onPressed: _turnRight,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// fechando e encerrando o canal e os controladores
// do video e do texto para enviar o ângulo da câmera
  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }
}
