// Implement a multi select on the Home screen
import 'dart:async';
import 'package:flutter/material.dart';
import 'MultiSelect.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showMultiSelect());
  }

  final List<String> items = ['The Bible', 'La Biblia', 'La Bible', 'Die Bibel'];

  _showMultiSelect() async {
    // a list of selectable items
    List<String> _selectedItems = [];
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String>? results = await showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 700),
      barrierColor: Color(0x01000000),
      context: context,
      pageBuilder: (BuildContext context, anim, anim2) {
        return MultiSelect(items: items);
      },

      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
    );
  }
}
