import 'package:flutter/material.dart';

class Hard05ListGridToggleScreen extends StatefulWidget {
  const Hard05ListGridToggleScreen({super.key});

  @override
  State<Hard05ListGridToggleScreen> createState() =>
      _Hard05ListGridToggleScreenState();
}

class _Hard05ListGridToggleScreenState
    extends State<Hard05ListGridToggleScreen> {
  bool _isGridView = false;

  final List<Map<String, String>> _items = List.generate(
    12,
    (index) => {
      'title': 'Item #${index + 1}',
      'description': 'Description for item number ${index + 1}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isGridView ? 'Grid View Mode' : 'List View Mode'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: 'Toggle View Mode',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isGridView ? _buildGridView() : _buildListView(),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      key: const ValueKey('ListView'),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text('${index + 1}',
                  style: const TextStyle(color: Colors.white)),
            ),
            title: Text(item['title']!),
            subtitle: Text(item['description']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      key: const ValueKey('GridView'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.1,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          elevation: 3,
          color: Colors.teal.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 20,
                  child: Text('${index + 1}',
                      style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text(
                  item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
