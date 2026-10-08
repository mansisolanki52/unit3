import 'package:flutter/material.dart';

class Student {
  final String name;
  final int rollNo;
  final double marks;

  Student({
    required this.name,
    required this.rollNo,
    required this.marks,
  });
}

class Moderate03HomeScreen extends StatefulWidget {
  const Moderate03HomeScreen({super.key});

  @override
  State<Moderate03HomeScreen> createState() => _Moderate03HomeScreenState();
}

class _Moderate03HomeScreenState extends State<Moderate03HomeScreen> {
  final _nameController = TextEditingController(text: 'Rahul Sharma');
  final _rollController = TextEditingController(text: '101');
  final _marksController = TextEditingController(text: '88.5');

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _marksController.dispose();
    super.dispose();
  }

  void _navigateToDetail() {
    final student = Student(
      name: _nameController.text,
      rollNo: int.tryParse(_rollController.text) ?? 0,
      marks: double.tryParse(_marksController.text) ?? 0.0,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Moderate03DetailScreen(student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderate 3: Pass Student Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _rollController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _marksController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Marks',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _navigateToDetail,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Send to Detail Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class Moderate03DetailScreen extends StatelessWidget {
  final Student student;

  const Moderate03DetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    child: Icon(Icons.school, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 30),
                  ListTile(
                    leading: const Icon(Icons.format_list_numbered),
                    title: const Text('Roll Number'),
                    trailing: Text(
                      '${student.rollNo}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.grade),
                    title: const Text('Marks'),
                    trailing: Text(
                      '${student.marks}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
