import 'package:catalogo_online/model/product_model.dart';
import 'package:catalogo_online/service/product_service.dart';
import 'package:flutter/foundation.dart';

enum ViewState { idle, busy, error }

class ProductViewModel extends ChangeNotifier {
  final ProductService service;
  List<Product> _products = [];
  String _errorMessage = '';
  ViewState _state = ViewState.idle;

  ProductViewModel({required this.service});

  List<Product> get products => _products;

  String get errorMessage => _errorMessage;

  ViewState get state => _state;

  Future<void> fetchProducts() async {
    _state = ViewState.busy;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await service.fetchProducts();
      _products = result;
      _state = ViewState.idle;
      notifyListeners();
    } catch (e) {
      _state = ViewState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
