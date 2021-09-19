// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';

// class GroupMessageScreen extends StatelessWidget {
//   GroupMessageScreen({Key? key}) : super(key: key);

//   final TextEditingController textInputController = new TextEditingController();
//   int messageInputLength = 0;
//   ScrollController scroller = new ScrollController();

//   // final channel = WebSocketChannel.connect(
//   //   Uri.parse('wss://echo.websocket.org'),
//   // );
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.6,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 topRight: Radius.circular(30.0),
//               ),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 topRight: Radius.circular(30.0),
//               ),
//               child: Container(),
//             ),
//           ),
//           // File and Other Text Sending Widget Will Be Placed here.
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             // height: 70.0,
//             color: Colors.white,
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.image),
//                   color: Theme.of(context).primaryColor,
//                   onPressed: () {},
//                 ),
//                 Expanded(
//                   child: TextField(
//                     autofocus: true,
//                     textCapitalization: TextCapitalization.sentences,
//                     showCursor: true,
//                     controller: textInputController,
//                     enabled: true,
//                     minLines: 1,
//                     decoration: InputDecoration(
//                       hintText: "Broadcast Message here ...",
//                     ),
//                     onEditingComplete: () {},
//                     onChanged: (String mes) {
//                       if (textInputController.text.length > 0 &&
//                           messageInputLength == 0) {
//                       } else if (textInputController.text.length == 0) {}
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   color: Theme.of(context).primaryColor,
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
