import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Contents'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          final productName = product['name'];
          final productPrice = product['price'];
          final productQuantity = product['quantity']; // Get product quantity

          return ListTile(
            title: Text('Product: $productName'),
            subtitle: Text('Price: \$${productPrice.toStringAsFixed(2)}'),
            trailing:
                Text('Quantity: $productQuantity'), // Display product quantity
          );
        },
      ),
      bottomSheet: _buildTotalCostWidget(),
    );
  }

  Widget _buildTotalCostWidget() {
    double totalCost = 0;

    for (final product in cart) {
      final productPrice = product['price'];
      final productQuantity = product['quantity'];
      totalCost += productPrice * productQuantity; // Calculate total cost
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Total Cost: \$${totalCost.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
