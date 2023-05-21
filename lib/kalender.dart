import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

enum TimeZone { wib, wita, wit, utc }

class kalender extends StatefulWidget {
  const kalender({Key? key}) : super(key: key);

  @override
  State<kalender> createState() => _kalenderState();
}

class _kalenderState extends State<kalender> {
  String _currentTime = '';
  String _currentZone = 'WIB';
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE MM/dd/yyyy HH:mm:ss').format(dateTime);
  }

  @override
  void initState() {
    _currentTime = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime utc = DateTime.now().toUtc();
    final DateTime localTime = utc.add(_getOffset(_currentZone));
    final String formatTime = _formatDateTime(localTime);
    if (this.mounted) {
      setState(() {
        _currentTime = formatTime;
      });
    }
  }

  String zonetime(zone){
    if (zone == "WITA") {
      return 'Singapore Standard Time';
    }
    if (zone == "WIT") {
      return 'North Asia East Standard Time';
    }
    if (zone == "UTC") {
      return 'GMT Standard Time';
    }
    return 'SE Asia Standard Time';
  }

  Duration _getOffset(String zone) {
    if (zone == "WITA") {
      return const Duration(hours: 8);
    }
    if (zone == "WIT") {
      return const Duration(hours: 9);
    }
    if (zone == "UTC") {
      return const Duration(hours: 1);
    }
    return const Duration(hours: 7);
  }

  @override
  Widget build(BuildContext context) {
    String zone1 = zonetime(_currentZone);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: const Text(
          "Calendar",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                '$_currentTime $_currentZone',
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _currentZone == 'WIB'
                        ? null
                        : () {
                      setState(() {
                        _currentZone = 'WIB';
                      });
                    },
                    child: Text(
                      'WIB',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF82B1FF),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _currentZone == 'WITA'
                        ? null
                        : () {
                      setState(() {
                        _currentZone = 'WITA';
                      });
                    },
                    child: Text(
                      'WITA',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF82B1FF),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _currentZone == 'WIT'
                        ? null
                        : () {
                      setState(() {
                        _currentZone = 'WIT';
                      });
                    },
                    child: Text(
                      'WIT',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF82B1FF),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _currentZone == 'UTC'
                        ? null
                        : () {
                      setState(() {
                        _currentZone = 'UTC';
                      });
                    },
                    child: Text(
                      'UTC',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF82B1FF),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: SfCalendar(
                  view: CalendarView.month,
                  timeZone: zone1,
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF82B1FF),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
