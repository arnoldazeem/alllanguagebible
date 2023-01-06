import 'package:flutter/material.dart';
import 'dart:developer';

class VersesReaderWidget extends StatelessWidget {
  VersesReaderWidget({super.key, required this.verses, this.keyword});

  final String? keyword;
  final List<dynamic> verses;

  @override
  Widget build(BuildContext context) {
    // log('data: $verses');
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: verses.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: '${index + 1} ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              highlightText(index)
              // TextSpan(text: '${verses[index]}')
            ], style: DefaultTextStyle.of(context).style),
          ),
        );
      },
    );
  }

  // detects the particular search keyword
  TextSpan highlightText(int index) {
    TextSpan textSpan;
    // print(keyword);
    if (keyword != null && verses[index].toLowerCase().contains(keyword?.toLowerCase().trim())) {
      textSpan = TextSpan(
        text: '${verses[index]}',
        style: const TextStyle(backgroundColor: Colors.yellow),
      );
    } else {
      textSpan = TextSpan(
        text: '${verses[index]}',
      );
    }
    return textSpan;
  }
}
