import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyThingy extends StatefulWidget {
  const MoneyThingy({Key? key}) : super(key: key);

  @override
  _MoneyThingyState createState() => _MoneyThingyState();
}

class _MoneyThingyState extends State<MoneyThingy> {
  late double _input;
  late double _output;
  String selectedTimezone = 'WIB';
  String currentTime = '';
  // currency IDR, USD, EUR, JPY
  late String _currencyInput;
  late String _currencyOutput;
  late String _result;

  final TextEditingController _inputController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _input = 0;
    _currencyInput = 'IDR';
    _currencyOutput = 'IDR';
    _result = '';
    startClock();
  }

  void startClock() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
      });
    });
  }

  String convertToTimezone(String timezone) {
    DateTime now = DateTime.now().toUtc();
    switch (timezone) {
      case 'WIB':
        now = now.add(Duration(hours: 7));
        break;
      case 'WIT':
        now = now.add(Duration(hours: 9));
        break;
      case 'WITA':
        now = now.add(Duration(hours: 8));
        break;
    }
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }


  void _onInputChanged(String value) {
    setState(() {
      _input = double.tryParse(value) ?? 0;
    });
  }

  void _onCurrencyInputChanged(String? value) {
    setState(() {
      _currencyInput = value ?? 'IDR';
    });
  }

  void _onCurrencyOutputChanged(String? value) {
    setState(() {
      _currencyOutput = value ?? 'IDR';
    });
  }



  void _convert() {
    setState(() {
      switch (_currencyInput) {
        case 'IDR':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input;
              break;
            case 'USD':
              _output = _input / 15000;
              break;
            case 'EUR':
              _output = _input / 16000;
              break;
            case 'JPY':
              _output = _input / 108;
              break;
          }
          break;
        case 'USD':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input * 15000;
              break;
            case 'USD':
              _output = _input;
              break;
            case 'EUR':
              _output = _input * 0.90;
              break;
            case 'JPY':
              _output = _input * 137;
              break;
          }
          break;
        case 'EUR':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input * 16000;
              break;
            case 'USD':
              _output = _input * 1.08;
              break;
            case 'EUR':
              _output = _input;
              break;
            case 'JPY':
              _output = _input * 150;
              break;
          }
          break;
        case 'JPY':
          switch (_currencyOutput) {
            case 'IDR':
              _output = _input * 108;
              break;
            case 'USD':
              _output = _input * 0.0072;
              break;
            case 'EUR':
              _output = _input * 0.0067;
              break;
            case 'JPY':
              _output = _input;
              break;
          }
          break;
      }
      if(_currencyOutput == 'IDR'){
      _result = 'Rp' + (_output.toStringAsFixed(2));
      }else if(_currencyOutput == 'USD'){
        _result = 'USD ' + (_output.toStringAsFixed(2));
      }else if(_currencyOutput == 'EUR'){
        _result = '€' + (_output.toStringAsFixed(2));
      }else{
        _result = '¥' + (_output.toStringAsFixed(2));
      }
    });
  }

  @override
  // make dropdown button without array looping

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title : const Text('Money Conversion'),
          actions: [
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 10, 0), //apply padding to LTRB, L:Left, T:Top, R:Right, B:Bottom
              child: Text(
              selectedTimezone == 'UTC' ? currentTime : convertToTimezone(selectedTimezone),
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            ),
            DropdownButton<String>(
              value: selectedTimezone,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTimezone = newValue!;
                });
              },
              items: <String>['WIB', 'WITA', 'WIT', 'UTC'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,)),
                );
              }).toList(),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.green[800],
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: _onInputChanged,
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    labelText: 'Input',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: _currencyInput,
                  onChanged: _onCurrencyInputChanged,
                  items: const <String>['IDR', 'USD', 'EUR', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 20)),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: _currencyOutput,
                  onChanged: _onCurrencyOutputChanged,
                  items: const <String>['IDR', 'USD', 'EUR', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 20)),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    primary: Colors.red,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _convert,
                  child: const Text('Convert'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _result,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            ),
        );
    }
}