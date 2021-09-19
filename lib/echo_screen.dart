import 'package:ws_chat/message_item.dart';

import 'libs.dart';

class EchoScreen extends StatefulWidget {
  EchoScreen({Key? key}) : super(key: key);

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
                        // print(snapshot.data.toString());
                        if (snapshot.data.toString().startsWith("ey:") ||
                            snapshot.data.toString().startsWith("ee:")) {
                          final mlist = snapshot.data.toString().split(":");
                          final mess = Message(
                            amITheOwner:
                                snapshot.data.toString().startsWith("ey:"),
                            from: snapshot.data.toString().startsWith("ey:")
                                ? "( You )"
                                : " Server ",
                            message: mlist[1],
                            type: 0,
                            username: snapshot.data.toString().startsWith("ey:")
                                ? "( You )"
                                : "** Server **",
                          );
                          this.messages.add(mess);
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
                        channel!.sink.add("e:" + textInputController.text);
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
