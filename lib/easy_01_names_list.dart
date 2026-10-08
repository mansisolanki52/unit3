import 'package:flutter/material.dart';

class Easy01NamesListScreen extends StatelessWidget {
  const Easy01NamesListScreen({super.key});

  final List<String> names = const [
    'Aarav Sharma',
    'Vivaan Patel',
    'Aditya Verma',
    'Vihaan Gupta',
    'Arjun Mehta',
    'Sai Kumar',
    'Reyansh Joshi',
    'Ayaan Singh',
    'Krishna Nair',
    'Ishaan Bhatia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy 1: Fixed Names List'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                names[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
