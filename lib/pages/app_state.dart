// app_state.dart
import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {

  String _enaDropdownValue = 'A';
  String get enaDropdownValue => _enaDropdownValue;
  void setenaDropdownValue(String value) {
    _enaDropdownValue = value;
    notifyListeners();
  }

  bool _ENAunit = false;
  bool get ENAunit => _ENAunit;
  void setENAunit (bool val) {
    _ENAunit = val;
    notifyListeners();
  }
}
