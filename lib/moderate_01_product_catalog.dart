import 'package:flutter/material.dart';

class Moderate01ProductCatalogScreen extends StatelessWidget {
  const Moderate01ProductCatalogScreen({super.key});

  final List<Map<String, dynamic>> products = const [
    {'name': 'Laptop', 'price': '\$999', 'icon': Icons.laptop},
    {'name': 'Smartphone', 'price': '\$699', 'icon': Icons.phone_android},
    {'name': 'Headphones', 'price': '\$199', 'icon': Icons.headphones},
    {'name': 'Smartwatch', 'price': '\$249', 'icon': Icons.watch},
    {'name': 'Camera', 'price': '\$549', 'icon': Icons.camera_alt},
    {'name': 'Tablet', 'price': '\$449', 'icon': Icons.tablet},
    {'name': 'Speaker', 'price': '\$129', 'icon': Icons.speaker},
    {'name': 'Keyboard', 'price': '\$89', 'icon': Icons.keyboard},
    {'name': 'Monitor', 'price': '\$299', 'icon': Icons.desktop_windows},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate 1: Product Catalog (3 Cols)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final item = products[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        size: 32,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['price'] as String,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
