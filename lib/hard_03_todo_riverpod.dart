import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Todo copyWith({String? id, String? title, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [
      Todo(id: '1', title: 'Learn Riverpod StateNotifier'),
      Todo(id: '2', title: 'Build Todo App with Riverpod'),
    ];
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    state = [
      ...state,
      Todo(id: DateTime.now().toString(), title: title.trim()),
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isCompleted: !todo.isCompleted) else todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoListProvider =
    NotifierProvider<TodoNotifier, List<Todo>>(TodoNotifier.new);

class Hard03TodoRiverpodApp extends StatelessWidget {
  const Hard03TodoRiverpodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Hard03TodoRiverpodScreen(),
      ),
    );
  }
}

class Hard03TodoRiverpodScreen extends ConsumerStatefulWidget {
  const Hard03TodoRiverpodScreen({super.key});

  @override
  ConsumerState<Hard03TodoRiverpodScreen> createState() =>
      _Hard03TodoRiverpodScreenState();
}

class _Hard03TodoRiverpodScreenState
    extends ConsumerState<Hard03TodoRiverpodScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 3: Riverpod Todo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'New Riverpod Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    ref.read(todoListProvider.notifier).addTodo(_controller.text);
                    _controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: todos.isEmpty
                  ? const Center(child: Text('No Riverpod tasks found'))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (_) {
                                ref
                                    .read(todoListProvider.notifier)
                                    .toggleTodo(todo.id);
                              },
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref
                                    .read(todoListProvider.notifier)
                                    .removeTodo(todo.id);
                              },
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
