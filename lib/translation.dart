import 'dart:math';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

/**
 * Translation will contain two main widgets:
 * 1) Widget that contains the user input
 * 2) Widget that contains the translation string
 */
class Translation extends StatefulWidget {
  const Translation({Key? key}) : super(key: key);

  @override
  _TranslationState createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  final _myController = TextEditingController();
  static const String _title = 'Translation App';
  final translator = GoogleTranslator();
  static String inputString = "";
  static String translatedText = "";
  static String fromLang = "";
  static String toLang = "";

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _myController.addListener(_translateText);
  }

  void _translateText() {
    inputString = _myController.text;
    print('Incoming text is: ${inputString}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            // Padding(
            // padding: EdgeInsets.all(2),
            //   child:
            // ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Enter text",
                ),
                controller: _myController,
                maxLines: 10,
              ),
            ),
            Container(
              child: Transform.rotate(
                angle: pi / 2.0,
                child: Icon(
                  Icons.compare_arrows_outlined,
                  size: 60.0,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Translation",
                ),
                controller: _myController,
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
