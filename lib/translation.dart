import 'dart:math';

import 'package:flutter/material.dart';

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
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();
  static const String _title = 'Translation App';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
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
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Enter text",
                ),
                controller: _inputController,
                maxLines: 10,
              ),
            ),
            Container(
              child: Transform.rotate(
                angle: pi / 2.0,
                child: Icon(
                  Icons.compare_arrows_outlined,
                  size: 45.0,
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
                controller: _outputController,
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
