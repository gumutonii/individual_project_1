// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';

void main() {
  runApp(TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_tempController.text) ?? 0;

    double convertedTemp;
    String conversionResult;

    if (_conversionType == 'F to C') {
      // Fahrenheit to Celsius
      convertedTemp = (inputTemp - 32) * 5 / 9;
      conversionResult =
          'F to C: ${inputTemp.toStringAsFixed(1)} = ${convertedTemp.toStringAsFixed(2)}°C';
    } else {
      // Celsius to Fahrenheit
      convertedTemp = inputTemp * 9 / 5 + 32;
      conversionResult =
          'C to F: ${inputTemp.toStringAsFixed(1)} = ${convertedTemp.toStringAsFixed(2)}°F';
    }

    // use setState to update the result and history
    setState(() {
      _result = conversionResult;
      _history.add(conversionResult);
    });
  }

  // building interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Conversion Type:',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _conversionType,
                  onChanged: (String? value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _conversionType,
                  onChanged: (String? value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text('Celsius to Fahrenheit'),
              ],
            ),
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _history[index],
                      style: TextStyle(fontSize: 20), // Increased font size for history
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
