// This widget is reusable
import 'package:all_language_bible/spanish/spanish.dart';
import 'package:flutter/material.dart';
import 'chinese/chinese.dart';
import 'english/English.dart';
import 'french/french.dart';
import 'german/german.dart';
import 'package:flutter_circle_flags_svg/flutter_circle_flags_svg.dart';

class MultiSelect extends StatefulWidget {
 // final List<String> items2;
 final List<Map<String, dynamic>> items;

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
    if (_selectedItems == "The Bible") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => english()),
      );
    } else if (_selectedItems == "La Biblia") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => spanish()),
      );
    } else if (_selectedItems == "La Bible") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => french()),
      );
    } else if (_selectedItems == "Die Bibel") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => german()),
      );
    }else if (_selectedItems == "圣经") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => chinese()),
      );
    }
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
                    value: _selectedItems.contains(item['name']),
                    title: Row(
                      children: [
                        CircleFlag(item['code'], size: 32),
                        SizedBox(width: 8.0),
                        Text(item['name']),
                      ],
                    ),
                    //  title: Text(item),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (isChecked) => _itemChange(item['name'], isChecked!),
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
