import 'package:flutter/material.dart';
import 'package:ws_chat/libs.dart';
import 'dart:convert';

class GroupMessageScreen extends StatefulWidget {
  final Stream<dynamic> stream;
  GroupMessageScreen(this.stream, {Key? key}) : super(key: key);

  @override
  State<GroupMessageScreen> createState() {
    return GroupMessageScreenState();
  }
}

class GroupMessageScreenState extends State<GroupMessageScreen> {
  GroupMessageScreenState();
  final TextEditingController textInputController = new TextEditingController();
  int messageInputLength = 0;
  Map<String, String> typings = {};
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
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
                  stream: gchannel!.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.toString());
                      try {
                        if (MessageType.values[int.parse(
                                "${jsonDecode(snapshot.data.toString())['type']}")] ==
                            MessageType.BroadcastMessageType) {
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
                            MessageType.BroadcastTypingMessage) {
                          // for (String val in typings) {
                          //   if (val ==
                          //       jsonDecode(snapshot.data.toString())['id']) {}
                          // }
                        } else if (MessageType.values[int.parse(
                                "${jsonDecode(snapshot.data.toString())['type']}")] ==
                            MessageType.BroadcastTypingMessage) {
                          final val = jsonDecode(snapshot.data.toString());
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
                                      "Say hi to the group ..",
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
          // File and Other Text Sending Widget Will Be Placed here.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            // height: 70.0,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    showCursor: true,
                    controller: textInputController,
                    enabled: true,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: "Broadcast Message here ...",
                    ),
                    onEditingComplete: () {},
                    onChanged: (String mes) {
                      if (textInputController.text.length > 0 &&
                          messageInputLength == 0) {
                      } else if (textInputController.text.length == 0) {}
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
