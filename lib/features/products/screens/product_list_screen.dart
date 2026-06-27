import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Precios Hoy'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('productos')
            .orderBy('fecha', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // 🔥 CORREGIDO: Bloque if encerrado en llaves estructuradas
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;

          // 🔥 CORREGIDO: Bloque if encerrado en llaves estructuradas
          if (docs.isEmpty) {
            return const Center(
              child: Text('No hay productos aún en el mercado.'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final prod = docs[index].data() as Map<String, dynamic>;
              final isCaro = (prod['precio'] ?? 0) > 70;

              return Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: isCaro ? Colors.red.shade200 : Colors.green.shade200,
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isCaro
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                    child: Icon(
                      Icons.shopping_bag,
                      color: isCaro ? Colors.red : Colors.green,
                    ),
                  ),
                  title: Text(
                    prod['producto'] ?? 'Producto',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '📍 ${prod['ubicacion'] ?? 'Mercado'} - Caserita: ${prod['nombreProductor'] ?? 'Anónimo'}',
                  ),
                  trailing: Text(
                    'Bs. ${prod['precio']}',
                    style: TextStyle(
                      color: isCaro ? Colors.red : Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
