import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const DiceApp());

class DiceApp extends StatelessWidget {
  const DiceApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dice App'),
        ),
        body: const DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key});

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  List<int> rollHistory = [];

  void rollDice() {
    final left = Random().nextInt(6) + 1;
    final right = Random().nextInt(6) + 1;
    setState(() {
      leftDiceNumber = left;
      rightDiceNumber = right;
      rollHistory.add(left + right);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: rollDice,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).hintColor,
                          width: 10.0,
                        ),
                      ),
                      width: 195,
                      height: 195,
                      child: Image.asset('ios/images/dice$leftDiceNumber.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: rollDice,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).hintColor,
                          width: 10.0,
                        ),
                      ),
                      width: 195,
                      height: 195,
                      child: Image.asset('ios/images/dice$rightDiceNumber.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'History: $rollHistory',
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 20,
              ),
            ),
            Text(
              'Dice Statistics: Average: ${calculateAverage(rollHistory).toStringAsFixed(2)}, Max: ${calculateMax(rollHistory)}',
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateAverage(List<int> list) {
    if (list.isEmpty) return 0;
    return list.reduce((a, b) => a + b) / list.length;
  }

  int calculateMax(List<int> list) {
    if (list.isEmpty) return 0;
    return list.reduce((a, b) => a > b ? a : b);
  }
}