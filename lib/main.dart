import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _currentValue = '';
  String _operator = '';
  double _result = 0;

  void _onNumberPressed(String value) {
    setState(() {
      _currentValue += value;
      _display = _currentValue;
    });
  }

  void _onOperatorPressed(String operator) {
    if (_currentValue.isEmpty) return;
    setState(() {
      _operator = operator;
      _result = double.tryParse(_currentValue) ?? 0;
      _currentValue = '';
    });
  }

  void _onCalculatePressed() {
    if (_currentValue.isEmpty || _operator.isEmpty) return;
    setState(() {
      double secondOperand = double.tryParse(_currentValue) ?? 0;

      switch (_operator) {
        case '+':
          _result += secondOperand;
          break;
        case '-':
          _result -= secondOperand;
          break;
        case '*':
          _result *= secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            _display = 'Error';
            _currentValue = '';
            _operator = '';
            return;
          }
          _result /= secondOperand;
          break;
      }

      _display = _result.toString();
      _currentValue = '';
      _operator = '';
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '';
      _currentValue = '';
      _operator = '';
      _result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black, // Set AppBar background to black
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Set text color to blue
                ),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('7'),
              _buildNumberButton('8'),
              _buildNumberButton('9'),
              _buildOperatorButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('4'),
              _buildNumberButton('5'),
              _buildNumberButton('6'),
              _buildOperatorButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('1'),
              _buildNumberButton('2'),
              _buildNumberButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('0'),
              _buildOperatorButton('+'),
              _buildCalculateButton(),
              _buildOperatorButton('C'),
            ],
          ),
        ],
      ),
    );
  }

  // Number button widget with blue text
  Widget _buildNumberButton(String value) {
    return TextButton(
      onPressed: () => _onNumberPressed(value),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue, // Set text color to blue
        ),
      ),
    );
  }

  // Operator button widget with blue text
  Widget _buildOperatorButton(String value) {
    return TextButton(
      onPressed: () {
        if (value == 'C') {
          _onClearPressed();
        } else {
          _onOperatorPressed(value);
        }
      },
      child: Text(
        value,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue, // Set text color to blue
        ),
      ),
    );
  }

  // Calculate button widget with blue text
  Widget _buildCalculateButton() {
    return TextButton(
      onPressed: () => _onCalculatePressed(),
      child: Text(
        '=',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue, // Set text color to blue
        ),
      ),
    );
  }
}
