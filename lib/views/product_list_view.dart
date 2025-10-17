import 'package:catalogo_online/viewmodel/product_view_model.dart';
import 'package:catalogo_online/views/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo Online')),
      body: SafeArea(child: _buildBody(context, productViewModel)),
    );
  }

  Widget _buildBody(BuildContext context, ProductViewModel productViewModel) {
    switch (productViewModel.state) {
      case ViewState.busy:
        return const Center(child: CircularProgressIndicator());
      case ViewState.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 12),
                Text(
                  'Erro ao carregar produtos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 80),
                Text(
                  productViewModel.errorMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => productViewModel.fetchProducts(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar novamente'),
                ),
              ],
            ),
          ),
        );
      case ViewState.idle:
        defauld:
        if (productViewModel.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Nenhum produto encontrado.'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => productViewModel.fetchProducts(),
                  child: const Text('Recarregar'),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: productViewModel.products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final p = productViewModel.products[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailView(product: p),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: ClipRRect(

                        )

                      )
                    ]
                  ),
                ),
              ),
            );
          },
        );
    }
  }
}
