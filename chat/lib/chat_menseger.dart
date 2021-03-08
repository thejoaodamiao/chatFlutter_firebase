import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMenseger extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool mine;
  ChatMenseger(this.data, this.mine);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['senderPhotoUrl']),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                data['imgUrl'] != null
                    ? Image.network(
                        data['imgUrl'],
                        width: 250,
                      )
                    : Text(
                        data['text'],
                        style: GoogleFonts.catamaran(
                          fontSize: 16,
                        ),
                      ),
                Text(
                  data['senderName'],
                  textAlign: mine ? TextAlign.end : TextAlign.start,
                  style: GoogleFonts.catamaran(
                      fontSize: 13,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['senderPhotoUrl']),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
