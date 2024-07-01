import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonOverlayButton(buttonNumber: 1),
            SizedBox(height: 20),
            ButtonOverlayButton(buttonNumber: 2),
            SizedBox(height: 20),
            ButtonOverlayButton(buttonNumber: 3),
            SizedBox(height: 20),
            ButtonOverlayButton(buttonNumber: 4),
          ],
        ),
      ),
    );
  }
}

class ButtonOverlayButton extends StatelessWidget {
  final int buttonNumber;

  ButtonOverlayButton({required this.buttonNumber});

  void _showOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensures the sheet covers the entire screen
      backgroundColor: Colors.transparent, // Makes background transparent
      isDismissible: true, // Allows dismissing by tapping outside or swiping
      enableDrag: true, // Allows dismissing by dragging
      builder: (BuildContext context) {
        return ButtonOverlayContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showOverlay(context),
      child: Text('Button $buttonNumber'),
    );
  }
}

class ButtonOverlayContent extends StatefulWidget {
  @override
  _ButtonOverlayContentState createState() => _ButtonOverlayContentState();
}

class _ButtonOverlayContentState extends State<ButtonOverlayContent> {
  String _selectedItemFirstDropdown = 'Item 1';
  String _selectedItemSecondDropdown = '';
  List<String> _dropdownItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  List<String> _secondDropdownItems = ['Item 2', 'Item 3', 'Item 4'];

  @override
  void initState() {
    super.initState();
    _selectedItemSecondDropdown = _secondDropdownItems.isNotEmpty ? _secondDropdownItems[0] : '';
  }

  void _updateSecondDropdownItems(String selectedItem) {
    setState(() {
      _selectedItemFirstDropdown = selectedItem;
      _secondDropdownItems = List.from(_dropdownItems);
      _secondDropdownItems.remove(selectedItem);

      // Ensure _selectedItemSecondDropdown is a valid value in _secondDropdownItems
      if (!_secondDropdownItems.contains(_selectedItemSecondDropdown)) {
        _selectedItemSecondDropdown = _secondDropdownItems.isNotEmpty ? _secondDropdownItems[0] : '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        height: MediaQuery.of(context).size.width * 0.8, // Square dimensions
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedItemFirstDropdown,
              onChanged: (newValue) {
                _updateSecondDropdownItems(newValue!);
              },
              items: _dropdownItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedItemSecondDropdown,
              onChanged: (newValue) {
                setState(() {
                  _selectedItemSecondDropdown = newValue!;
                });
              },
              items: _secondDropdownItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
