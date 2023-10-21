import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main_page.dart';
import 'cart_page.dart'; // Import the CartPage widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cart = []; // Create an empty cart list

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => LoginPage(), // Define a named route for LoginPage
        '/main': (context) =>
            const MainPage(), // Define a named route for MainPage
        '/cart': (context) => CartPage(cart: cart), // Pass the cart parameter
      },
    );
  }
}
