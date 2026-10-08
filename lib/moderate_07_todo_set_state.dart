import 'package:flutter/material.dart';

class Moderate07TodoSetStateScreen extends StatefulWidget {
  const Moderate07TodoSetStateScreen({super.key});

  @override
  State<Moderate07TodoSetStateScreen> createState() =>
      _Moderate07TodoSetStateScreenState();
}

class _Moderate07TodoSetStateScreenState
    extends State<Moderate07TodoSetStateScreen> {
  final List<String> _todos = [
    'Buy Groceries',
    'Complete Flutter Practical',
    'Call Friend',
  ];
  final TextEditingController _taskController = TextEditingController();

  void _addTodo() {
    final text = _taskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(text);
        _taskController.clear();
      });
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate 7: To-Do App (setState)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'New Task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _todos.isEmpty
                  ? const Center(
                      child: Text('No tasks remaining! Add some above.'),
                    )
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(_todos[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTodo(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
