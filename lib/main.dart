import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      title: 'Calculator',
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool _isDark = false;
  Color operatorColor = operatorColorLight;
  Color buttonColor = buttonColorLight;
  Color textColor = Colors.black;
  var input = '';
  var output = '';
  var operation = '';

  void isDark() {
    _isDark = !_isDark;
    if (_isDark) {
      operatorColor = operatorColorDark;
      buttonColor = buttonColorDark;
      textColor = Colors.white;
    } else {
      operatorColor = operatorColorLight;
      buttonColor = buttonColorLight;
      textColor = Colors.black;
    }
    setState(() {});
  }

  onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        if (input.contains('%')) {
          List<String> split = input.split('%');
          var result = (double.parse(split[0]) / 100) * double.parse(split[1]);
          output = result.toString();
        } else {
          Parser parser = Parser();
          Expression expression = parser.parse(input);
          ContextModel contextModel = ContextModel();
          output =
              expression.evaluate(EvaluationType.REAL, contextModel).toString();
        }
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      }
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDark ? Colors.black : Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 5, right: 5),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calculator',
                  style: TextStyle(
                    color: _isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                // Icon(Icons.sunny),
                IconButton(
                    onPressed: isDark,
                    icon: Icon(
                      _isDark ? Icons.sunny : Icons.nightlight_round_rounded,
                      color: _isDark ? Colors.yellowAccent : Colors.deepOrange,
                      size: 30,
                    ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(
                      color: _isDark ? Colors.white : Colors.black,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    output,
                    style: TextStyle(
                      color: _isDark
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Row(
            children: [
              ItemButton(
                  text: 'AC',
                  buttonBgColor: operatorColor,
                  textColor: orangeColor),
              ItemButton(
                  text: '<',
                  buttonBgColor: operatorColor,
                  textColor: orangeColor),
              ItemButton(
                  text: '❓',
                  buttonBgColor: _isDark ? Colors.transparent : Colors.white),
              ItemButton(
                text: '/',
                textColor: orangeColor,
                buttonBgColor: operatorColor,
              ),
            ],
          ),
          Row(
            children: [
              ItemButton(
                text: '7',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '8',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '9',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                  text: '*',
                  buttonBgColor: operatorColor,
                  textColor: orangeColor),
            ],
          ),
          Row(
            children: [
              ItemButton(
                text: '4',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '5',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '6',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                  text: '-',
                  buttonBgColor: operatorColor,
                  textColor: orangeColor),
            ],
          ),
          Row(
            children: [
              ItemButton(
                text: '1',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '2',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '3',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                  text: '+',
                  buttonBgColor: operatorColor,
                  textColor: orangeColor),
            ],
          ),
          Row(
            children: [
              ItemButton(
                  text: '%',
                  buttonBgColor: operatorColor,
                  textColor: orangeColor),
              ItemButton(
                text: '0',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(
                text: '.',
                textColor: textColor,
                buttonBgColor: buttonColor,
              ),
              ItemButton(text: '=', buttonBgColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ItemButton({text, textColor, buttonBgColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => onButtonClick(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
