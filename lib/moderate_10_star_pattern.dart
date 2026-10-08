import 'package:flutter/material.dart';

class Moderate10StarPatternScreen extends StatefulWidget {
  const Moderate10StarPatternScreen({super.key});

  @override
  State<Moderate10StarPatternScreen> createState() =>
      _Moderate10StarPatternScreenState();
}

class _Moderate10StarPatternScreenState
    extends State<Moderate10StarPatternScreen> {
  final TextEditingController _numberController = TextEditingController(text: '5');
  int _rowsCount = 5;

  void _generatePattern() {
    final val = int.tryParse(_numberController.text.trim()) ?? 0;
    setState(() {
      _rowsCount = val > 0 ? val : 0;
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate 10: Star Pattern Printer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter number of rows (N)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _generatePattern,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                  child: const Text('Generate'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _rowsCount <= 0
                    ? const Center(
                        child: Text(
                          'Enter a number greater than 0',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(_rowsCount, (index) {
                            final stars = '*' * (index + 1);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                stars,
                                style: const TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 20,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
