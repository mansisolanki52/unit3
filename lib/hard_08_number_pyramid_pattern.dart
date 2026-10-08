import 'package:flutter/material.dart';

class Hard08NumberPyramidPatternScreen extends StatefulWidget {
  const Hard08NumberPyramidPatternScreen({super.key});

  @override
  State<Hard08NumberPyramidPatternScreen> createState() =>
      _Hard08NumberPyramidPatternScreenState();
}

class _Hard08NumberPyramidPatternScreenState
    extends State<Hard08NumberPyramidPatternScreen> {
  final TextEditingController _inputController = TextEditingController(text: '5');
  int _pyramidHeight = 5;

  void _generatePyramid() {
    final val = int.tryParse(_inputController.text.trim()) ?? 0;
    setState(() {
      _pyramidHeight = val > 0 ? val : 0;
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  // Generates number sequence for row i (1-based): e.g., for i=3 => 1 2 3 2 1 or 1 2 3
  String _getRowNumbers(int row) {
    List<int> nums = [];
    for (int i = 1; i <= row; i++) {
      nums.add(i);
    }
    for (int i = row - 1; i >= 1; i--) {
      nums.add(i);
    }
    return nums.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 8: Number Pyramid Pattern'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter Pyramid Height (N)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _generatePyramid,
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
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _pyramidHeight <= 0
                    ? const Center(
                        child: Text(
                          'Please enter N > 0',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(_pyramidHeight, (index) {
                            final rowNum = index + 1;
                            final rowText = _getRowNumbers(rowNum);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade700,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  rowText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
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
