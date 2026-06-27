import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product_model.dart';
import '../controllers/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  Future<void> _launchMap() async {
    final Uri url = Uri.parse(product.mapaEnlace);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("No se pudo abrir el mapa");
    }
  }

  @override
  Widget build(BuildContext context) {
    final precioHistorico = ProductController.getPrecioReferencial(
      product.producto,
    );
    final alerta = ProductController.calcularAlertaEspeculacion(product);

    return Scaffold(
      appBar: AppBar(title: Text(product.producto.toUpperCase())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: (alerta['color'] as Color).withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: alerta['color'], size: 32),
                    const SizedBox(width: 12),
                    Text(
                      alerta['label'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: alerta['color'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Detalles del Reporte",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text("Precio Reportado"),
              trailing: Text(
                "Bs. ${product.precio}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Precio Referencial Histórico"),
              trailing: Text(
                "Bs. $precioHistorico",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits),
              title: const Text("Stock Disponible"),
              trailing: Text("${product.cantidad} ${product.unidad}"),
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text("Mercado / Zona"),
              trailing: Text(product.ubicacion),
            ),
            const Spacer(),
            if (product.mapaEnlace.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _launchMap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.location_on),
                  label: const Text('Cómo llegar (Ver en Google Maps)'),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
