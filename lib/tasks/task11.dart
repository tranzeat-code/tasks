import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/product.dart';
// import http
import 'package:http/http.dart' as http;

// Product List Screen
class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProducts;

  // Function to Fetch Products
  Future<List<Product>> fetchAllProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  @override
  void initState() {
    super.initState();
    futureProducts = fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products available"));
          }

          List<Product> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(products[index].image ?? "",
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(products[index].title ?? "No Title"),
                  subtitle:
                      Text("\$${products[index].price?.toStringAsFixed(2)}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      Text(products[index].rating?.rate?.toStringAsFixed(1) ??
                          "N/A"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
