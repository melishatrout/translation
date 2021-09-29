import 'dart:math';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Translation extends StatefulWidget {
  const Translation({Key? key}) : super(key: key);

  @override
  _TranslationState createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();
  static const String _title = 'Translation App';
  final translator = GoogleTranslator();
  static String inputString = "";
  static String fromLang = "";
  static String fromLangText = "";
  static String toLang = "";
  static String toLangText = "";
  static String dropdownValue1 = 'Automatic';
  static String dropdownValue2 = 'Automatic';

  static final _langs = {
    'auto': 'Automatic',
    'af': 'Afrikaans',
    'sq': 'Albanian',
    'am': 'Amharic',
    'ar': 'Arabic',
    'hy': 'Armenian',
    'az': 'Azerbaijani',
    'eu': 'Basque',
    'be': 'Belarusian',
    'bn': 'Bengali',
    'bs': 'Bosnian',
    'bg': 'Bulgarian',
    'ca': 'Catalan',
    'ceb': 'Cebuano',
    'ny': 'Chichewa',
    'zh-cn': 'Chinese Simplified',
    'zh-tw': 'Chinese Traditional',
    'co': 'Corsican',
    'hr': 'Croatian',
    'cs': 'Czech',
    'da': 'Danish',
    'nl': 'Dutch',
    'en': 'English',
    'eo': 'Esperanto',
    'et': 'Estonian',
    'tl': 'Filipino',
    'fi': 'Finnish',
    'fr': 'French',
    'fy': 'Frisian',
    'gl': 'Galician',
    'ka': 'Georgian',
    'de': 'German',
    'el': 'Greek',
    'gu': 'Gujarati',
    'ht': 'Haitian Creole',
    'ha': 'Hausa',
    'haw': 'Hawaiian',
    'iw': 'Hebrew',
    'hi': 'Hindi',
    'hmn': 'Hmong',
    'hu': 'Hungarian',
    'is': 'Icelandic',
    'ig': 'Igbo',
    'id': 'Indonesian',
    'ga': 'Irish',
    'it': 'Italian',
    'ja': 'Japanese',
    'jw': 'Javanese',
    'kn': 'Kannada',
    'kk': 'Kazakh',
    'km': 'Khmer',
    'ko': 'Korean',
    'ku': 'Kurdish (Kurmanji)',
    'ky': 'Kyrgyz',
    'lo': 'Lao',
    'la': 'Latin',
    'lv': 'Latvian',
    'lt': 'Lithuanian',
    'lb': 'Luxembourgish',
    'mk': 'Macedonian',
    'mg': 'Malagasy',
    'ms': 'Malay',
    'ml': 'Malayalam',
    'mt': 'Maltese',
    'mi': 'Maori',
    'mr': 'Marathi',
    'mn': 'Mongolian',
    'my': 'Myanmar (Burmese)',
    'ne': 'Nepali',
    'no': 'Norwegian',
    'ps': 'Pashto',
    'fa': 'Persian',
    'pl': 'Polish',
    'pt': 'Portuguese',
    'pa': 'Punjabi',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sm': 'Samoan',
    'gd': 'Scots Gaelic',
    'sr': 'Serbian',
    'st': 'Sesotho',
    'sn': 'Shona',
    'sd': 'Sindhi',
    'si': 'Sinhala',
    'sk': 'Slovak',
    'sl': 'Slovenian',
    'so': 'Somali',
    'es': 'Spanish',
    'su': 'Sundanese',
    'sw': 'Swahili',
    'sv': 'Swedish',
    'tg': 'Tajik',
    'ta': 'Tamil',
    'te': 'Telugu',
    'th': 'Thai',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'ur': 'Urdu',
    'uz': 'Uzbek',
    'ug': 'Uyghur',
    'vi': 'Vietnamese',
    'cy': 'Welsh',
    'xh': 'Xhosa',
    'yi': 'Yiddish',
    'yo': 'Yoruba',
    'zu': 'Zulu'
  };

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    _outputController.addListener(_translateText);
  }

  void _translateText() {
    inputString = _inputController.text;
    if (_langs.containsValue(dropdownValue2)) {
      toLang = _langs.keys
          .firstWhere((element) => _langs[element] == dropdownValue2);
    }
    if (inputString.length > 0) {
      print('Incoming text is: ${inputString}');
      translator
          .translate(inputString, to: toLang)
          .asStream()
          .forEach((element) {
        setState(() {
          _outputController.text = element.text;
        });
      });
    }
    print('Output string is ${_outputController.text}\n\n');
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
            buildInput(),
            buildIcon(),
            buildLangList(),
            buildOutPut(),
          ],
        ),
      ),
    );
  }

  Padding buildOutPut() {
    return Padding(
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
        readOnly: true,
      ),
    );
  }

  Padding buildLangList() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: DropdownButton<String>(
        value: dropdownValue2,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue2 = newValue!;
            toLangText = dropdownValue2;
          });
        },
        items: _langs.values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Container buildIcon() {
    return Container(
      child: Transform.rotate(
        angle: pi / 2.0,
        child: Icon(
          Icons.compare_arrows_outlined,
          size: 60.0,
          color: Colors.pinkAccent,
        ),
      ),
    );
  }

  Padding buildInput() {
    return Padding(
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
    );
  }
}
