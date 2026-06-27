import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../controllers/product_controller.dart';
import '../screens/product_detail_screen.dart';

class PriceCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onMapPressed;

  const PriceCard({super.key, required this.product, this.onMapPressed});

  @override
  Widget build(BuildContext context) {
    final alert = ProductController.calcularAlertaEspeculacion(product);
    final Color statusColor = alert['color'];
    final String statusLabel = alert['label'];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.producto.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      statusLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Cantidad: ${product.cantidad} ${product.unidad}",
                style: const TextStyle(color: Colors.grey),
              ),
              Text("Mercado: ${product.ubicacion} - ${product.ciudad}"),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bs. ${product.precio}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  if (product.mapaEnlace.isNotEmpty && onMapPressed != null)
                    IconButton(
                      icon: const Icon(Icons.map, color: Colors.blue),
                      onPressed: onMapPressed,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
