import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'cart_page.dart'; // Import the CartPage widget
import 'package:badges/badges.dart' as badges;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> cart = [];
  int cartItemCount = 0; // Initialize the cart item count

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        actions: [
          badges.Badge(
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              borderRadius: BorderRadius.circular(1.3),
            ),
            position: badges.BadgePosition.bottomEnd(bottom: 30, end: 14),
            badgeContent: Text(
              cartItemCount.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              iconSize: 35,
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(cart: cart)),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("User Name"), // Replace with user's name
              accountEmail:
                  Text("user@example.com"), // Replace with user's email
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Implement the profile option
                // Navigator.pushNamed(context, '/profile');
                // Close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Orders'),
              onTap: () {
                // Implement the orders option
                // Navigator.pushNamed(context, '/orders');
                // Close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Implement the logout option
                // Call your logout function
                // Close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            _scanBarcode(context);
          },
          icon: const Icon(Icons.qr_code_rounded),
          label: const Text('Scan Barcode'),
        ),
      ),
    );
  }

  void _scanBarcode(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      false,
      ScanMode.BARCODE,
    );

    // ignore: use_build_context_synchronously
    _showProductInfoDialog(context, barcodeScanRes);
  }

  void _showProductInfoDialog(BuildContext context, String barcode) {
    String productName;
    double productPrice;

    // Dummy mapping of barcode to product information
    if (barcode == '123456789') {
      productName = 'Bisket';
      productPrice = 13.0;
    } else if (barcode == '987654321') {
      productName = 'Example Product';
      productPrice = 20.0;
    } else if (barcode == '8901058000290') {
      productName = 'prod1_magg';
      productPrice = 1.0;
    } else if (barcode == '8901972058650') {
      productName = 'prod2_waf';
      productPrice = 5.0;
    } else {
      productName = 'Default';
      productPrice = 15.0;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(productName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Barcode Number: $barcode'),
              Text('Price: \$${productPrice.toStringAsFixed(2)}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add to Cart'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _addProductToCart(productName, productPrice);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _addProductToCart(String productName, double productPrice) {
    int existingProductIndex =
        cart.indexWhere((product) => product['name'] == productName);

    if (existingProductIndex != -1) {
      // Product is already in the cart, update its quantity
      setState(() {
        cart[existingProductIndex]['quantity'] =
            (cart[existingProductIndex]['quantity'] ?? 0) + 1;
      });
    } else {
      // Product is not in the cart, add it with quantity 1
      setState(() {
        cart.add({
          'name': productName,
          'price': productPrice,
          'quantity': 1,
        });
      });
    }
    setState(() {
      cartItemCount += 1;
    });

    // Show a dialog when a product is added to the cart
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Product Added to Cart'),
    //       content: Text('You added $productName to your cart.'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: const Text('Close'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
