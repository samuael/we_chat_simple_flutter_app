import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'libs.dart';

IOWebSocketChannel? channel;
IOWebSocketChannel? gchannel;
// Stream<dynamic> broadcastStream;

void main() {
  runApp(MyApp());
  channel = IOWebSocketChannel.connect(Uri.parse(''
      // 'wss://first-tine-305117.ey.r.appspot.com/ws/?username="user"&id="787498472398dk"'));
      // 'ws://192.168.43.207:8080/ws/?username="user"&id="787498472398dk"'));
      'ws://34.67.3.202:8070/ws/?username="user"&id="787498472398dk"'));
  gchannel = IOWebSocketChannel.connect(Uri.parse(
      // 'wss://first-tine-305117.ey.r.appspot.com/ws/?username="user"&id="787498472398dk"'));
      // 'ws://192.168.43.207:8080/ws/?username="user"&id="787498472398dk"'));
      'ws://34.67.3.202:8070/ws/?username="user"&id="787498472398dk"'));
  // broadcastStream = channel!.stream.asBroadcastStream();

  Future(() async {
    while (true) {
      await Future.delayed(Duration(seconds: 10), () {
        if (channel == null || channel!.sink == null) {
          channel = IOWebSocketChannel.connect(Uri.parse(
              'wss://first-tine-305117.ey.r.appspot.com/ws/?username="user"&id="787498472398dk"'));
          // 'ws://192.168.43.207:8080/ws/?username="user"&id="787498472398dk"'));
          // 'ws://10.6.193.209:8080/ws/?username="user"&id="787498472398dk"'));
          // Uri.parse('ws://130.127.133.199.245:8080/ws/?username="user"'));
        }
        if (gchannel == null || gchannel!.sink == null) {
          gchannel = IOWebSocketChannel.connect(Uri.parse(
              'wss://first-tine-305117.ey.r.appspot.com/ws/?username="user"&id="787498472398dk"'));
          // 'ws://192.168.43.207:8080/ws/?username="user"&id="787498472398dk"'));
          // 'ws://10.6.193.209:8080/ws/?username="user"&id="787498472398dk"'));
          // Uri.parse('ws://130.127.133.199.245:8080/ws/?username="user"'));
        }
      });
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WebSocket chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// _MyHomePageState ...
class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  String title = " Echo chat";
  PageController controller = PageController();

  bool runs = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final broadcastStream = channel!.stream.asBroadcastStream();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.person,
                              color: index == 1 ? Colors.grey : Colors.white,
                              size: 28,
                            ),
                            splashColor: Colors.white,
                            splashRadius: 50,
                            onPressed: () {
                              controller.animateToPage(
                                0,
                                duration: Duration(seconds: 1),
                                curve: Curves.decelerate,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: PageView(
                // controller :
                onPageChanged: (ind) {
                  if (ind == 0) {
                    setState(() {
                      this.index = ind;
                      this.title = "Echo chat";
                    });
                  } else {
                    setState(
                      () {
                        this.index = ind;
                        this.title = "Group chat";
                      },
                    );
                  }
                },
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: EchoScreen(broadcastStream),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: GroupMessageScreen(broadcastStream),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }
}
