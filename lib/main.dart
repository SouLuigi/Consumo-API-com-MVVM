import 'package:catalogo_online/service/product_service.dart';
import 'package:catalogo_online/viewmodel/product_view_model.dart';
import 'package:catalogo_online/views/catalog_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ProductViewModel(service: ProductService())..fetchProducts(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CatalogApp());
  }
}
