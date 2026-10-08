import 'package:flutter/material.dart';

class Easy02IconListTileScreen extends StatelessWidget {
  const Easy02IconListTileScreen({super.key});

  final List<Map<String, dynamic>> items = const [
    {'title': 'Home Screen', 'icon': Icons.home, 'subtitle': 'Main dashboard'},
    {'title': 'User Profile', 'icon': Icons.person, 'subtitle': 'View profile details'},
    {'title': 'Settings', 'icon': Icons.settings, 'subtitle': 'App preferences'},
    {'title': 'Notifications', 'icon': Icons.notifications, 'subtitle': 'Recent alerts'},
    {'title': 'Favorites', 'icon': Icons.favorite, 'subtitle': 'Saved items'},
    {'title': 'Help & Support', 'icon': Icons.help, 'subtitle': 'Get assistance'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy 2: ListTile with Icon'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: Icon(item['icon'] as IconData, color: Theme.of(context).primaryColor),
              title: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(item['subtitle'] as String),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
