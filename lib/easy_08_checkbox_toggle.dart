import 'package:flutter/material.dart';

class Easy08CheckboxToggleScreen extends StatefulWidget {
  const Easy08CheckboxToggleScreen({super.key});

  @override
  State<Easy08CheckboxToggleScreen> createState() =>
      _Easy08CheckboxToggleScreenState();
}

class _Easy08CheckboxToggleScreenState
    extends State<Easy08CheckboxToggleScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy 8: Checkbox Toggle'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: const Text(
                    'Accept Terms and Conditions',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isChecked ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _isChecked ? 'Status: Checked' : 'Status: Unchecked',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isChecked ? Colors.green.shade900 : Colors.red.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
