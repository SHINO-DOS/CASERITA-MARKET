import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:caserita_market/features/auth/controllers/auth_controller.dart';

class RegisterProductScreen extends StatefulWidget {
  const RegisterProductScreen({super.key});

  @override
  State<RegisterProductScreen> createState() => _RegisterProductScreenState();
}

class _RegisterProductScreenState extends State<RegisterProductScreen> {
  final _productoController = TextEditingController();
  final _precioController = TextEditingController();
  final _ubicacionController = TextEditingController();
  bool _isLoading = false;
  bool _fotoTomada = false;

  void _subirProducto() async {
    // 🔥 CORREGIDO: Bloque if encerrado en llaves estructuradas
    if (_productoController.text.isEmpty || _precioController.text.isEmpty) {
      return;
    }
    setState(() => _isLoading = true);

    final auth = Provider.of<AuthController>(context, listen: false);

    await FirebaseFirestore.instance.collection('productos').add({
      'productorId': auth.currentUid,
      'producto': _productoController.text,
      'precio': double.tryParse(_precioController.text) ?? 0.0,
      'ubicacion': _ubicacionController.text,
      'fecha': Timestamp.now(),
    });

    // 🔥 CORREGIDO: Bloque if encerrado en llaves estructuradas
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = false;
      _fotoTomada = false;
      _productoController.clear();
      _precioController.clear();
      _ubicacionController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Producto publicado en el mercado!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vender Producto'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setState(() => _fotoTomada = true),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.orange,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _fotoTomada
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.orange,
                          ),
                          Text('Tocar para tomar foto del producto'),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _productoController,
              decoration: const InputDecoration(
                labelText: '¿Qué vendes? (Ej. Papa Imilla)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio (Bs.)',
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ubicacionController,
              decoration: const InputDecoration(
                labelText: 'Ubicación / Mercado',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _subirProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Publicar Oferta',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
