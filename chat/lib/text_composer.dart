import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMensager);
  final Function({String text, File imgFile}) sendMensager;
  @override
  TextComposerState createState() => TextComposerState();
}

class TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();

  void reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  //campo de envio de mensagem
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          //icone botao de foto
          IconButton(
            icon: Icon(
              Icons.photo_camera,
              size: 30,
            ),
            onPressed: () async {
              File imgFile;
              final picker = ImagePicker();
              final PickedFile pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
              setState(() {
                if (pickedFile != null) {
                  imgFile = File(pickedFile.path);
                } else {
                  return;
                }
              });

              widget.sendMensager(imgFile: imgFile);
            },
          ),

          //Campo de texto
          Expanded(
            child: TextField(
              autofocus: false,
              controller: _controller,
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Enviar uma mensagem",
                  fillColor: Colors.grey[200],
                  contentPadding:
                      const EdgeInsets.only(left: 12.0, bottom: 12.0, top: 8.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.7),
                      borderSide: BorderSide(color: Colors.white))),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMensager(text: text);
                reset();
              },
            ),
          ),

          //icone botao de enviar
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 30,
            onPressed: _isComposing
                ? () {
                    widget.sendMensager(text: _controller.text);
                    reset();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
