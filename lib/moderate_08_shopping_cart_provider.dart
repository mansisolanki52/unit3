import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String id;
  final String name;
  final double price;

  const CartItem({required this.id, required this.name, required this.price});
}

class ShoppingCartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.price);

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class Moderate08ShoppingCartScreen extends StatelessWidget {
  const Moderate08ShoppingCartScreen({super.key});

  final List<CartItem> catalog = const [
    CartItem(id: '1', name: 'Running Shoes', price: 79.99),
    CartItem(id: '2', name: 'Leather Bag', price: 120.50),
    CartItem(id: '3', name: 'Wireless Mouse', price: 25.00),
    CartItem(id: '4', name: 'Fitness Band', price: 49.90),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShoppingCartProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Moderate 8: Shopping Cart Provider'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Available Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catalog.length,
                itemBuilder: (context, index) {
                  final product = catalog[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.green)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ShoppingCartProvider>().addItem(product);
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 30, thickness: 2),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Shopping Cart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Consumer<ShoppingCartProvider>(
                builder: (context, cart, child) {
                  if (cart.items.isEmpty) {
                    return const Center(child: Text('Cart is empty'));
                  }
                  return ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(item.name),
                        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cart.removeItem(index),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Consumer<ShoppingCartProvider>(
              builder: (context, cart, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      if (cart.items.isNotEmpty)
                        ElevatedButton(
                          onPressed: () => cart.clearCart(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Clear Cart'),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
