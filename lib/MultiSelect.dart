// This widget is reusable
import 'package:all_language_bible/spanish/spanish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'english/English.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  late String _selectedItems = "ENGLISH";

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems = itemValue;
      } else {
        _selectedItems = "ENGLISH";
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

  // this function is called when the Submit button is tapped
  void _submit() {
    if (_selectedItems == "ENGLISH") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => english()),
      );
    } else if (_selectedItems == "SPANISH") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => spanish()),
      );
    } else if (_selectedItems == "Hymnal") {
    } else if (_selectedItems == "Prayers") {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      title: const Text('Select Language'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        /*TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),*/
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    ));
  }
}
