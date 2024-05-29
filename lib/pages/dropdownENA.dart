import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 30,
      child: DropdownButton<String>(
        hint: Text('A1'),
        value: _selectedItem,
        items: [
          DropdownMenuItem(
            value: 'A1',
            child: Text('A1'),
          ),
          DropdownMenuItem(
            value: 'A2',
            child: Text('A2'),
          ),
          DropdownMenuItem(
            value: 'A3',
            child: Text('A3'),
          ),
          DropdownMenuItem(
            value: 'B1',
            child: Text('B1'),
          ),
          DropdownMenuItem(
            value: 'B2',
            child: Text('B2'),
          ),
          DropdownMenuItem(
            value: 'B3',
            child: Text('B3'),
          ),
        ],
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
        },
      ),
    );
  }
}
