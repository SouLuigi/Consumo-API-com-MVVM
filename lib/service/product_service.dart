import 'dart:convert';

import 'package:catalogo_online/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService{
  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async{
    final uri = Uri.parse('$baseUrl/products');
    final response = await http.get(uri);

    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    }else{
      throw Exception('Falha ao carregar produtos: ${response.statusCode}');
    }
  }
}