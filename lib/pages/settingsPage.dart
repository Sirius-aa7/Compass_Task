import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'lat_long.dart';

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
  String _selectedItemFirstDropdown = 'Lat-Lon(DMS)';
  String _selectedItemSecondDropdown = '';
  List<String> _dropdownItems = ['Lat-Lon(DMS)', 'Lat-Lon(DM)', 'Lat-Lon(D)',
    'East-Nort'];
  List<String> _secondDropdownItems = ['Lat-Lon(DM)', 'Lat-Lon(D)',
    'East-Nort'];

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
    var appState = Provider.of<AppState>(context);

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20),
            DropdownButton<String>(
              value: appState.enaDropdownValue,
              // value: enaDropdownValue,
              items: [
                DropdownMenuItem(
                  value: 'A',
                  child: Text('Primary Unit'),
                ),
                DropdownMenuItem(
                  value: 'B',
                  child: Text('Secondary Unit'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  appState.setenaDropdownValue(newValue!);
                  appState.setENAunit(appState.ENAunit);
                  appState.setENAunit(appState.enaDropdownValue == 'B');
                  // appState.enaDropdownValue == 'B';
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 100,
                    child: Text("Primary Units", style: TextStyle(fontSize:
                    12),)),
                DropdownButton<String>(
                  // value: GeoLocationApp().drop,
                  // value: Provider.of<GeoLocationApp>(context).drop,
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
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 100,
                    child: Text("Secondary Units", style: TextStyle(fontSize:
                    12),)),
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
          ],
        ),
      ),
    );
  }
}
