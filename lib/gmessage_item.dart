import 'package:ws_chat/models.dart';

import 'libs.dart';

class GroupMessageItem extends StatelessWidget {
  final Message message;
  GroupMessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: this.message.amITheOwner
          ? BorderRadius.only(
              topLeft: Radius.circular(70),
              topRight: Radius.circular(70),
              bottomLeft: Radius.circular(70),
            )
          : BorderRadius.only(
              topLeft: Radius.circular(70),
              topRight: Radius.circular(70),
              bottomRight: Radius.circular(70),
            ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: this.message.amITheOwner ? Colors.blue : Colors.black26,
          borderRadius: this.message.amITheOwner
              ? BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
        ),
        margin: this.message.amITheOwner
            ? EdgeInsets.only(
                left: 80,
                top: 10,
              )
            : EdgeInsets.only(
                right: 80,
                top: 10,
              ),
        child: Column(
          children: [
            Text(
              message.username,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              message.message,
              style: TextStyle(
                fontStyle: FontStyle.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
