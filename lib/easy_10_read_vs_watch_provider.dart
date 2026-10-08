import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void reset() {
    _value = 0;
    notifyListeners();
  }
}

class Easy10ReadVsWatchProviderScreen extends StatelessWidget {
  const Easy10ReadVsWatchProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Easy 10: context.read vs context.watch'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Card(
                color: Colors.amberAccent,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Demonstration:\n'
                    '• context.watch<T>() listens to state changes and rebuilds the widget when state updates.\n'
                    '• context.read<T>() reads state once without subscribing to updates. Perfect inside callbacks/onPressed!',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const DisplayWithWatchWidget(),
              const SizedBox(height: 24),
              const ButtonsWithReadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayWithWatchWidget extends StatelessWidget {
  const DisplayWithWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch subscribes this widget to rebuilds
    final counter = context.watch<CounterProvider>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        children: [
          const Text(
            'Widget using context.watch<CounterProvider>()',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Value: ${counter.value}',
            style: const TextStyle(fontSize: 32, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class ButtonsWithReadWidget extends StatelessWidget {
  const ButtonsWithReadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Buttons using context.read<CounterProvider>() inside onPressed:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // context.read gets reference without causing rebuild here
                context.read<CounterProvider>().increment();
              },
              child: const Text('Increment (context.read)'),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {
                context.read<CounterProvider>().reset();
              },
              child: const Text('Reset (context.read)'),
            ),
          ],
        ),
      ],
    );
  }
}
