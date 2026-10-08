import 'package:flutter/material.dart';

class Easy07CounterSetStateScreen extends StatefulWidget {
  const Easy07CounterSetStateScreen({super.key});

  @override
  State<Easy07CounterSetStateScreen> createState() =>
      _Easy07CounterSetStateScreenState();
}

class _Easy07CounterSetStateScreenState
    extends State<Easy07CounterSetStateScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy 7: setState() Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Counter Value:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'decrement_btn',
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  backgroundColor: Colors.redAccent,
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                const SizedBox(width: 24),
                FloatingActionButton(
                  heroTag: 'increment_btn',
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
