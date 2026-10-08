import 'package:flutter/material.dart';

class Moderate04HomeScreen extends StatefulWidget {
  const Moderate04HomeScreen({super.key});

  @override
  State<Moderate04HomeScreen> createState() => _Moderate04HomeScreenState();
}

class _Moderate04HomeScreenState extends State<Moderate04HomeScreen> {
  String _receivedData = 'No data returned yet';

  Future<void> _openDetailAndGetData() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Moderate04DetailScreen(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _receivedData = result.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Received from DetailScreen: $result'),
          backgroundColor: Colors.teal,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate 4: Pop Data & SnackBar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Data: $_receivedData',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _openDetailAndGetData,
              child: const Text('Go to Detail Screen & Get Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class Moderate04DetailScreen extends StatefulWidget {
  const Moderate04DetailScreen({super.key});

  @override
  State<Moderate04DetailScreen> createState() => _Moderate04DetailScreenState();
}

class _Moderate04DetailScreenState extends State<Moderate04DetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter feedback/message to return',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                final message = _controller.text.isEmpty
                    ? 'Default Data Success!'
                    : _controller.text;
                Navigator.pop(context, message);
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Back via Navigator.pop()'),
            ),
          ],
        ),
      ),
    );
  }
}
