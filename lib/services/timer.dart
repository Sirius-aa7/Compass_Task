import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeDisplayPage extends StatefulWidget {
  @override
  _TimeDisplayPageState createState() => _TimeDisplayPageState();
}

class _TimeDisplayPageState extends State<TimeDisplayPage> {
  bool _showIST = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {});
    });
  }

  String _getCurrentTime(String timeZone) {
    var now = DateTime.now().toUtc();
    if (timeZone == 'IST') {
      now = now.add(Duration(hours: 5, minutes: 30));
    }
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  void _toggleTimeZone() {
    setState(() {
      _showIST = !_showIST;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleTimeZone,
        child: Text(
          _showIST ? 'IST: ${_getCurrentTime('IST')}' : 'GMT: ${_getCurrentTime('GMT')}',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}