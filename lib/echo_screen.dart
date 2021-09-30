import 'dart:convert';

import 'package:ws_chat/message_item.dart';

import 'libs.dart';

class EchoScreen extends StatefulWidget {
  final Stream<dynamic> stream;
  EchoScreen(this.stream, {Key? key}) : super(key: key);

  @override
  State<EchoScreen> createState() {
    return EchoScreenState();
  }
}

class EchoScreenState extends State<EchoScreen> {
  final TextEditingController textInputController = new TextEditingController();
  int messageInputLength = 0;
  ScrollController scroller = new ScrollController();

  List<Message> messages = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: StreamBuilder(
                    stream: channel!.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data.toString());
                        try {
                          if (MessageType.values[int.parse(
                                  "${jsonDecode(snapshot.data.toString())['type']}")] ==
                              MessageType.EndToEndClientMessage) {
                            final mess = Message(
                              amITheOwner: true,
                              from: " You ",
                              message:
                                  ("${(jsonDecode(snapshot.data.toString())['body'] as Map<String, dynamic>)["msg"] as String}"),
                              type: MessageType.EndToEndClientMessage,
                              username: "you",
                            );
                            this.messages.add(mess);
                          } else if (MessageType.values[int.parse(
                                  "${jsonDecode(snapshot.data.toString())['type']}")] ==
                              MessageType.EndToEndServerReply) {
                            final mess = Message(
                              amITheOwner: false,
                              from: " Server ",
                              message:
                                  "${(jsonDecode(snapshot.data.toString())['body'] as Map<String, dynamic>)["msg"] as String}",
                              type: MessageType.EndToEndServerReply,
                              username: "** Server **",
                            );
                            this.messages.add(mess);
                          }
                        } catch (e, a) {
                          // -- DO Nothing
                        }
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: this.messages.length == 0
                              ? [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 50),
                                    child: Center(
                                      child: Text(
                                        "Say Hi to the server ...",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              : this
                                  .messages
                                  .map<Widget>(
                                    (e) => MessageItem(e),
                                  )
                                  .toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // File and Other Text Sending Widget Will Be Placed here.
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              // height: 70.0,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      showCursor: true,
                      controller: textInputController,
                      enabled: true,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Message here ...",
                      ),
                      onEditingComplete: () {},
                      onChanged: (String mes) {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (textInputController.text != "") {
                        channel!.sink.add(
                          jsonEncode(
                            {
                              "type": MessageType.EndToEndClientMessage.index,
                              "body": {
                                "msg": textInputController.text,
                              },
                            },
                          ),
                        );
                      }
                      textInputController.text = "";
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
